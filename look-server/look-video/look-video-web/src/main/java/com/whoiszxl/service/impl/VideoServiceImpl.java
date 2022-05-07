package com.whoiszxl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.whoiszxl.bean.PageQuery;
import com.whoiszxl.cqrs.command.LikeCommand;
import com.whoiszxl.cqrs.command.VideoSaveCommand;
import com.whoiszxl.cqrs.query.MemberTimelineQuery;
import com.whoiszxl.cqrs.response.VideoResponse;
import com.whoiszxl.dozer.DozerUtils;
import com.whoiszxl.dto.MemberDTO;
import com.whoiszxl.entity.Video;
import com.whoiszxl.enums.LikeTypeEnum;
import com.whoiszxl.enums.VideoCounterStatusEnum;
import com.whoiszxl.feign.MemberApiClient;
import com.whoiszxl.mapper.VideoMapper;
import com.whoiszxl.service.VideoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.whoiszxl.strategy.LikeFactory;
import com.whoiszxl.utils.AuthUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 视频表 服务实现类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Service
public class VideoServiceImpl extends ServiceImpl<VideoMapper, Video> implements VideoService {

    @Autowired
    private DozerUtils dozerUtils;

    @Autowired
    private LikeFactory likeFactory;

    @Autowired
    private MemberApiClient memberApiClient;

    @Override
    public boolean saveVideo(VideoSaveCommand videoSaveCommand) {
        Video video = dozerUtils.map(videoSaveCommand, Video.class);
        Long memberId = AuthUtils.getMemberId();
        video.setMemberId(memberId);
        return this.save(video);
    }

    @Override
    public void like(Long videoId) {
        Long memberId = AuthUtils.getMemberId();

        LikeCommand likeCommand = new LikeCommand();
        likeCommand.setId(videoId);
        likeCommand.setMemberId(memberId);
        likeCommand.setLikeType(LikeTypeEnum.VIDEO.getCode());
        likeCommand.setStatus(VideoCounterStatusEnum.INCR.getCode());

        likeFactory.getLikeStrategy(likeCommand.getLikeType()).like(likeCommand);
    }

    @Override
    public void disLike(Long videoId) {
        Long memberId = AuthUtils.getMemberId();

        LikeCommand likeCommand = new LikeCommand();
        likeCommand.setId(videoId);
        likeCommand.setMemberId(memberId);
        likeCommand.setLikeType(LikeTypeEnum.VIDEO.getCode());
        likeCommand.setStatus(VideoCounterStatusEnum.DECR.getCode());

        likeFactory.getLikeStrategy(likeCommand.getLikeType()).like(likeCommand);
    }


    /**
     * 使用pull+push结合的模式
     *
     * 1. 先读取关注的热点用户列表，循环获取其timeline中的前10条视频
     * 2. 同时读取自己的收件箱视频列表
     * 3. 合并上述获取的列表，并按时间排序返回
     *
     * 广告实现：
     * 1. 通过大数据实时分析用户标签，比如说：单机游戏，粤语流行乐
     * 2. 推广客户创建出对应的账号，如：泰拉瑞亚官方账号
     * 3. 将具有对应标签的用户隐性关注此推广账号
     * 4. 此时广告视频也会存在与用户的feed推荐流里
     * @param pageQuery
     * @return
     */
    @Override
    public IPage<VideoResponse> attentionFeedList(PageQuery pageQuery) {
        return null;
    }

