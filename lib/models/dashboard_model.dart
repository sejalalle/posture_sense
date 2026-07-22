class DashboardModel {
  final int totalScans;
  final double averageScore;
  final double bestScore;
  final double worstScore;
  final double lastScore;

  const DashboardModel({
    required this.totalScans,
    required this.averageScore,
    required this.bestScore,
    required this.worstScore,
    required this.lastScore,
  });
}