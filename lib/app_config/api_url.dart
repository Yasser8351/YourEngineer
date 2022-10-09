class ApiUrl {
  static const String _root =
      'https://talented-trench-coat-eel.cyclic.app/api/v1';
  static String get signup => '$_root/auth/signup';
  static String get signin => '$_root/auth/signin';
  static String get geCategory => '$_root/category';
  static String get getTopEngineer => '$_root/profile';
  static String get getProject => '$_root/project';

  static int get timeoutDuration => 20;

  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      // "accept": "application/json",
      'Accept': '*/*',
      // 'Authorization': token,
      'Authorization':
          'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQzYjAwMDg4LTVlNWYtNGIzNi04YjFhLTU0ZWQyZGFhYThmMSIsInJvbGVfaWQiOiJmMWY0YTUwOS0zYjk1LTExZWQtODY4Ni1lY2Y0YmI4M2IxOWIiLCJlbWFpbCI6InJhc2hlZWRAZzEuY29tIiwicGFzc3dvcmQiOiIkMmEkMTAkMmNuaFlSRy5ReUw0cDd0eDQ1dnZtZUpxTUJMeXZBMXM4aW44WGJrTU1QZHF1a1ZxZHZkQ0MiLCJmdWxsbmFtZSI6InJhc2hlZWQgZmFpc2FsIiwicGhvbmUiOiIwOTAwOTkwMDk5IiwiaW1nUGF0aCI6InVwbG9hZHNcXDIwMjItMDktMjNUMjNfMzlfMzUuODI4WmF1dG9jYXJzTG9naW4uUE5HIiwiY3JlYXRlZEF0IjoiMjAyMi0wOS0yM1QyMzozOTozNS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyMi0wOS0yM1QyMzozOTozNS4wMDBaIiwiaWF0IjoxNjY1MzI2NTU1LCJleHAiOjE2NjU0MTI5NTV9.rkJ1iOhSK9W9xb9sl35A5Jsh1dmUKS6h-tox-Cd3f50',
      'Content-Type': 'application/json'
    };
  }
}
