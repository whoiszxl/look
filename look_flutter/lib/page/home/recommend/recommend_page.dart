import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look_flutter/controller/recommend_page_controller.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/page/home/widgets/banner_bar.dart';
import 'package:look_flutter/page/home/widgets/home_grid_navigator.dart';
import 'package:look_flutter/theme/look_themes.dart';
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

      },
      onLoading: () {
        _recommendPageController.refreshBannerResponse(_refreshController);
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
                height: 168,
                child: HomeGridNavigator(navigatorList: navList, gridHeight: 150, gridWidth: _screenWidth),
              ),


              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    InkWell(
                      child: Text("点击1",style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
                      onTap: () {
                        Get.changeTheme(LookThemes.black);
                      },
                    ),


                    InkWell(
                      child: Text("点击2",style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
                      onTap: () {
                        Get.changeTheme(LookThemes.yellow);
                      },
                    ),

                    InkWell(
                      child: Text("点击3",style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
                      onTap: () {
                        Get.changeTheme(LookThemes.red);
                      },
                    ),

                    InkWell(
                      child: Text("点击切换繁体",style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                      onTap: () {
                        var locale = const Locale('zh', 'HK');
                        Get.updateLocale(locale);
                      },
                    )
                  ],
                ),
              )

            ],
          ),
        );
      }

    });
  }
  @override
  bool get wantKeepAlive => true;
}