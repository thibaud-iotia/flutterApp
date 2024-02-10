class User {
  int id;
  String login;
  String password;
  String adress;
  String city;
  String birthday;
  String postalCode;

  User({required this.login, required this.password, required this.adress, required this.city, required this.birthday, required this.postalCode, required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      login: json['login'] ?? "",
      password: json['password'] ?? "",
      adress: json['adress'] ?? "",
      city: json['city'] ?? "",
      birthday: json['birthday'] ?? "",
      postalCode: json['postalCode'] ?? "",
    );
  }
}