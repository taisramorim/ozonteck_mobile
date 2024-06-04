import 'package:flutter/material.dart';

class NetPage extends StatelessWidget {
  const NetPage({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
    );
  }
}