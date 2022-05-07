import 'package:flutter/material.dart';
import 'package:look_flutter/entity/response/member_info_response.dart';
import 'package:look_flutter/res/colors_manager.dart';
import 'package:look_flutter/utils/image_util.dart';
import 'package:oktoast/oktoast.dart';

import 'member_header_tag.dart';

///会员中心头部页
class MemberHeader extends StatelessWidget {

  final MemberInfoResponse memberInfoResponse;

  MemberHeader({Key key, this.memberInfoResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/member_bg.jpg'),
              fit: BoxFit.fitWidth
          )
      ),

      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[

              //头部，包含头像，用户名，小标签
              header(),

              floor(),
            ],
          )
        ],
      ),
    );
  }

  Widget floor() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          floorTab("动态", "123", () {
            showToast("动态");
          }),
          floorTab("关注", "32", () {
            showToast("关注");
          }),
          floorTab("粉丝", "345", () {
            showToast("粉丝");
          }),
        ],
      ),
    );
  }

  //头部，包含头像，用户名，小标签
  Widget header() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          //头像
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 14, bottom: 8),
            child: profilePhoto(memberInfoResponse.avatar),
          ),

          //网名和标语
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  username(memberInfoResponse.username),
                  gradeLevel(memberInfoResponse.gradeLevel)
                ],
              ),


              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: <Widget>[
                    tag("正式会员"),
                    SizedBox(width: 6),
                    tag("超级会员"),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: const <Widget>[
                    Text("Look币: 100", style: TextStyle(color: ColorManager.white, fontSize: 12)),
                    SizedBox(width: 16),
                    Text("硬币: 899", style: TextStyle(color: ColorManager.white, fontSize: 12)),
                  ],
                ),
              )

            ],
          )
        ],
      ),
    );
  }


  Widget floorTab(String tabName, String tabValue, Function function) {
    return InkWell(
      onTap: function,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[

            Text(tabValue, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.white)),

            Text(tabName, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: ColorManager.white))
          ],
        ),
      ),
    );
  }

  Widget profilePhoto(String url) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: ColorManager.white,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: CircleAvatar(
        child: ClipOval(
            child: cachedImage(url, width: 60, height: 60, fit: BoxFit.cover)
        ),
        backgroundColor: ColorManager.white,
      ),
    );
  }


  Widget username(String username) {
    return Text(username,
        style: const TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold, fontSize: 16)
    );
  }

  Widget gradeLevel(String level) {
    return Container(
        color: ColorManager.red,
        padding: const EdgeInsets.only(left: 3, right: 3),
        margin: const EdgeInsets.only(left: 6),
        alignment: Alignment.centerLeft,
        height: 12,
        child: Text(memberInfoResponse.gradeLevel, style: const TextStyle(color: ColorManager.white, fontSize: 8))
    );
  }

  Widget tag(String tagValue) {
    return MemberHeaderTag(
      color: ColorManager.transparent,
      borderColor: ColorManager.main,
      borderWidth: 1,
      height: 14,
      text: Text(tagValue, style: const TextStyle(color: ColorManager.main, fontSize: 10)),
    );
  }
}