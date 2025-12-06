class Profile {
  final String name;
  final String email;
  final String id;

  Profile({required this.name, required this.email, required this.id});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["userName"]!,
      email: json["email"]!,
      id: json["userId"]!,
    );
  }
}
