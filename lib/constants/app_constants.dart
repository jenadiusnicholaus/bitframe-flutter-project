class Constants {
  static String onlineTesturl = 'http://bitframe.pythonanywhere.com';
  static String localTestUrl = 'http://10.0.2.2:8000';
  static var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  List<String> urls = [];

  static const String Profile = "View Profile";
  static const String Myframes = "My frames";
  static const String Logout = "logout";
  static const String Version = "v 1.0.0";

  static const List<String> choices = <String>[
    Profile,
    Myframes,
    Logout,
    Version
  ];
}
