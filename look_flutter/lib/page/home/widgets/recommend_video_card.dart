import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look_flutter/entity/response/video_response.dart';
import 'package:look_flutter/res/colors_manager.dart';
import 'package:look_flutter/router/router_manager.dart';
import 'package:look_flutter/utils/format_util.dart';
import 'package:look_flutter/utils/image_util.dart';
import 'package:oktoast/oktoast.dart';

///推荐视频卡片
class RecommendVideoCard extends StatefulWidget {

  final VideoEntity videoEntity;

  const RecommendVideoCard({Key key, this.videoEntity}) : super(key: key);

  @override
  _RecommendVideoCardState createState() => _RecommendVideoCardState();
}

class _RecommendVideoCardState extends State<RecommendVideoCard> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        margin: const EdgeInsets.only(left: 2, right: 2, bottom: 9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _videoCover(context, widget.videoEntity, () {
                Map<String,String> map = HashMap();
                map['videoId'] = widget.videoEntity.id.toString();
                Get.toNamed(Routers.detail, parameters: map);
              }),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 5, left: 4, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //标题信息
                      _title(() {
                        Map<String,String> map = HashMap();
                        map['videoId'] = widget.videoEntity.id.toString();
                        Get.toNamed(Routers.detail, parameters: map);
                      }),

                      //作者信息
                      _author(() {
                        showToast("跳转到up主详情页");
                      }, () {
                        showToast("弹出视频菜单");
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _title(ontap) {
    return InkWell(
      onTap: ontap,
      child: Text(
          widget.videoEntity.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: ColorManager.black)
      ),
    );
  }

  _videoCover(BuildContext context, VideoEntity videoEntity, ontap) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          cachedImage(videoEntity.cover, width: size.width / 2 - 10, height: 120, fit: BoxFit.cover),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [ColorManager.black54, Colors.transparent])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _iconText(Icons.ondemand_video_outlined, videoEntity.shareCount.toString()),
                        const SizedBox(width: 10),
                        _iconText(Icons.remove_red_eye_outlined, videoEntity.lickCount.toString()),
                      ],
                    ),
                    _iconText(null, FormatUtil.seconds2Str(videoEntity.seconds)),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  _iconText(IconData iconData, String count) {
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(count.toString(), style: const TextStyle(color: ColorManager.white, fontSize: 10)))
      ],
    );
  }

  _author(infoTap, menuTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        InkWell(
          onTap: infoTap,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: cachedImage(widget.videoEntity.avatar, height: 24, width: 24)),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.videoEntity.nickname,
                  style: const TextStyle(fontSize: 12, color: ColorManager.black87),
                ),
              )
            ],
          ),
        ),


        InkWell(
          onTap: menuTap,
          child: const Icon(
            Icons.more_vert_sharp,
            size: 15,
            color: ColorManager.grey,
          ),
        )
      ],
    );
  }
}
