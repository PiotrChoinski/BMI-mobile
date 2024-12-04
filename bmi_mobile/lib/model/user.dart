class User {
  final int? id;
  final String name;
  final String surname;
  final DateTime birthday;
  final int height;
  final int weight;
  final String gender;

  User({
    this.id,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'birthday': birthday.toIso8601String(),
      'height': height,
      'weight': weight,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      birthday: DateTime.parse(map['birthday']),
      height: map['height'],
      weight: map['weight'],
      gender: map['gender'],
    );
  }
}
