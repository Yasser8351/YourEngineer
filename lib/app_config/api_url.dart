class ApiUrl {
  static const String _root =
      'https://talented-trench-coat-eel.cyclic.app/api/v1';
  static String get signup => _root + '/auth/signup';
  static String get signin => _root + '/auth/signin';
  static String get geCategory => _root + '/category';

  static Map<String, String> getHeader() {
    return <String, String>{
      // "content-type": "application/json",
      // "accept": "application/json",
      //'accept': '*/*',
      'Authorization':
          'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQzYjAwMDg4LTVlNWYtNGIzNi04YjFhLTU0ZWQyZGFhYThmMSIsInJvbGVfaWQiOiJmMWY0YTUwOS0zYjk1LTExZWQtODY4Ni1lY2Y0YmI4M2IxOWIiLCJlbWFpbCI6InJhc2hlZWRAZzEuY29tIiwicGFzc3dvcmQiOiIkMmEkMTAkMmNuaFlSRy5ReUw0cDd0eDQ1dnZtZUpxTUJMeXZBMXM4aW44WGJrTU1QZHF1a1ZxZHZkQ0MiLCJmdWxsbmFtZSI6InJhc2hlZWQgZmFpc2FsIiwicGhvbmUiOiIwOTAwOTkwMDk5IiwiaW1nUGF0aCI6InVwbG9hZHNcXDIwMjItMDktMjNUMjNfMzlfMzUuODI4WmF1dG9jYXJzTG9naW4uUE5HIiwiY3JlYXRlZEF0IjoiMjAyMi0wOS0yM1QyMzozOTozNS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyMi0wOS0yM1QyMzozOTozNS4wMDBaIiwiaWF0IjoxNjY0NTYyMjE2LCJleHAiOjE2NjQ2NDg2MTZ9.j1pu6_rPvajlUkC7UcAklH3s92XYHvR-cBbA9TUHtrs',

      'Content-Type': 'application/json'
    };
  }
}
