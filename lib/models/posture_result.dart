class PostureResult {
  final double neckAngle;
  final bool forwardHead;
  final String severity;
  final String recommendation;

  const PostureResult({
    required this.neckAngle,
    required this.forwardHead,
    required this.severity,
    required this.recommendation,
  });
}