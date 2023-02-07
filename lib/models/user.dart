class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}

class User {
  final String id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  User copyWith({
    required String id,
    required String name,
  }) =>
      User(
        id: id,
        name: name,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
