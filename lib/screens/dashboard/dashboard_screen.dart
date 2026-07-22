import 'package:flutter/material.dart';

import '../../models/dashboard_model.dart';
import '../../models/posture_history.dart';
import '../../services/dashboard_service.dart';
import '../../services/history_service.dart';
import '../../widgets/score_card.dart';
import '../../widgets/statistics_card.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final HistoryService historyService = HistoryService();
  final DashboardService dashboardService = DashboardService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<PostureHistory>>(
        stream: historyService.getHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final history = snapshot.data!;
          final DashboardModel dashboard =
              dashboardService.generate(history);

          String status = "No Data";

          if (dashboard.lastScore >= 90) {
            status = "Excellent";
          } else if (dashboard.lastScore >= 75) {
            status = "Good";
          } else if (dashboard.lastScore >= 60) {
            status = "Needs Improvement";
          } else {
            status = "Poor";
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Welcome 👋",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Track your posture every day.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 25),

                ScoreCard(
                  score: dashboard.lastScore,
                  status: status,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Statistics",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.15,
                  children: [

                    StatisticsCard(
                      title: "Total Scans",
                      value: dashboard.totalScans.toString(),
                      icon: Icons.camera_alt,
                      color: Colors.blue,
                    ),

                    StatisticsCard(
                      title: "Average Score",
                      value:
                          dashboard.averageScore.toStringAsFixed(1),
                      icon: Icons.analytics,
                      color: Colors.green,
                    ),

                    StatisticsCard(
                      title: "Best Score",
                      value:
                          dashboard.bestScore.toStringAsFixed(0),
                      icon: Icons.emoji_events,
                      color: Colors.orange,
                    ),

                    StatisticsCard(
                      title: "Worst Score",
                      value:
                          dashboard.worstScore.toStringAsFixed(0),
                      icon: Icons.warning,
                      color: Colors.red,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text(
                      "Start New Scan",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: 25),

                if (history.isNotEmpty) ...[
                  const Text(
                    "Latest Scan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          history.first.score
                              .toStringAsFixed(0),
                        ),
                      ),
                      title: Text(history.first.posture),
                      subtitle:
                          Text(history.first.recommendation),
                      trailing: Text(
                        "${history.first.angle.toStringAsFixed(1)}°",
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}