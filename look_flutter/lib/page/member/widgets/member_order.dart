
import 'package:flutter/material.dart';
import 'package:look_flutter/res/colors_manager.dart';

///会员订单组件
class MemberOrder extends StatelessWidget {

  MemberOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 190,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.all(Radius.circular(10))),

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              orderTab(Icons.book_outlined, "我的课程", ColorManager.main, () {

              }),
              orderTab(Icons.sim_card_outlined, "看视频免流量", ColorManager.main, () {

              }),
              orderTab(Icons.toys_outlined, "个性装扮", ColorManager.main, () {

              }),
              orderTab(Icons.wallet_travel_outlined, "我的钱包", ColorManager.main, () {

              }),

              orderTab(Icons.videogame_asset_outlined, "游戏中心", ColorManager.main, () {

              }),


            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              orderTab(Icons.shopping_cart_outlined, "会员购中心", ColorManager.main, () {

              }),
              orderTab(Icons.live_tv, "直播中心", ColorManager.main, () {

              }),
              orderTab(Icons.business_center_outlined, "创作中心", ColorManager.main, () {

              }),
              orderTab(Icons.house_siding_outlined, "社区中心", ColorManager.main, () {

              }),

              orderTab(Icons.public_outlined, "LOOK公益", ColorManager.main, () {

              }),


            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              orderTab(Icons.system_security_update_good_outlined, "领福利", ColorManager.main, () {

              }),
              orderTab(Icons.wb_incandescent_outlined, "签到", ColorManager.main, () {

              }),
              orderTab(Icons.star_outline, "抽奖", ColorManager.main, () {

              }),
              orderTab(Icons.history_outlined, "浏览记录", ColorManager.main, () {

              }),

              orderTab(Icons.support_outlined, "幸运转盘", ColorManager.main, () {

              }),

            ],
          )


        ],
      ),
    );

  }


  orderTab(IconData tabIcon, String tabName, Color color, Function function) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: function,
        child: SizedBox(
          height: 60,
          child: Column(
            children: <Widget>[
              //ICON
              Icon(tabIcon, size: 30, color: color),
              //文字
              Text(tabName, style: const TextStyle(color: ColorManager.black87, fontSize: 10, fontWeight: FontWeight.normal))

            ],
          ),
        ),
      ),
    );

  }

}