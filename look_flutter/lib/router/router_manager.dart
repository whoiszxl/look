import 'package:get/get.dart';
import 'package:look_flutter/page/dync/dync_page.dart';
import 'package:look_flutter/page/home/home_page.dart';
import 'package:look_flutter/page/main_page.dart';
import 'package:look_flutter/page/mall/mall_page.dart';
import 'package:look_flutter/page/member/member_page.dart';

///路由名称，所有路由在此处统一管理
///跳转时直接使用如下代码进行处理：Get.toNamed(Routers.pageName, parameters: map);
class Routers{

  static const String main = '/main';
  static const String home = '/home';
  static const String dync = '/dync';
  static const String mall = '/mall';
  static const String member = '/member';


}

///路由管理者
class RouterManager{
  static final routes = [
    GetPage(name: Routers.main, page: () => const MainPage()),
    GetPage(name: Routers.home, page: () => const HomePage()),
    GetPage(name: Routers.dync, page: () => const DyncPage()),
    GetPage(name: Routers.mall, page: () => const MallPage()),
    GetPage(name: Routers.member, page: () => const MemberPage()),

  ];

}
