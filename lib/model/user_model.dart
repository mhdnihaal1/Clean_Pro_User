class User {
  final String id;
  final String name;
  final int mobile;
  final String email;
  final bool userStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.userStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      userStatus: json['userStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'userStatus': userStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, mobile: $mobile, email: $email, userStatus: $userStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

 static User? convertJsonToUser(Map<String, dynamic> jsonResponse) {
  if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
    return User.fromJson(jsonResponse['data']);
  }
  return null;
}
}

