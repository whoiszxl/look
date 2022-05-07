import 'package:flutter/material.dart';
import 'package:look_flutter/entity/response/banner_response.dart';
import 'package:look_flutter/widgets/arc_clipper.dart';

import 'home_banner.dart';

///轮播bar组件
class BannerBar extends StatelessWidget {

  final List<BannerEntity> bannerList;

  const BannerBar({Key key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: ArcClipper(),

          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  colors: <Color>[Theme.of(context).scaffoldBackgroundColor, Theme.of(context).scaffoldBackgroundColor],
                )
            ),
            child: Container(
              height: 145,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 8),
            child: HomeBanner(bannerList),
          ),
        ),
      ],
    );
  }
}