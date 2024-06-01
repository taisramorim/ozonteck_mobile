import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget{
  final int currentPoints;
  final int nextLevelPoints;
  final String imageUrl;

  const ScoreDisplay({
    super.key,
    required this.currentPoints,
    required this.nextLevelPoints,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the progress percentage
    double progress = (currentPoints / nextLevelPoints).clamp(0.0, 1.0);

    return Container(
      height: 150,
      width: 350,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onTertiary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            imageUrl,
            height: 70,
            width: 70,
          ),
          const SizedBox(height: 20),
          // Ponints and progress bar
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$currentPoints / $nextLevelPoints',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              // Progress bar
              Container(
                height: 10,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}