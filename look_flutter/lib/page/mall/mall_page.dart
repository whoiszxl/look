import 'package:flutter/material.dart';

///会员购页面
class MallPage extends StatefulWidget {
  const MallPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MallPageState();
  }
}

class _MallPageState extends State<MallPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: const [
          Center(child: Text("会员购"))
        ]
      ),
    );
  }
}