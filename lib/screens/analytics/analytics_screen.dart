import 'package:flutter/material.dart';

import '../../services/history_service.dart';
import '../../models/posture_history.dart';
import '../../widgets/progress_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({super.key});

  final HistoryService service = HistoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: StreamBuilder<List<PostureHistory>>(
        stream: service.getHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final history = snapshot.data!;

          final scores = history
              .map((e) => e.score)
              .toList()
              .reversed
              .toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [

              const Text(
                "Progress",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ProgressChart(scores: scores),

              const SizedBox(height: 30),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text("Average Score"),
                  trailing: Text(
                    history.isEmpty
                        ? "0"
                        : (scores.reduce((a, b) => a + b) /
                                scores.length)
                            .toStringAsFixed(1),
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text("Best Score"),
                  trailing: Text(
                    history.isEmpty
                        ? "0"
                        : scores
                            .reduce((a, b) => a > b ? a : b)
                            .toStringAsFixed(0),
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.timeline),
                  title: const Text("Total Scans"),
                  trailing: Text(history.length.toString()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}