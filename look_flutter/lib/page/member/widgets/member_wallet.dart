import 'package:flutter/material.dart';
import 'package:look_flutter/res/colors_manager.dart';

///会员资产组件
class MemberWallet extends StatelessWidget {

  const MemberWallet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          walletTab("187", "离线缓存", "点击查看缓存", Colors.black, () {}),
          walletTab("199", "历史记录", "查看历史", Colors.black, () {}),
          walletTab("55", "我的收藏", "查看收藏", Colors.black, () {}),
          walletTab("16", "稍后再看", "点击查看", Colors.black, () {}),
          walletTab(Icons.account_balance_wallet_outlined, "我的钱包", "", ColorManager.main, () {}),

        ],
      ),

    );

  }


  walletTab(var tabIcon, String tabName, String subTabName, Color color, Function function) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: function,
        child: SizedBox(
          height: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              //ICON or value
              tabIcon is IconData ? Icon(tabIcon, size: 30, color: color)
                  : Text(tabIcon, style: const TextStyle(color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),

              SizedBox(
                height: 35,
                child: Column(
                  children: [
                    //主标题
                    Text(tabName, style: TextStyle(fontSize: 12, color: color)),

                    //副标题
                    Text(subTabName, style: const TextStyle(fontSize: 10, color: ColorManager.grey)),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}