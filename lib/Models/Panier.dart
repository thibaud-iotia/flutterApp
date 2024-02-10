class Panier {
  int activityId;

  Panier({
    required this.activityId,
  });

  factory Panier.fromJson(Map<String, dynamic> json) {
    return Panier(
      activityId: json['activityId'] ?? 0,
    );
  }
}