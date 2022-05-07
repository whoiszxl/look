import 'package:flutter/material.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/res/colors_manager.dart';
import 'package:oktoast/oktoast.dart';

class HomeGridNavigator extends StatelessWidget {

  final List<NavigationEntity> navigatorList;

  final double gridHeight;
  final double gridWidth;

  const HomeGridNavigator({Key key, this.navigatorList, this.gridHeight = 160, this.gridWidth = 375}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //移除多余的导航框
    if(navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }

    var tempIndex = -1;
    return Container(
      margin: const EdgeInsets.only(top: 0),
      height: gridHeight,
      width: gridWidth,
      padding: const EdgeInsets.all(2),

      child: GridView.count(
        physics: const AlwaysScrollableScrollPhysics(),
        mainAxisSpacing: 1,
        crossAxisCount: 6,

        padding: const EdgeInsets.all(1),
        children: navigatorList.map((item) {
          tempIndex++;
          return _item(context, item, tempIndex);
        }).toList(),
      ),
    );
  }


  ///构建网格导航中的每个方块栏
  Widget _item(BuildContext context, NavigationEntity item, index) {
    return InkWell(
      onTap: () {
        //TODO 创建点击事件
        showToast("点击了" + item.name);
      },

      child: Column(
        children: <Widget>[
          Image.network(item.pic, width: 40, height: 40),
          Text(item.name, style: const TextStyle(color: ColorManager.fontGrey, fontSize: 13))
        ],
      ),
    );
  }

}