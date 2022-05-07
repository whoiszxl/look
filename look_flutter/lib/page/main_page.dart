
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:look_flutter/controller/main_page_controller.dart';
import 'package:look_flutter/page/dync/dync_page.dart';
import 'package:look_flutter/page/mall/mall_page.dart';
import 'package:look_flutter/res/colors_manager.dart';

import 'home/home_page.dart';
import 'member/member_page.dart';

///主页面
class MainPage extends StatefulWidget {

  const MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  //主页页面控制器
  final MainPageController mainPageController = Get.put(MainPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_bottomBarLayout) {
      //设置状态栏的颜色和图标模式
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    });

    const pages = <Widget> [
      HomePage(),DyncPage(),MallPage(),MemberPage()
    ];

    return Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: mainPageController.bottomPageIndex.value,
            children: pages,
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorManager.white,
          selectedItemColor: ColorManager.main,
          unselectedItemColor: ColorManager.grey,
          showUnselectedLabels: true,

          onTap: (index) {
            setState(() {
              mainPageController.bottomPageIndex.value = index;
            });
          },

          currentIndex: mainPageController.bottomPageIndex.value,
          type: BottomNavigationBarType.fixed,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'home'.tr,
              activeIcon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.dynamic_feed_outlined),
              label: 'dync'.tr,
              activeIcon: const Icon(Icons.dynamic_feed),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_bag_outlined),
              label: 'mall'.tr,
              activeIcon: const Icon(Icons.shopping_bag),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outlined),
              label: 'me'.tr,
              activeIcon: const Icon(Icons.person),
            ),
          ],

        )
    );
  }

  ///根据全局的底部bar index获取对应的页面容器
  _getPageContainer() {
    switch (mainPageController.bottomPageIndex.value) {
      case 0:
        return const HomePage();
      case 1:
        return const DyncPage();
      case 2:
        return const MallPage();
      case 3:
        return const MemberPage();
    }
  }

}

