package com.whoiszxl.controller.api;


import cn.dev33.satoken.annotation.SaCheckLogin;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.whoiszxl.bean.PageQuery;
import com.whoiszxl.bean.ResponseResult;
import com.whoiszxl.cqrs.command.VideoSaveCommand;
import com.whoiszxl.cqrs.query.MemberTimelineQuery;
import com.whoiszxl.cqrs.response.VideoResponse;
import com.whoiszxl.service.VideoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 视频表 前端控制器
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@RestController
@RequestMapping("/api/video")
@Api(tags = "C端:视频相关接口")
public class VideoApiController {

    @Autowired
    private VideoService videoService;

    @SaCheckLogin
    @PostMapping("/save")
    @ApiOperation(value = "新增视频", notes = "新增视频", response = ResponseResult.class)
    public ResponseResult<Boolean> saveVideo(@RequestBody VideoSaveCommand videoSaveCommand) {
        boolean saveFlag = videoService.saveVideo(videoSaveCommand);
        return ResponseResult.buildByFlag(saveFlag);
    }


    @PostMapping("/attention/feed/list")
    @ApiOperation(value = "分页查询当前用户的关注用户视频feed流列表", notes = "分页查询当前用户的关注用户视频feed流列表", response = VideoResponse.class)
    public ResponseResult<IPage<VideoResponse>> attentionFeedList(@RequestBody PageQuery pageQuery) {
        IPage<VideoResponse> videoPage = videoService.attentionFeedList(pageQuery);
        return ResponseResult.buildSuccess(videoPage);
    }

    @PostMapping("/recommend/feed/list")
    @ApiOperation(value = "分页查询当前用户的推荐视频feed流列表", notes = "分页查询当前用户的推荐视频feed流列表", response = VideoResponse.class)
    public ResponseResult<IPage<VideoResponse>> recommendFeedList(@RequestBody PageQuery pageQuery) {
        IPage<VideoResponse> videoPage = videoService.recommendFeedList(pageQuery);
        return ResponseResult.buildSuccess(videoPage);
    }

    @GetMapping("/{videoId}")
    @ApiOperation(value = "指定ID查询视频", notes = "指定ID查询视频", response = VideoResponse.class)
    public ResponseResult<VideoResponse> getVideoById(@PathVariable String videoId) {
        VideoResponse videoResponse = videoService.getVideoById(videoId);
        return ResponseResult.buildSuccess(videoResponse);
    }

    @PostMapping("/timeline/list")
    @ApiOperation(value = "分页查询指定用户的视频列表", notes = "分页查询指定用户的视频列表", response = VideoResponse.class)
    public ResponseResult<IPage<VideoResponse>> timeline(@RequestBody MemberTimelineQuery memberTimelineQuery) {
        IPage<VideoResponse> videoPage = videoService.timeline(memberTimelineQuery);
        return ResponseResult.buildSuccess(videoPage);
    }


    @PostMapping("/like/{videoId}")
    @ApiOperation(value = "点赞", notes = "点赞", response = Boolean.class)
    public ResponseResult<Boolean> like(@PathVariable Long videoId) {
        videoService.like(videoId);
        return ResponseResult.buildSuccess();
    }

    @PostMapping("/dislike/{videoId}")
    @ApiOperation(value = "取消点赞", notes = "取消点赞", response = Boolean.class)
    public ResponseResult<Boolean> dislike(@PathVariable Long videoId) {
        videoService.disLike(videoId);
        return ResponseResult.buildSuccess();
    }




}

