class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      // THE FIX: Safely parse the ID whether it comes as an int (1) or String ("1")
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'],
      email: json['email'],
      token: token,
    );
  }
}
