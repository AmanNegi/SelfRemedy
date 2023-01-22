class AppData {
  String name;
  String email;
  bool isLoggedIn;
  bool isFirstTime;

  AppData({
    required this.name,
    required this.isLoggedIn,
    required this.isFirstTime,
    required this.email,
  });

  factory AppData.fromJSON(Map data) => AppData(
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      isLoggedIn: data['isLoggedIn'] ?? false,
      isFirstTime: data['isFirstTime'] ?? true);

  factory AppData.empty() =>
      AppData(name: '', isLoggedIn: false, isFirstTime: true, email: '');

  toJson() => {
        'name': name,
        'isLoggedIn': isLoggedIn,
        'isFirstTime': isFirstTime,
        'email': email
      };
}
