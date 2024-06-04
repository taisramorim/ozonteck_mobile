import 'package:flutter/material.dart';
import 'package:ozonteck_mobile/components/score/pins_level.dart';
import 'package:ozonteck_mobile/components/score/score_display.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            title: const Text('Score Page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScoreDisplay(
                  currentPoints: 50000, 
                  nextLevelPoints: 150000, 
                  imageUrl: pinsLevelMapping[7].imageUrl),
              ],
            ),
          ),
    );
  }
}