    @Override
    public IPage<VideoResponse> recommendFeedList(PageQuery pageQuery) {
        //TODO 推荐实现
        LambdaQueryWrapper<Video> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.orderByDesc(Video::getCreatedAt);
        Page<Video> videoPage = this.page(new Page<>(pageQuery.getPage(), pageQuery.getSize()), lambdaQueryWrapper);

        if(videoPage.getRecords().isEmpty()) {
            return null;
        }

        List<Long> memberIdList = videoPage.getRecords().stream().map(Video::getMemberId).distinct().collect(Collectors.toList());
        List<MemberDTO> memberDTOList = memberApiClient.findMemberInfoByIds(memberIdList);


        return videoPage.convert(video -> {
            VideoResponse videoResponse = dozerUtils.map(video, VideoResponse.class);
            MemberDTO memberDTO = memberDTOList.stream().filter(e -> e.getId().equals(videoResponse.getMemberId())).findAny().get();
            videoResponse.setMemberId(memberDTO.getId());
            videoResponse.setAvatar(memberDTO.getAvatar());
            videoResponse.setNickname(memberDTO.getNickname());

            videoResponse.setLickCount(likeFactory.getLikeStrategy(LikeTypeEnum.VIDEO.getCode()).getLikeCount(video.getId()));
            videoResponse.setCommentCount(likeFactory.getLikeStrategy(LikeTypeEnum.COMMENT.getCode()).getLikeCount(video.getId()));
            videoResponse.setShareCount(567);

            return videoResponse;
        });
    }

    @Override
    public IPage<VideoResponse> timeline(MemberTimelineQuery memberTimelineQuery) {
        Long currentMemberId = AuthUtils.getMemberId();
        Long finalCurrentMemberId = currentMemberId;

        LambdaQueryWrapper<Video> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.orderByDesc(Video::getCreatedAt);
        lambdaQueryWrapper.eq(Video::getMemberId, memberTimelineQuery.getMemberId());
        Page<Video> videoPage = this.page(new Page<>(memberTimelineQuery.getPage(), memberTimelineQuery.getSize()), lambdaQueryWrapper);
        if(videoPage.getRecords().isEmpty()) {
            return null;
        }

        List<Long> memberIdList = videoPage.getRecords().stream().map(Video::getMemberId).distinct().collect(Collectors.toList());
        List<MemberDTO> memberDTOList = memberApiClient.findMemberInfoByIds(memberIdList);

        return videoPage.convert(video -> {
            VideoResponse videoResponse = dozerUtils.map(video, VideoResponse.class);
            MemberDTO memberDTO = memberDTOList.stream().filter(e -> e.getId().equals(videoResponse.getMemberId())).findAny().get();
            videoResponse.setMemberId(memberDTO.getId());
            videoResponse.setAvatar(memberDTO.getAvatar());
            videoResponse.setNickname(memberDTO.getNickname());

            //TODO 设置计数器
            videoResponse.setLickCount(likeFactory.getLikeStrategy(LikeTypeEnum.VIDEO.getCode()).getLikeCount(video.getId()));
            videoResponse.setCommentCount(likeFactory.getLikeStrategy(LikeTypeEnum.COMMENT.getCode()).getLikeCount(video.getId()));
            videoResponse.setShareCount(567);

            //设置是否点赞过
            Integer hasLiked = likeFactory.getLikeStrategy(LikeTypeEnum.VIDEO.getCode()).isLike(video.getId(), finalCurrentMemberId);
            videoResponse.setHasLiked(hasLiked);

            return videoResponse;
        });
    }

    @Override
    public VideoResponse getVideoById(String videoId) {
        Video video = this.getOne(Wrappers.<Video>lambdaQuery().eq(Video::getId, videoId));

        List<Long> params = new ArrayList<>();
        params.add(video.getMemberId());
        List<MemberDTO> memberDTOList = memberApiClient.findMemberInfoByIds(params);

        VideoResponse videoResponse = dozerUtils.map(video, VideoResponse.class);

        MemberDTO memberDTO = memberDTOList.get(0);
        videoResponse.setMemberId(memberDTO.getId());
        videoResponse.setAvatar(memberDTO.getAvatar());
        videoResponse.setNickname(memberDTO.getNickname());

        videoResponse.setLickCount(likeFactory.getLikeStrategy(LikeTypeEnum.VIDEO.getCode()).getLikeCount(video.getId()));
        videoResponse.setCommentCount(likeFactory.getLikeStrategy(LikeTypeEnum.COMMENT.getCode()).getLikeCount(video.getId()));
        videoResponse.setShareCount(567);

        return videoResponse;
    }
}
