import 'dart:collection';

import 'package:get/get.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/entity/response/video_response.dart';
import 'package:look_flutter/http/api_urls.dart';
import 'package:look_flutter/http/http_manager.dart';

///首页接口服务
class HomeApiService extends GetxService {

  ///获取首页轮播图列表和nav列表
  Future<BannerResponse> getBannerResponse() async {
    var result = await HttpManager.getInstance().post(url: ApiUrls.homeBanner);
    return BannerResponse.fromJson(result);
  }


  ///获取推荐视频列表
  Future<VideoResponse> recommendVideoList(int page, int size) async {
    Map<String, int> params = HashMap();
    params["page"] = page;
    params["size"] = size;
    var result = await HttpManager.getInstance().post(url: ApiUrls.recommendVideoList, data: params);
    if(result != null) {
      return VideoResponse.fromJson(result);
    }
    return null;
  }
}