package com.whoiszxl.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.whoiszxl.cqrs.command.PublishCommentCommand;
import com.whoiszxl.cqrs.dto.VideoCommentDTO;
import com.whoiszxl.cqrs.query.CommentListQuery;
import com.whoiszxl.entity.VideoComment;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 视频评论表 服务类
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
public interface VideoCommentService extends IService<VideoComment> {

    /**
     * 评论点赞
     * @param commentId
     */
    void commentLike(String commentId);

    /**
     * 评论取消点赞
     * @param commentId
     */
    void commentLikeDislike(String commentId);

    /**
     * 提交评论
     * @param publishCommentCommand
     */
    void commentPublish(PublishCommentCommand publishCommentCommand);

    /**
     * 通过视频ID查询一级评论或二级评论
     * @param commentListQuery
     * @return
     */
    IPage<VideoCommentDTO> commentList(CommentListQuery commentListQuery);
}
