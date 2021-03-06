package com.whoiszxl.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 会员关注表
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Getter
@Setter
@TableName("ums_member_attention")
@ApiModel(value = "MemberAttention对象", description = "会员关注表")
public class MemberAttention implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("主键ID")
      private Long id;

    @ApiModelProperty("用户ID")
    private Long memberId;

    @ApiModelProperty("被关注者ID")
    private Long attentionId;

    @ApiModelProperty("关注分组表主键ID")
    private Long groupId;


}
