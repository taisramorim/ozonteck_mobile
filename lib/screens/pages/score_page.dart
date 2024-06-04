import 'package:flutter/material.dart';
import 'package:ozonteck_mobile/components/score/pins_level.dart';
import 'package:ozonteck_mobile/components/score/score_display.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ScoringPoints> scoringList = List.generate(100, (index) {
      return ScoringPoints(
        id: index.toString(), 
        productName: 'Product $index', 
        points: 10 * index, 
        date: DateTime.now()
        );
    });

    int totalPoints = scoringList.fold<int>(0, (sum, scoring) => sum + scoring.points);

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
                const SizedBox(height: 20),
                ScoreDisplay(
                  currentPoints: totalPoints, 
                  nextLevelPoints: totalPoints + 10500, 
                  imageUrl: pinsLevelMapping[7].imageUrl),
                const SizedBox(height: 5),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 101,
                    itemBuilder: (context, index) {
                      final scoring = ScoringPoints(
                        id: index.toString(),
                        productName: 'Product $index',
                        points: 10 * index,
                        date: DateTime.now(),
                      );
                      return ListTile(
                        title: Text(scoring.productName),
                        subtitle: Text(scoring.points.toString()),
                        trailing: Text(scoring.date.toString()),
                      );
                    }
                  ) 
                ),
              ],
            ),
          ),
    );
  }
}

// Example of a model

class ScoringPoints {
  final String id;
  final String productName;
  int points;
  final DateTime date;

  ScoringPoints({
    required this.id,
    required this.productName,
    required this.points,
    required this.date,
  });
}