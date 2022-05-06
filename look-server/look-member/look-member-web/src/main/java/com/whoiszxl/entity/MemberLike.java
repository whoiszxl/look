package com.whoiszxl.entity;

import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;
import java.io.Serializable;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 点赞表
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Getter
@Setter
@TableName("ums_member_like")
@ApiModel(value = "MemberLike对象", description = "点赞表")
public class MemberLike implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("主键ID")
      private Long id;

    @ApiModelProperty("会员ID")
    private Long memberId;

    @ApiModelProperty("点赞类型: 1:短视频 2:评论")
    private Integer likeType;

    @ApiModelProperty("点赞类型相关记录的主键ID")
    private Long likeId;

    @ApiModelProperty("乐观锁")
    @Version
    private Long version;

    @ApiModelProperty("业务状态")
    private Integer status;

    @ApiModelProperty("逻辑删除 1: 已删除, 0: 未删除")
    @TableLogic
    private Integer isDeleted;

    @ApiModelProperty("创建者")
    private String createdBy;

    @ApiModelProperty("更新者")
    private String updatedBy;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;


}
