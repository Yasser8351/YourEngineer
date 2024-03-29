import 'dart:convert';

class Wallet {
  Wallet({
    required this.status,
    required this.data,
  });

  final bool status;
  final int data;

  factory Wallet.fromRawJson(String str) => Wallet.fromJson(json.decode(str));

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        status: json["status"],
        data: json["data"],
      );
}
