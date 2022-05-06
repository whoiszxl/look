package com.whoiszxl.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 视频弹幕表
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Getter
@Setter
@TableName("vms_video_barrage")
@ApiModel(value = "VideoBarrage对象", description = "视频弹幕表")
public class VideoBarrage implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("主键ID")
      private Long id;

    @ApiModelProperty("会员ID")
    private Long memberId;

    @ApiModelProperty("视频ID")
    private Long videoId;

    @ApiModelProperty("弹幕内容")
    private String content;

    @ApiModelProperty("弹幕发送时间")
    private LocalDateTime sendAt;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;


}
