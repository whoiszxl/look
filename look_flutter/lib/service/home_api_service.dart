import 'package:get/get.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/http/api_urls.dart';
import 'package:look_flutter/http/http_manager.dart';

///首页接口服务
class HomeApiService extends GetxService {

  ///获取首页轮播图列表和nav列表
  Future<BannerResponse> getBannerResponse() async {
    var result = await HttpManager.getInstance().post(url: ApiUrls.homeBanner);
    return BannerResponse.fromJson(result);
  }

}