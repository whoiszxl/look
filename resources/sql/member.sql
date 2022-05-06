DROP TABLE IF EXISTS `ums_member`;
CREATE TABLE `ums_member`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `username`                  varchar(16) NOT NULL COMMENT '会员名',
    `password`                  varchar(100) NOT NULL COMMENT '密码',
    `email`                     varchar(64) DEFAULT '' COMMENT '邮箱',
    `phone`                     varchar(16) DEFAULT '' COMMENT '手机',
    `avatar`                    varchar(200) NOT NULL COMMENT '头像',
    `nickname`                  varchar(100) DEFAULT '' COMMENT '昵称',
    `google_key`                varchar(32) DEFAULT '' COMMENT '谷歌验证码',
    `google_status`             int(1) DEFAULT '0' COMMENT '谷歌验证码是否开启,默认0不开启, 1开启',
    `real_name`                 varchar(16) DEFAULT '' COMMENT '真实姓名',
    `online`                    tinyint(2) DEFAULT 1 COMMENT '是否在线(0:离线 1:在线)',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(64) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(64) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_idx_username` (`username`),
    UNIQUE KEY `uni_idx_phone` (`phone`),
    INDEX `idx_nickname_phone` (`nickname`, `phone`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '会员表';

DROP TABLE IF EXISTS `ums_member_info`;
CREATE TABLE `ums_member_info`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '用户ID',
    `gender`                    tinyint(1) DEFAULT 0 COMMENT '性别(0:未知 1:男;2:女)',
    `birthday`                  datetime DEFAULT NULL COMMENT '生日',
    `slogan`                    varchar(64) DEFAULT '' COMMENT '个性标语',
    `country_code`              varchar(5) DEFAULT '' COMMENT '国家码',
    `country`                   varchar(100) DEFAULT '' COMMENT '国家',
    `province`                  varchar(100) DEFAULT '' COMMENT '省份',
    `city`                      varchar(30) DEFAULT '' COMMENT '城市',
    `district`                  varchar(200) DEFAULT '' COMMENT '区域',
    `school`                    varchar(200) DEFAULT '' COMMENT '学校',
    `grade_level`               varchar(255) DEFAULT '' COMMENT '会员等级',
    `login_count`               bigint(11) NOT NULL DEFAULT 0 COMMENT '会员登录次数',
    `login_error_count`         bigint(11) NOT NULL DEFAULT 0 COMMENT '会员登录错误次数',
    `last_login`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '最后登录',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(64) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(64) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_idx_member_id` (`member_id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '会员详情表';


DROP TABLE IF EXISTS `ums_member_coin`;
CREATE TABLE `ums_member_coin`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '用户ID',
    `coin_quantity`             int(8) DEFAULT 0 COMMENT '币数量',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(64) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(64) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '币余额表';


DROP TABLE IF EXISTS `ums_member_like`;
CREATE TABLE `ums_member_like`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `like_type`                 tinyint(2) NOT NULL DEFAULT 1 COMMENT '点赞类型: 1:短视频 2:评论',
    `like_id`                   bigint(11) NOT NULL DEFAULT 1 COMMENT '点赞类型相关记录的主键ID',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '点赞表';

DROP TABLE IF EXISTS `ums_member_collection`;
CREATE TABLE `ums_member_collection`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `video_id`                  bigint(11) NOT NULL COMMENT '视频ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `like_type`                 tinyint(2) NOT NULL DEFAULT 1 COMMENT '点赞类型: 1:短视频 2:评论',
    `like_id`                   bigint(11) NOT NULL DEFAULT 1 COMMENT '点赞类型相关记录的主键ID',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '收藏表';


DROP TABLE IF EXISTS `ums_member_blacklist`;
CREATE TABLE `ums_member_blacklist` (
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '会员ID',
    `black_member_id`           bigint(11) NOT NULL COMMENT '黑名单会员ID',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(64) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(64) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_member_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员黑名单表';

DROP TABLE IF EXISTS `ums_member_follower`;
CREATE TABLE `ums_member_follower`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '用户ID',
    `follower_id`               bigint(11) NOT NULL COMMENT '粉丝ID',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_idx_member_id` (`member_id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '会员粉丝表';


DROP TABLE IF EXISTS `ums_member_attention_group`;
CREATE TABLE `ums_member_attention_group`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '用户ID',
    `name`                      varchar(64) NOT NULL COMMENT '分组名称',
    `type`                      tinyint(1) NOT NULL COMMENT '分组类型: 1-默认分组 2-特别关注 3-私密关注',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除, 0: 未删除',
    `created_by`                varchar(64) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(64) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_idx_member_id` (`member_id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '会员关注分组表';

DROP TABLE IF EXISTS `ums_member_attention`;
CREATE TABLE `ums_member_attention`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '用户ID',
    `attention_id`              bigint(11) NOT NULL COMMENT '被关注者ID',
    `group_id`                  bigint(11) NOT NULL COMMENT '关注分组表主键ID',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_idx_member_id` (`member_id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '会员关注表';

DROP TABLE IF EXISTS `ums_member_report`;
CREATE TABLE `ums_member_report`(
    `id`                        bigint(11) NOT NULL COMMENT '主键ID',
    `member_id`                 bigint(11) NOT NULL COMMENT '举报人的用户ID',
    `report_member_id`          bigint(11) NOT NULL COMMENT '被举报的用户ID',
    `report_video_id`           bigint(11) NOT NULL COMMENT '被举报的视频ID',
    `report_comment_id`         bigint(11) NOT NULL COMMENT '被举报的评论ID',
    `title`                     varchar(100) NOT NULL COMMENT '举报标题',
    `content`                   varchar(200) NOT NULL COMMENT '举报内容',
    `version`                   bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '乐观锁',
    `status`                    tinyint(3) DEFAULT 0 COMMENT '业务状态',
    `is_deleted`                tinyint(3) DEFAULT 0 COMMENT '逻辑删除 1: 已删除， 0: 未删除',
    `created_by`                varchar(50) NOT NULL COMMENT '创建者',
    `updated_by`                varchar(50) NOT NULL COMMENT '更新者',
    `created_at`                datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`                datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COMMENT '会员举报表';