DROP TABLE IF EXISTS `vms_video`;
CREATE TABLE `vms_video`(
    `id`                        bigint(11) NOT NULL COMMENT '视频主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `title`                     varchar(64) NOT NULL COMMENT '标题',
    `sub_title`                 varchar(128) NOT NULL COMMENT '副标题',
    `tag_name_list`             varchar(256) NOT NULL COMMENT '标签名列表',
    `cover`                     varchar(300) NOT NULL COMMENT '视频封面',
    `video_url`                 varchar(300) NOT NULL COMMENT '视频文件地址',
    `seconds`                   float(6,2) DEFAULT NULL COMMENT '视频秒数',
    `width`                     int(6) DEFAULT NULL COMMENT '视频宽度',
    `height`                    int(6) DEFAULT NULL COMMENT '视频高度',
    `watch_type`                tinyint(1) DEFAULT 1 COMMENT '观看类型:(1:所有人 2:私密 3:好友可见 4:部分可见 5:对谁不可见)',
    `can_watch_member`          varchar(1024) DEFAULT '' COMMENT '可见用户的id列表,使用逗号 , 分隔',
    `cannot_watch_member`       varchar(1024) DEFAULT '' COMMENT '不可见用户的id列表,使用逗号 , 分隔',
    `channel`                   varchar(10) NOT NULL DEFAULT '' COMMENT '来自什么渠道',
    `address`                   varchar(100) NOT NULL DEFAULT '' COMMENT '定位地址',
    `longitude`                 decimal(10,7) NOT NULL DEFAULT 0 COMMENT '经度',
    `latitude`                  decimal(10,7) NOT NULL DEFAULT 0 COMMENT '纬度',
    `ip`                        varchar(30) NOT NULL DEFAULT '' COMMENT 'ip地址',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '视频表';

DROP TABLE IF EXISTS `vms_video_comment`;
CREATE TABLE `vms_video_comment`(
    `id`                        bigint(11) NOT NULL COMMENT '评论主键ID',
    `video_id`                  bigint(11) NOT NULL COMMENT '视频ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `comment_text`              varchar(140) NOT NULL COMMENT '评论内容',
    `comment_imgs`              varchar(150) NOT NULL COMMENT '评论图片',
    `at`                        varchar(150) NOT NULL DEFAULT '' COMMENT '@了谁,下划线分割',
    `parent_id`                 bigint(11) NOT NULL DEFAULT 0 COMMENT '评论父ID, 为0则是主评论',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '视频评论表';


DROP TABLE IF EXISTS `vms_tag`;
CREATE TABLE `vms_tag`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `tag_name`                  varchar(100) NOT NULL COMMENT '标签名',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '标签表';

DROP TABLE IF EXISTS `vms_bgmusic`;
CREATE TABLE `vms_bgmusic`(
    `id`                        bigint(11) NOT NULL COMMENT '背景音乐主键ID',
    `music_name`                varchar(100) NOT NULL COMMENT '音乐名',
    `singer`                    varchar(100) NOT NULL COMMENT '歌手',
    `cover`                     varchar(255) NOT NULL COMMENT '音乐封面',
    `music_composer`            varchar(100) NOT NULL COMMENT '作曲者',
    `music_lyricist`            varchar(100) NOT NULL COMMENT '作词者',
    `music_copyright`           varchar(255) NOT NULL COMMENT '音乐版权',
    `music_seconds`             float(6,2) DEFAULT NULL COMMENT '视频秒数',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '背景音乐表';

DROP TABLE IF EXISTS `vms_video_counter`;
CREATE TABLE `vms_video_counter`(
    `video_id`                  bigint(11) NOT NULL COMMENT '视频ID,也是主键ID',
    `counter_type`              tinyint(2) NOT NULL DEFAULT 1 COMMENT '计数类型: 1:观看量 2:转发量 3:评论量 4:点赞量',
    `counter_value`             bigint(11) NOT NULL DEFAULT 1 COMMENT '计数值',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`video_id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '视频计数表';


DROP TABLE IF EXISTS `vms_video_watch_history`;
CREATE TABLE `vms_video_watch_history`(
  `id` bigint(11) NOT NULL COMMENT '主键ID',
  `member_id` bigint(11) NOT NULL COMMENT '会员ID',
  `video_id` bigint(11) NOT NULL COMMENT '视频ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '浏览历史表';


DROP TABLE IF EXISTS `vms_video_barrage`;
CREATE TABLE `vms_video_barrage`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `video_id`                  bigint(11) NOT NULL COMMENT '视频ID',
    `content`                   varchar(128) NOT NULL COMMENT '弹幕内容',
    `send_at`                   datetime DEFAULT CURRENT_TIMESTAMP COMMENT '弹幕发送时间',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '视频弹幕表';


DROP TABLE IF EXISTS `vms_video_dynamic`;
CREATE TABLE `vms_video_dynamic`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `type`                      tinyint(1) NOT NULL DEFAULT 1 COMMENT '动态类型: 1:视频 2:专栏',
    `resource_id`               bigint(11) NOT NULL COMMENT '动态资源ID',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '视频计数表';

DROP TABLE IF EXISTS `rms_banner`;
CREATE TABLE `rms_banner` (
    `id`                        bigint(10) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
    `name`                      varchar(100) DEFAULT '' COMMENT '轮播图名称',
    `type`                      tinyint(1) DEFAULT '0' COMMENT '轮播位置:0->PC首页轮播;1->app首页轮播 2->app导航小组件',
    `biz_id`                    bigint(10) NOT NULL COMMENT '业务ID: spu_id or other',
    `pic`                       varchar(255) DEFAULT '' COMMENT '图片地址',
    `status`                    int(1) DEFAULT '1' COMMENT '上下线状态:0->下线;1->上线',
    `click_count`               int(11) DEFAULT '0' COMMENT '点击数',
    `url`                       varchar(255) DEFAULT '' COMMENT '链接地址',
    `sort`                      int(3) DEFAULT '0' COMMENT '排序',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除， 0: 未删除',
    `created_by`                varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL DEFAULT '' COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '轮播表';