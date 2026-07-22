class PostureHistory {
  final String id;
  final DateTime date;
  final double score;
  final double angle;
  final bool forwardHead;
  final String posture;
  final String recommendation;

  const PostureHistory({
    required this.id,
    required this.date,
    required this.score,
    required this.angle,
    required this.forwardHead,
    required this.posture,
    required this.recommendation,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date.toIso8601String(),
      "score": score,
      "angle": angle,
      "forwardHead": forwardHead,
      "posture": posture,
      "recommendation": recommendation,
    };
  }

  factory PostureHistory.fromMap(Map<String, dynamic> map) {
    return PostureHistory(
      id: map["id"],
      date: DateTime.parse(map["date"]),
      score: (map["score"] as num).toDouble(),
      angle: (map["angle"] as num).toDouble(),
      forwardHead: map["forwardHead"] ?? false,
      posture: map["posture"],
      recommendation: map["recommendation"],
    );
  }
}