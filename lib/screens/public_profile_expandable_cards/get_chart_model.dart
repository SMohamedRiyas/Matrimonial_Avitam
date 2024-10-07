class User {
  final String image;

  User({required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(image: json['image']);
  }
}
