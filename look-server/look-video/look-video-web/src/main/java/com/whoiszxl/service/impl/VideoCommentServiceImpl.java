package com.whoiszxl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.whoiszxl.cqrs.command.LikeCommand;
import com.whoiszxl.cqrs.command.PublishCommentCommand;
import com.whoiszxl.cqrs.dto.VideoCommentDTO;
import com.whoiszxl.cqrs.query.CommentListQuery;
import com.whoiszxl.dozer.DozerUtils;
import com.whoiszxl.dto.MemberDTO;
import com.whoiszxl.entity.VideoComment;
import com.whoiszxl.enums.LikeTypeEnum;
import com.whoiszxl.enums.VideoCounterStatusEnum;
import com.whoiszxl.feign.MemberApiClient;
import com.whoiszxl.mapper.VideoCommentMapper;
import com.whoiszxl.service.VideoCommentService;
import com.whoiszxl.strategy.LikeFactory;
import com.whoiszxl.utils.AuthUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 视频评论表 服务实现类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Service
public class VideoCommentServiceImpl extends ServiceImpl<VideoCommentMapper, VideoComment> implements VideoCommentService {

    @Autowired
    private VideoCommentMapper videoCommentMapper;

    @Autowired
    private DozerUtils dozerUtils;

    @Autowired
    private MemberApiClient memberApiClient;

    @Autowired
    private LikeFactory likeFactory;


    @Override
    public IPage<VideoCommentDTO> commentList(CommentListQuery commentListQuery) {
        LambdaQueryWrapper<VideoComment> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.orderByDesc(VideoComment::getCreatedAt);
        lambdaQueryWrapper.eq(VideoComment::getVideoId, commentListQuery.getVideoId());
        lambdaQueryWrapper.eq(VideoComment::getParentId, commentListQuery.getCommentId());

        Page<VideoComment> videoCommentPOPage = videoCommentMapper.selectPage(new Page<>(commentListQuery.getPage(), commentListQuery.getSize()), lambdaQueryWrapper);
        if(videoCommentPOPage.getRecords().isEmpty()) {
            return null;
        }

        List<Long> memberIdList = videoCommentPOPage.getRecords().stream().map(VideoComment::getMemberId).distinct().collect(Collectors.toList());
        List<MemberDTO> memberDTOList = memberApiClient.findMemberInfoByIds(memberIdList);

        Long memberId = null;
        try{
            memberId = AuthUtils.getMemberId();
        }catch (Exception e) {

        }
        Long finalMemberId = memberId;

        IPage<VideoCommentDTO> videoCommentDTOIPage = videoCommentPOPage.convert(e -> {
            VideoCommentDTO videoCommentDTO = dozerUtils.map(e, VideoCommentDTO.class);
            MemberDTO memberDTO = memberDTOList.stream().filter(item -> item.getId().equals(videoCommentDTO.getMemberId())).findAny().get();
            videoCommentDTO.setMemberId(memberDTO.getId());
            videoCommentDTO.setAvatar(memberDTO.getAvatar());
            videoCommentDTO.setNickname(memberDTO.getNickname());

            //设置自己是否点赞和点赞数
            if(finalMemberId != null) {
                Integer hasLiked = likeFactory.getLikeStrategy(LikeTypeEnum.COMMENT.getCode()).isLike(videoCommentDTO.getId(), finalMemberId);
                videoCommentDTO.setIsLiked(hasLiked);
            }else {
                videoCommentDTO.setIsLiked(0);
            }
            Integer likeCount = likeFactory.getLikeStrategy(LikeTypeEnum.COMMENT.getCode()).getLikeCount(videoCommentDTO.getId());
            videoCommentDTO.setLikeCount(likeCount);

            return videoCommentDTO;
        });
        return videoCommentDTOIPage;
    }

    @Override
    public void commentLike(String commentId) {
        Long memberId = AuthUtils.getMemberId();

        LikeCommand likeCommand = new LikeCommand();
        likeCommand.setId(Long.parseLong(commentId));
        likeCommand.setMemberId(memberId);
        likeCommand.setLikeType(LikeTypeEnum.COMMENT.getCode());
        likeCommand.setStatus(VideoCounterStatusEnum.INCR.getCode());

        likeFactory.getLikeStrategy(likeCommand.getLikeType()).like(likeCommand);
    }

    @Override
    public void commentLikeDislike(String commentId) {
        Long memberId = AuthUtils.getMemberId();

        LikeCommand likeCommand = new LikeCommand();
        likeCommand.setId(Long.parseLong(commentId));
        likeCommand.setMemberId(memberId);
        likeCommand.setLikeType(LikeTypeEnum.COMMENT.getCode());
        likeCommand.setStatus(VideoCounterStatusEnum.DECR.getCode());

        likeFactory.getLikeStrategy(likeCommand.getLikeType()).like(likeCommand);
    }

    @Override
    public void commentPublish(PublishCommentCommand publishCommentCommand) {
        Long memberId = AuthUtils.getMemberId();

        //落库
        VideoComment videoComment = dozerUtils.map(publishCommentCommand, VideoComment.class);
        videoComment.setMemberId(memberId);
        this.save(videoComment);

        //TODO 发布领域事件

    }
}
