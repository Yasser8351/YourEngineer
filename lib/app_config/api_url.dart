class ApiUrl {
  static const String _root = 'http://62.171.175.75:83/api/v1';
  // static const String _root = 'http://62.171.175.75:3000/api';
  // static const String _root = 'http://194.195.87.30:91/api/v1';

  static const String root = _root;
  //http://62.171.175.75:83/uploads/2024-03-22T18_19_59.517Zuse_chat.PNG",
  static const String imageUrl = "http://62.171.175.75:83/";

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
  static String get profile => '$_root/profile';
  static String get getProjectsOffers => '$_root/offer/project/';
  static String get getRoles => '$_root/auth/roles';
  static String get getNotificationUnRead => '$_root/users/me';
  static String get getFaq => '$_root/questions';
  static String get getUsersShow => '$_root/users/show';
  static String get resetPassword => '$_root/auth/forgot-password';
  static String get contactUs => '$_root/support';
  static String get getPaypal => '$_root/site/paypal';
  static String get getCurrentrateCommission => '$_root/site/currentrate';
  static String get getCreditcard => '$_root/site/creditcard';
  static String get getCommission => '$_root/site/currentrate';
  static String get getPrivacyPolicy => '$_root/site/privacy';

  /// chat url
  static String getLastchats(
      {required int page, required int size, String search = ''}) {
    return '$_root/conversations/lastchats?page=1&size=20&search=$search';
  }

  static String getChatBetweenUsers({required int page, required int size}) {
    return '$_root/conversations/chat?page=$page&size=$size';
  }

  static String get createChat => '$_root/conversations';

  ///

  static String getUsersById(String id) {
    return '$_root/users/show/$id';
  }

  static String getAllNotification(int page, int size) {
    return '$_root/notification?page=$page&size=$size';
  }

  static String acceptOffer(String offerId) {
    return '$_root/offer/project/inprogress/$offerId';
  }

  static String readNotification(String notificationId) {
    return '$_root/notification/unread/$notificationId';
  }

  static String get getOwnerProject => '$_root/project/owner';
  static String get getPricerange => '$_root/pricerange';
  static String get getSubCatigory => '$_root/category/subcat/';
  static String get getProjectBySubCatigory =>
      '$_root/project/subcat?page=1&size=10&scatid=';

  static String getProjectById(String projectId) {
    return '$_root/project/$projectId';
  }

  static int get timeoutDuration => 30;

  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      'Accept': '*/*',
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json'
    };
  }

  static Map<String, String> getHeader2({required String token}) {
    return <String, String>{
      'Accept': '*/*',
      'Authorization': "Bearer $token",
    };
  }

  static Map<String, String> getHeaderImage({required String token}) {
    return <String, String>{
      'Accept': '*/*',
      'Authorization': "Bearer $token",
      'Content-Type': 'multipart/form-data',
    };
  }
}
