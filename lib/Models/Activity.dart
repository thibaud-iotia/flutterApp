class Activity {
  int id;
  String titre;
  String lieu;
  int prix;
  String image;
  String categorie;
  int nbParticipants;

  Activity({
    required this.id,
    required this.titre,
    required this.lieu,
    required this.prix,
    required this.image,
    required this.categorie,
    required this.nbParticipants,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? 0,
      titre: json['titre'] ?? "",
      lieu: json['lieu'] ?? "",
      prix: json['prix'] ?? 0,  
      image: json['image'] ?? "",
      categorie: json['categorie'] ?? "",
      nbParticipants: json['nbParticipants'] ?? 0,
    );
  }
}
