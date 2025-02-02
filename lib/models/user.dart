class User {
  String username;
  String fullName;
  String bio;
  String contactNumber;
  String? imagePath;

  User({
    required this.username,
    required this.fullName,
    required this.bio,
    required this.contactNumber,
    this.imagePath,
  });
}
