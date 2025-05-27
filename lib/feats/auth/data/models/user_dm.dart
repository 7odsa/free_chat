class UserDM {
  final String id;
  final String username;
  final String email;
  final String imagePath;

  UserDM({
    required this.id,
    required this.username,
    required this.email,
    required this.imagePath,
  });

  static UserDM? currUser;
}
