import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:look_flutter/controller/member_page_controller.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/entity/response/member_info_response.dart';
import 'package:look_flutter/page/home/widgets/home_banner.dart';
import 'package:look_flutter/page/home/widgets/home_grid_navigator.dart';
import 'package:look_flutter/page/member/widgets/member_header.dart';
import 'package:look_flutter/res/colors_manager.dart';
import 'package:look_flutter/router/router_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/member_order.dart';
import 'widgets/member_wallet.dart';
///用户页面
class MemberPage extends StatefulWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MemberPageState();
  }
}

class _MemberPageState extends State<MemberPage>  with AutomaticKeepAliveClientMixin,TickerProviderStateMixin {


  final MemberPageController memberPageController = Get.find();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    //配置单次回调，在frame绘制完成后
    WidgetsBinding.instance?.addPostFrameCallback((_bottomBarLayout) {
      //配置系统的bar样式
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });

    memberPageController.memberInfo();
    memberPageController.getNav();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      debugPrint(memberPageController.memberInfoResponse.value.toJson().toString());
      if(memberPageController.memberInfoResponse.value == null || memberPageController.memberInfoResponse.value.memberId == null) {
        return Center(
          child: TextButton(
            child: const Text("点击登录"),
            onPressed: () {
              Get.toNamed(Routers.passwordLogin);
            },
          ),
        );
      }else {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _onRefresh,
          header: const ClassicHeader(
            refreshingText: "刷新中",
            releaseText: "刷新中",
            completeText: "刷新完成",
          ),
          footer: const ClassicFooter(
            loadingText: "加载中",
            failedText: "加载失败",
            idleText: "加载中",
            canLoadingText: "加载中",
            noDataText: "没有更多商品了",
          ),
          controller: _refreshController,
          child: _son(memberPageController.memberInfoResponse.value, memberPageController.navigationList),
        );
      }
    });
  }
  _son(MemberInfoResponse memberInfoResponse, List<NavigationEntity> navigationList) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[

        //沉浸式Appbar
        Stack(
          children: [
            //会员信息头部
            MemberHeader(memberInfoResponse: memberInfoResponse),
            memberAppBar(context),
          ],
        ),

        Container(
          height: 1000,
          color: ColorManager.greyBg,
          child: ListView(
            shrinkWrap: true,
            children: [

              //会员钱包资产栏
              Padding(
                padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                child: Container(
                  decoration: cardRadius(),
                  child: const MemberWallet(),
                ),
              ),

              //会员订单栏
              Padding(
                padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                child: Container(
                  decoration: cardRadius(),
                  child: MemberOrder(),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                child: Container(
                  decoration: cardRadius(),
                  child: Column(
                    children: <Widget>[
                      //标题行
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          const Padding(padding: EdgeInsets.only(left: 8, top: 8, bottom: 4),
                              child: Text("我的服务", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),

                          Padding(padding: const EdgeInsets.only(right: 8, top: 8, bottom: 4),
                              child: Row(
                                children: const [
                                  Text("查看更多", style: TextStyle(fontSize: 12, color: ColorManager.grey)),
                                  Icon(Icons.navigate_next, size: 12, color: ColorManager.grey),
                                ],
                              ))
                        ],
                      ),
                      //分割线
                      const Divider(height: 2),
                      //网格栏
                      HomeGridNavigator(navigatorList: navigationList)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

      ],
    );
  }

  ///会员页面appbar
  memberAppBar(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 25, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          //跳转到我的二维码界面
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              child: const Icon(Icons.qr_code_outlined,color: ColorManager.grey),
              onTap: () {
                //跳转到我的二维码页面
                Get.toNamed(Routers.qrcode);
              },
            ),
          ),

          //跳转到设置界面
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              child: const Icon(Icons.settings_outlined,color: ColorManager.grey),
              onTap: () {
                Get.toNamed(Routers.setting);
              },
            ),
          ),
        ],
      ),
    );


  }

  void _onRefresh() async{
    memberPageController.memberInfo();
    _refreshController.refreshCompleted();
  }

  cardRadius() {
    return const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
    );
  }

  @override
  bool get wantKeepAlive => true;
}