class User {
  final int? id;
  final String username;
  final String password;
  final bool isGuest;

  User({
    this.id,
    required this.username,
    required this.password,
    this.isGuest = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'isGuest': isGuest ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      isGuest: map['isGuest'] == 1,
    );
  }
}
