import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look_flutter/controller/detail_page_controller.dart';
import 'package:look_flutter/entity/response/video_detail_response.dart';
import 'package:look_flutter/widgets/video_view.dart';

///详情页面
class DetailPage extends StatefulWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {

  String currentVideoId;

  final DetailPageController _detailPageController = Get.put(DetailPageController());


  @override
  void initState() {
    Map<String, String> getParams = Get.parameters;
    currentVideoId = getParams['videoId'];
    _detailPageController.videoDetail(currentVideoId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          child: Obx(() {
            if(_detailPageController.videoDetailResponse.value == null) {
              return Container();
            }

            return Column(
              children: [
                _buildVideoView(_detailPageController.videoDetailResponse.value),
              ],
            );
          })
      )
    );
  }

  _buildVideoView(VideoDetailResponse detail) {
    return VideoView(
      detail.videoUrl,
      cover: detail.cover,
      overlayUI: videoAppBar(),
    );
  }

  ///视频详情页appBar
  videoAppBar() {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BackButton(
            color: Colors.white,
          ),
          Row(
            children: const [
              Icon(Icons.live_tv_rounded, color: Colors.white, size: 20),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child:
                Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
              )
            ],
          )
        ],
      ),
    );
  }

  ///黑色线性渐变
  blackLinearGradient({bool fromTop = false}) {
    return LinearGradient(
        begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
        end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
        colors: const [
          Colors.black54,
          Colors.black45,
          Colors.black38,
          Colors.black26,
          Colors.black12,
          Colors.transparent
        ]);
  }
}