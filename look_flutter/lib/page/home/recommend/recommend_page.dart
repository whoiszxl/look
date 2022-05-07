import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:look_flutter/controller/recommend_page_controller.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/entity/response/video_response.dart';
import 'package:look_flutter/page/home/widgets/banner_bar.dart';
import 'package:look_flutter/page/home/widgets/home_grid_navigator.dart';
import 'package:look_flutter/page/home/widgets/recommend_video_card.dart';
import 'package:look_flutter/utils/loading_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///HOME主页 推荐tab页面
class RecommendPage extends StatefulWidget {

  const RecommendPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecommendPageState();
  }
}

class _RecommendPageState extends State<RecommendPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  final PageController _pageController = PageController(keepPage: true);
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  final RecommendPageController _recommendPageController = Get.find<RecommendPageController>();

  double _screenWidth;

  @override
  void initState() {
    _recommendPageController.refreshBannerResponse(_refreshController);
    _recommendPageController.getRecommendVideoList(_refreshController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    //获取屏幕的初始化高度和宽度
    _screenWidth = MediaQuery.of(context).size.width;

    return SmartRefresher(
      scrollController: _scrollController,
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () {
        _recommendPageController.refreshBannerResponse(_refreshController);
        _recommendPageController.refreshRecommendVideoList(_refreshController);
      },
      onLoading: () {
        _recommendPageController.getRecommendVideoList(_refreshController);
      },
      child: _build(context),
    );
  }

  _build(BuildContext context) {
    return Obx(() {
      List<NavigationEntity> navList = _recommendPageController.navigationList;
      List<BannerEntity> bannerList = _recommendPageController.bannerList;

      if(navList.isEmpty || navList.isEmpty) {
        return normalLoading();
      }else {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[

              //轮播图组件
              BannerBar(bannerList: bannerList),

              //nav组件
              SizedBox(
                height: 80,
                child: HomeGridNavigator(navigatorList: navList, gridHeight: 75, gridWidth: _screenWidth),
              ),

              //推荐视频列表
              _videoList(_recommendPageController.videoList),

            ],
          ),
        );
      }

    });
  }


  ///视频列表
  _videoList(List<VideoEntity> videoList) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics (),
      padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
      crossAxisCount: 2,
      itemCount: videoList.length,
      itemBuilder: (BuildContext context, int index) {
        return RecommendVideoCard(videoEntity: videoList[index]);
      },

      staggeredTileBuilder: (int index) {
        return const StaggeredTile.fit(1);
      },
    );
  }



  @override
  bool get wantKeepAlive => true;


}