

import 'package:flutter/cupertino.dart';
import 'package:provider_study/test_notifier_controller.dart';

class TestNotifierWidget extends StatefulWidget {

  const TestNotifierWidget({Key? key, this.controller}) : super(key: key);
  final TestNotifierController? controller;
  @override
  State<StatefulWidget> createState() {
    return TestNotifierWidgetState();
  }
  
}
class TestNotifierWidgetState extends State<TestNotifierWidget> {
  @override
  void initState() {
    /// 添加回调 value 改变时，自动触发回调内容
    widget.controller?.addListener(_change);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.controller?.value ?? '初始值为空',
      style: const TextStyle(fontSize: 30),
    );
  }
  /// private function
  /// 被触发的回调
  void _change(){
    setState(() {});
  }
  
}