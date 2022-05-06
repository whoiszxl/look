import 'package:flutter/material.dart';

///动态页面
class DyncPage extends StatefulWidget {
  const DyncPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DyncPageState();
  }
}

class _DyncPageState extends State<DyncPage>{

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
          Center(child: Text("动态"))
        ]
      ),
    );
  }
}