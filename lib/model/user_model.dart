class UserModel {
  UserModel({
    required this.token,
    required this.lastName,
    required this.fistName,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.userId,
    required this.userImage,
  });

  String token;
  String fistName;
  String lastName;
  String fullName;
  String email;
  String phone;
  String userId;
  String userImage;
}

class UserDataLogin {
  UserDataLogin({
    required this.userId,
    required this.isActive,
    required this.email,
    required this.password,
    required this.role_id,
    required this.fullName,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  String userId;
  bool isActive;
  String email;
  String password;
  String fullName;
  String phone;
  String role_id;
  String updatedAt;
  String createdAt;
}
