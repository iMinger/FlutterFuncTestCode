import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Counter2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Counter2Provider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Counter2Provider>();
    final state = provider.state;

    return Container();
  }
}