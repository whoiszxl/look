import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:look_flutter/res/colors_manager.dart';

import 'guess/guess_page.dart';
import 'recommend/recommend_page.dart';
import 'widgets/search_bar.dart';
import 'widgets/tab_bar.dart';
///首页页面
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  final Map<String, List> tabViewKey = {};

  TabController _tabController;

  List<String> tabs = [];

  List<Widget> views = [];

  List<String> images = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //初始化数据
    tabViewKey['直播'] = [const RecommendPage(), ""];
    tabViewKey['推荐'] = [const RecommendPage(), ""];
    tabViewKey['热门'] = [const RecommendPage(), ""];
    tabViewKey['追番'] = [const RecommendPage(), ""];
    tabViewKey['影视'] = [const GuessPage(), ""];

    tabViewKey.forEach((key, value) {
      tabs.add(key);
      views.add(value[0]);
      images.add(value[1]);
    });

    _tabController = TabController(length: tabs.length, vsync: this);

    //配置单次回调，在frame绘制完成后
    WidgetsBinding.instance?.addPostFrameCallback((_bottomBarLayout) {
      //配置系统的bar样式
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GlobalKey _appBarKey = GlobalKey();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        key: _appBarKey,
        iconTheme: const IconThemeData(),
        elevation: 0.0,
        titleSpacing: 0.0,
        title: const SearchBar(),

        bottom: PreferredSize(
          child: HomeTabBar(
            tabController: _tabController,
            tabs: tabs,
            onTapCallback: () {

            },
          ),
          preferredSize: const Size.fromHeight(30.0),
        ),

      ),
      body: TabBarView(
        controller: _tabController,
        children: views,
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}