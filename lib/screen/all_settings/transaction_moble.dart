class TransactionsHistory {
  TransactionsHistory({
    required this.totalItems,
    required this.results,
    required this.totalPages,
    required this.currentPage,
  });
  late final int totalItems;
  late final List<Results> results;
  late final int totalPages;
  late final int currentPage;

  TransactionsHistory.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'] ?? 0;
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
    totalPages = json['totalPages'] ?? 0;
    currentPage = json['currentPage'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalItems'] = totalItems;
    _data['results'] = results.map((e) => e.toJson()).toList();
    _data['totalPages'] = totalPages;
    _data['currentPage'] = currentPage;
    return _data;
  }
}

class Results {
  Results({
    required this.id,
    required this.amount,
    required this.attachment,
    required this.accepted,
    required this.isTransfered,
    required this.createdAt,
    required this.user,
  });
  late final String id;
  late final String amount;
  late final String attachment;
  late final bool accepted;
  late final bool isTransfered;
  late final String createdAt;
  late final User user;

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    amount = json['amount'] ?? "";
    attachment = json['attachment'] ?? "";
    accepted = json['accepted'] ?? false;
    isTransfered = json['is_transfered'] ?? false;
    createdAt = json['createdAt'] ?? "";
    user = User.fromJson(json['User']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['amount'] = amount;
    _data['attachment'] = attachment;
    _data['accepted'] = accepted;
    _data['is_transfered'] = isTransfered;
    _data['createdAt'] = createdAt;
    _data['User'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.roleId,
    required this.email,
    required this.password,
    required this.fullname,
    required this.phone,
    required this.imgPath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.wallet,
  });
  late final String id;
  late final String roleId;
  late final String email;
  late final String password;
  late final String fullname;
  late final String phone;
  late final String imgPath;
  late final bool isActive;
  late final String createdAt;
  late final String updatedAt;
  late final Roles role;
  late final Wallet wallet;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    roleId = json['role_id'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    fullname = json['fullname'] ?? "";
    phone = json['phone'] ?? "";
    imgPath = json['imgPath'] ?? "";
    isActive = json['is_active'] ?? false;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    role = Roles.fromJson(json['Role']);
    wallet = Wallet.fromJson(json['wallet']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['role_id'] = roleId;
    _data['email'] = email;
    _data['password'] = password;
    _data['fullname'] = fullname;
    _data['phone'] = phone;
    _data['imgPath'] = imgPath;
    _data['is_active'] = isActive;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['wallet'] = wallet.toJson();
    return _data;
  }
}

class Roles {
  Roles({
    required this.roleName,
  });
  late final String roleName;

  Roles.fromJson(Map<String, dynamic> json) {
    roleName = json['role_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['role_name'] = roleName;
    return _data;
  }
}

class Wallet {
  Wallet({
    required this.id,
    required this.userId,
    required this.credit,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String userId;
  late final String credit;
  late final String createdAt;
  late final String updatedAt;

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['user_id'] ?? "";
    credit = json['credit'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['credit'] = credit;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}
