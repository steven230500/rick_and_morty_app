class User {
  final String name;

  User(this.name);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
    );
  }
}
