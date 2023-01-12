class ApiUrl {
  static const String _root =
      'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1';
  // 'https://calm-cyan-bullfrog-tie.cyclic.app/api/v1/';
  static String get signup => '$_root/auth/signup';
  static String get signin => '$_root/auth/signin';
  static String get geCategory => '$_root/category';
  static String get getTopEngineer => '$_root/profile';
  static String get getProject => '$_root/project?page=1&size=10';
  static String get addProject => '$_root/project';
  static String get getRoles => '$_root/auth/roles';
  static String get getFaq => '$_root/questions';

  static int get timeoutDuration => 20;

  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      // "accept": "application/json",
      'Accept': '*/*',
      'Authorization': "Bearer $token",
      // 'Authorization':
      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI5YTQ5YTIzOC0yMThmLTRlYjMtODQwNy0xZGIwN2FjN2RjMzciLCJlbWFpbCI6InRlc3QxMjM0NSIsImZ1bGxuYW1lIjoidGVzdDEyMyIsImlhdCI6MTY3MzU0MjQ0MCwiZXhwIjoxNjczNTQ2MDQwfQ.eEoFPfwsjRgxcMzGRarzvIVrWriBUFZLBQGRJSwGNS4',
      'Content-Type': 'application/json'
    };
  }
}
