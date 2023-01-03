class ApiUrl {
  static const String _root =
      'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1';
  // 'https://talented-trench-coat-eel.cyclic.app/api/v1';
  static String get signup => '$_root/auth/signup';
  static String get signin => '$_root/auth/signin';
  static String get geCategory => '$_root/category';
  static String get getTopEngineer => '$_root/profile';
  static String get getProject => '$_root/project?page=1&size=10';
  static String get addProject => '$_root/project';

  static int get timeoutDuration => 20;

  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      // "accept": "application/json",
      'Accept': '*/*',
      // 'Authorization': 'Bearer $token',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2ZGE1MTk2Zi0xZGRiLTQ0ZmItODBmZC1hMWRjOTRkNGU5M2EiLCJlbWFpbCI6Inlhc3NlcjgzNUBnbWFpbC5jb20iLCJmdWxsbmFtZSI6Illhc3NlciIsImlhdCI6MTY3Mjc2NDMxOCwiZXhwIjoxNjcyNzY3OTE4fQ.IJ9Ldo1uj0m9w3n3nmeA7oMGJTIpP4EEm9kPmRboBe0',
      'Content-Type': 'application/json'
    };
  }
}
