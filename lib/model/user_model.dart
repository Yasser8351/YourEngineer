class UserModel {
  UserModel({
    required this.token,
    required this.lastName,
    required this.fistName,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.userId,
  });

  String token;
  String fistName;
  String lastName;
  String fullName;
  String email;
  String phone;
  int userId;
}
