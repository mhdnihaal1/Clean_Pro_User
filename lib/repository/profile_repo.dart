import 'dart:convert';
import 'package:clean_pro_user/constants/urls.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/model/profile_model.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final String baseUrl = AppUrls.baseUrl;

  Future<ProfileResponse> getProfile() async {
    try {
      final String? userId = await AuthLocalRepo.getToken();
      final response =
          await http.get(Uri.parse('$baseUrl/profileData/$userId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return ProfileResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}

// class ProfileResponse {
//   final bool success;
//   final ProfileData data;

//   ProfileResponse({required this.success, required this.data});

//   factory ProfileResponse.fromJson(Map<String, dynamic> json) {
//     return ProfileResponse(
//       success: json['success'] as bool,
//       data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'success': success,
//         'data': data.toJson(),
//       };

//   @override
//   String toString() => 'ProfileResponse(success: $success, data: $data)';
// }

class ProfileData {
  final User user;
  final List<Address> addresses;

  ProfileData({required this.user, required this.addresses});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => 'ProfileData(user: $user, addresses: $addresses)';
}

class User {
  final String id;
  final String name;
  final int mobile;
  final String email;
  final bool userStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.userStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as int,
      email: json['email'] as String,
      userStatus: json['userStatus'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'userStatus': userStatus,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };

  @override
  String toString() {
    return 'User(id: $id, name: $name, mobile: $mobile, email: $email, '
        'userStatus: $userStatus, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}

class Address {
  final String id;
  final String userId;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Location location;

  Address({
    required this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'],
      userId: json['userId'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      isDefault: json['isDefault'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'location': location.toJson(),
    };
  }

  @override
  String toString() {
    return 'Address(id: $id, userId: $userId, street: $street, city: $city, state: $state, postalCode: $postalCode, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
  }
}
