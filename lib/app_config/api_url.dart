class ApiUrl {
  static const String _root =
      'https://talented-trench-coat-eel.cyclic.app/api/v1';
  static String get signup => '$_root/auth/signup';
  static String get signin => '$_root/auth/signin';
  static String get geCategory =>
      'https://talented-trench-coat-eel.cyclic.app/api/v1/category';

  static Map<String, String> getHeader() {
    return <String, String>{
      // "content-type": "application/json",
      // "accept": "application/json",
      'Accept': '*/*',
      'Authorization':
          'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQzYjAwMDg4LTVlNWYtNGIzNi04YjFhLTU0ZWQyZGFhYThmMSIsInJvbGVfaWQiOiJmMWY0YTUwOS0zYjk1LTExZWQtODY4Ni1lY2Y0YmI4M2IxOWIiLCJlbWFpbCI6InJhc2hlZWRAZzEuY29tIiwicGFzc3dvcmQiOiIkMmEkMTAkMmNuaFlSRy5ReUw0cDd0eDQ1dnZtZUpxTUJMeXZBMXM4aW44WGJrTU1QZHF1a1ZxZHZkQ0MiLCJmdWxsbmFtZSI6InJhc2hlZWQgZmFpc2FsIiwicGhvbmUiOiIwOTAwOTkwMDk5IiwiaW1nUGF0aCI6InVwbG9hZHNcXDIwMjItMDktMjNUMjNfMzlfMzUuODI4WmF1dG9jYXJzTG9naW4uUE5HIiwiY3JlYXRlZEF0IjoiMjAyMi0wOS0yM1QyMzozOTozNS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyMi0wOS0yM1QyMzozOTozNS4wMDBaIiwiaWF0IjoxNjY0OTEyMzMyLCJleHAiOjE2NjQ5OTg3MzJ9.76vkxhdYmAVlWhBEGW5ojyXeda8m0xTOh88B-OfcqHI',
      'Content-Type': 'application/json'
    };
  }
}
