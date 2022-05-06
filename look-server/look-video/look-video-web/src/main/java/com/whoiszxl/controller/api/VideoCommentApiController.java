package com.whoiszxl.controller.api;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.whoiszxl.bean.ResponseResult;
import com.whoiszxl.cqrs.command.PublishCommentCommand;
import com.whoiszxl.cqrs.dto.VideoCommentDTO;
import com.whoiszxl.cqrs.query.CommentListQuery;
import com.whoiszxl.service.VideoCommentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 视频评论表 前端控制器
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@RestController
@RequestMapping("/api/video-comment")
@Api(tags = "C端:视频评论相关接口")
public class VideoCommentApiController {

    @Autowired
    private VideoCommentService videoCommentService;

    @PostMapping("/publish")
    @ApiOperation(value = "发表评论", notes = "发表评论", response = Boolean.class)
    public ResponseResult<Boolean> commentPublish(@RequestBody PublishCommentCommand publishCommentCommand) {
        videoCommentService.commentPublish(publishCommentCommand);
        return ResponseResult.buildSuccess();
    }

    @PostMapping("/list")
    @ApiOperation(value = "评论列表", notes = "评论列表", response = VideoCommentDTO.class)
    public ResponseResult<IPage<VideoCommentDTO>> commentList(@RequestBody CommentListQuery commentListQuery) {
        IPage<VideoCommentDTO> videoCommentDTOIPage = videoCommentService.commentList(commentListQuery);
        return ResponseResult.buildSuccess(videoCommentDTOIPage);
    }


    @PostMapping("/like/{commentId}")
    @ApiOperation(value = "评论点赞", notes = "点赞", response = Boolean.class)
    public ResponseResult<Boolean> commentLike(@PathVariable String commentId) {
        videoCommentService.commentLike(commentId);
        return ResponseResult.buildSuccess();
    }

    @PostMapping("/dislike/{commentId}")
    @ApiOperation(value = "评论取消点赞", notes = "取消点赞", response = Boolean.class)
    public ResponseResult<Boolean> commentLikeDislike(@PathVariable String commentId) {
        videoCommentService.commentLikeDislike(commentId);
        return ResponseResult.buildSuccess();
    }
}

