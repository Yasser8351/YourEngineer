class ApiUrl {
  static const String _root =
      'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1';
  //https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/
  static String get signup => '$_root/auth/signup';
  static String get signin => '$_root/auth/signin';
  static String get geCategory => '$_root/category';
  static String get getTopEngineer => '$_root/users/enginners?page=1&size=5';
  static String get getProject => '$_root/project?page=1&size=10&search=';
  static String get addProject => '$_root/project';
  static String get addoffer => '$_root/offer';
  static String get accountChargeRequest => '$_root/payments/feed';
  static String get addPaypal => '$_root/payments/withdraw/paypal ';
  static String get addVisa => '$_root/payments/withdraw/creditcard ';
  static String get addprotofilio => '$_root/profile/portfolio';
  static String get addskill => '$_root/profile/skill';
  static String get getProjectsOffers => '$_root/offer/project/';
  static String get getRoles => '$_root/auth/roles';
  static String get getFaq => '$_root/questions';
  static String get getUsersShow => '$_root/users/show';
  static String get resetPassword => '$_root/reset';
  // static String get acceptOffer => '$_root/offer/project/inprogress';
  static String getUsersById(String id) {
    return '$_root/users/show/$id';
  }

  static String acceptOffer(String offerId) {
    return '$_root/offer/project/inprogress/$offerId';
  }

  static String get getOwnerProject => '$_root/project/owner';
  static String get getPricerange => '$_root/pricerange';
  static String get getSubCatigory => '$_root/category/subcat/';
  static String get getProjectBySubCatigory =>
      '$_root/project/subcat?page=1&size=10&scatid=';

  static String getProjectById(String projectId) {
    return '$_root/project/$projectId';
  }

  static int get timeoutDuration => 20;

  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      'Accept': '*/*',
      'Authorization': "Bearer $token",
      // 'Authorization':
      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI5YTQ5YTIzOC0yMThmLTRlYjMtODQwNy0xZGIwN2FjN2RjMzciLCJlbWFpbCI6InRlc3QxMjM0NSIsImZ1bGxuYW1lIjoidGVzdDEyMyIsImlhdCI6MTY3MzU0MjQ0MCwiZXhwIjoxNjczNTQ2MDQwfQ.eEoFPfwsjRgxcMzGRarzvIVrWriBUFZLBQGRJSwGNS4',
      'Content-Type': 'application/json'
    };
  }

  static Map<String, String> getHeader2({required String token}) {
    return <String, String>{
      'Accept': '*/*',
      'Authorization': "Bearer $token",
    };
  }
}
