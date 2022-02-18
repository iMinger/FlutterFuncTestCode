

import 'package:flutter/cupertino.dart';

class TestCallWidget extends StatelessWidget {

  const TestCallWidget({Key? key, this.onBack, this.onTap}) : super(key: key);
  final VoidCallback? onTap;
  final VoidCallback? onBack;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        /// 未使用.call() 的操作
        // if (onTap != null) onTap!();
        // if (onBack != null) onBack!();

        /// 使用了.call()的操作
        onTap?.call();
        onBack?.call();

      },
      child: Container(),
    );
  }

}