import 'package:get/get.dart';
import 'package:look_flutter/entity/response/video_detail_response.dart';
import 'package:look_flutter/service/video_api_service.dart';

class DetailPageController extends GetxController {

  final videoDetailResponse = VideoDetailResponse().obs;

  Future<bool> videoDetail(String videoId) async {
    var result = await Get.find<VideoApiService>().videoDetail(videoId);
    if(result == null) {
      return false;
    }
    videoDetailResponse.value = result;
    return true;
  }


}