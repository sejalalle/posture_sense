class PostureReport {
  final double score;
  final double neckAngle;
  final bool forwardHead;
  final String severity;
  final String recommendation;

  PostureReport({
    required this.score,
    required this.neckAngle,
    required this.forwardHead,
    required this.severity,
    required this.recommendation,
  });
}