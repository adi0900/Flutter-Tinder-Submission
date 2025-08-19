class User {
  final String id;
  final String name;
  final int age;
  final String bio;
  final String profileImage;
  final List<String> interests;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.profileImage,
    required this.interests,
  });
}