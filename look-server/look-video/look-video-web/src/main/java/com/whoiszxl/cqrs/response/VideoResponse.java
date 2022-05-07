package com.whoiszxl.cqrs.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

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
@ApiModel(value = "Video对象", description = "视频表")
public class VideoResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("视频主键ID")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private Long id;

    @ApiModelProperty("会员ID")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private Long memberId;

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

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;


    @ApiModelProperty("头像")
    private String avatar;

    @ApiModelProperty("昵称")
    private String nickname;

    @ApiModelProperty("点赞数")
    private Integer lickCount;

    @ApiModelProperty("评论数")
    private Integer commentCount;

    @ApiModelProperty("分享数")
    private Integer shareCount;

    @ApiModelProperty("是否点赞 1:是 0:否")
    private Integer hasLiked;

}
