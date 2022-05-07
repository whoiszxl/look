package com.whoiszxl.cqrs.command;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 视频表
 * </p>
 *
 * @author whoiszxl
 * @since 2022-05-06
 */
@Getter
@Setter
@ApiModel(value = "Video保存命令对象", description = "Video保存命令对象")
public class VideoSaveCommand implements Serializable {

    @ApiModelProperty("视频主键ID")
    private Long id;

    @ApiModelProperty("标题")
    private String title;

    @ApiModelProperty("副标题")
    private String subTitle;

    @ApiModelProperty("标签名列表")
    private String tagNameList;

    @ApiModelProperty("视频封面")
    private String cover;

    @ApiModelProperty("视频文件地址")
    private String videoUrl;

    @ApiModelProperty("视频秒数")
    private Integer seconds;

    @ApiModelProperty("视频宽度")
    private Integer width;

    @ApiModelProperty("视频高度")
    private Integer height;

    @ApiModelProperty("观看类型:(1:所有人 2:私密 3:好友可见 4:部分可见 5:对谁不可见)")
    private Boolean watchType;

    @ApiModelProperty("可见用户的id列表,使用逗号 , 分隔")
    private String canWatchMember;

    @ApiModelProperty("不可见用户的id列表,使用逗号 , 分隔")
    private String cannotWatchMember;

    @ApiModelProperty("来自什么渠道")
    private String channel;

    @ApiModelProperty("定位地址")
    private String address;

    @ApiModelProperty("经度")
    private BigDecimal longitude;

    @ApiModelProperty("纬度")
    private BigDecimal latitude;

    @ApiModelProperty("ip地址")
    private String ip;

}
