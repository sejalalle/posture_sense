import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final double score;
  final String status;

  const ScoreCard({
    super.key,
    required this.score,
    required this.status,
  });

  Color get scoreColor {
    if (score >= 90) return Colors.green;

    if (score >= 75) return Colors.lightGreen;

    if (score >= 60) return Colors.orange;

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 28,
          horizontal: 20,
        ),
        child: Column(
          children: [

            const Text(
              "Today's Posture Score",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Stack(
              alignment: Alignment.center,
              children: [

                SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 12,
                    color: scoreColor,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),

                Column(
                  children: [

                    Text(
                      score.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      "/100",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                  ],
                )
              ],
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: scoreColor.withOpacity(.15),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}