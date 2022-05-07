
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:look_flutter/entity/response/video_detail_response.dart';
import 'package:look_flutter/http/api_urls.dart';
import 'package:look_flutter/http/http_manager.dart';
import 'package:oktoast/oktoast.dart';

///视频接口服务
class VideoApiService extends GetxService {

  Future<VideoDetailResponse> videoDetail(String videoId) async {
    var result = await HttpManager.getInstance().get(url: ApiUrls.videoDetail + videoId);
    debugPrint("result:" + result.toString());
    return VideoDetailResponse.fromJson(result);
  }

}