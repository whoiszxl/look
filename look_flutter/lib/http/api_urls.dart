///API接口统一管理类
class ApiUrls {

  static const String baseUrl = 'http://192.168.252.1';
  //static const String baseUrl = 'http://localhost';

  ///首页获取banner数据
  static const String homeBanner = "/video/api/banner/app/index";


  static const String memberLogin = "/member/api/member/login";
  static const String memberPasswordRegister = "/member/api/member/phone/register";
  static const String memberInfo = "/member/api/member/detail";

  static const String recommendVideoList = "/video/api/video/recommend/feed/list";

  static const String videoDetail = "/video/api/video/";


}