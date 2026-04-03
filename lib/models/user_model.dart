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

      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'],
      email: json['email'],
      token: token,
    );
  }
}
