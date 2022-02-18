import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Counter1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Counter1Provider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Counter1Provider>();

    return Container();
  }
}

