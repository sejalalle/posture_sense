import '../models/dashboard_model.dart';
import '../models/posture_history.dart';

class DashboardService {
  DashboardModel generate(List<PostureHistory> history) {
    if (history.isEmpty) {
      return const DashboardModel(
        totalScans: 0,
        averageScore: 0,
        bestScore: 0,
        worstScore: 0,
        lastScore: 0,
      );
    }

    double total = 0;
    double best = history.first.score;
    double worst = history.first.score;

    for (final item in history) {
      total += item.score;

      if (item.score > best) {
        best = item.score;
      }

      if (item.score < worst) {
        worst = item.score;
      }
    }

    return DashboardModel(
      totalScans: history.length,
      averageScore: total / history.length,
      bestScore: best,
      worstScore: worst,
      lastScore: history.first.score,
    );
  }
}