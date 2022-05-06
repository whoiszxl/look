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
 * 会员关注分组表
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Getter
@Setter
@TableName("ums_member_attention_group")
@ApiModel(value = "MemberAttentionGroup对象", description = "会员关注分组表")
public class MemberAttentionGroup implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("主键ID")
      private Long id;

    @ApiModelProperty("用户ID")
    private Long memberId;

    @ApiModelProperty("分组名称")
    private String name;

    @ApiModelProperty("分组类型: 1-默认分组 2-特别关注 3-私密关注")
    private Boolean type;

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
