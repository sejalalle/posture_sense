import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/posture_history.dart';
import '../../services/history_service.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final HistoryService service = HistoryService();

  Color getScoreColor(double score) {
    if (score >= 90) return Colors.green;
    if (score >= 75) return Colors.lightGreen;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posture History"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<PostureHistory>>(
        stream: service.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            );
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return const Center(
              child: Text(
                "No posture scans yet.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                getScoreColor(item.score),

                            child: Text(
                              item.score
                                  .toStringAsFixed(0),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [

                                Text(
                                  item.posture,
                                  style:
                                      const TextStyle(
                                    fontSize: 19,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  DateFormat(
                                    'dd MMM yyyy • hh:mm a',
                                  ).format(item.date),
                                  style:
                                      const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [

                          const Icon(
                            Icons.straighten,
                            color: Colors.blue,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            "Neck Angle : ${item.angle.toStringAsFixed(1)}°",
                            style:
                                const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [

                          const Icon(
                            Icons.health_and_safety,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            "Score : ${item.score.toStringAsFixed(0)}/100",
                            style:
                                const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        height: 28,
                      ),

                      const Text(
                        "Recommendation",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        item.recommendation,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}