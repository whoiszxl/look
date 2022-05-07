import 'package:get/get.dart';
import 'package:look_flutter/controller/detail_page_controller.dart';

import 'language_controller.dart';
import 'main_page_controller.dart';
import 'member_page_controller.dart';
import 'recommend_page_controller.dart';


///所有控制器的加载器，通过Get.lazyPut进行懒注入
class AllControllerBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<RecommendPageController>(() => RecommendPageController());
    Get.lazyPut<MemberPageController>(() => MemberPageController());
    Get.lazyPut<DetailPageController>(() => DetailPageController());
  }
}