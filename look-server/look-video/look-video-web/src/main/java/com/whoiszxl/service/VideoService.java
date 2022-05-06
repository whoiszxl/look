package com.whoiszxl.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.whoiszxl.bean.PageQuery;
import com.whoiszxl.cqrs.command.VideoSaveCommand;
import com.whoiszxl.cqrs.query.MemberTimelineQuery;
import com.whoiszxl.cqrs.response.VideoResponse;
import com.whoiszxl.entity.Video;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 视频表 服务类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
public interface VideoService extends IService<Video> {

    /**
     * 新增视频
     * @param videoSaveCommand
     * @return
     */
    boolean saveVideo(VideoSaveCommand videoSaveCommand);


    /**
     * 视频点赞
     * @param videoId 视频ID
     */
    void like(Long videoId);

    /**
     * 取消点赞
     * @param videoId 视频ID
     */
    void disLike(Long videoId);

    /**
     * 分页查询当前用户的关注用户视频feed流列表
     * @param pageQuery
     * @return
     */
    IPage<VideoResponse> attentionFeedList(PageQuery pageQuery);

    /**
     * 分页查询当前用户的推荐视频feed流列表
     * @param pageQuery
     * @return
     */
    IPage<VideoResponse> recommendFeedList(PageQuery pageQuery);

    /**
     * 分页查询指定用户的视频列表
     * @param memberTimelineQuery
     * @return
     */
    IPage<VideoResponse> timeline(MemberTimelineQuery memberTimelineQuery);
}
