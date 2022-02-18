

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_study/test_notifier_controller.dart';
import 'package:provider_study/test_notifier_widget.dart';

class TestNotifierPage extends StatelessWidget {
  const TestNotifierPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = TestNotifierController();
    var count = 0;
    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifier使用演示')),
      body: Center(
        child: TestNotifierWidget(controller: controller),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.value = '数值变化:${(++count).toString()}';
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}