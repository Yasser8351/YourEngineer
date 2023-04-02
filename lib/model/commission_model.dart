class CommissionModel {
  String? id;
  double? ratepercent;
  bool? iscurrent;
  String? createdAt;
  String? updatedAt;

  CommissionModel(
      {required this.id,
      required this.ratepercent,
      required this.iscurrent,
      required this.createdAt,
      required this.updatedAt});

  CommissionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    ratepercent = json['ratepercent'] ?? '';
    iscurrent = json['iscurrent'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ratepercent'] = this.ratepercent;
    data['iscurrent'] = this.iscurrent;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
