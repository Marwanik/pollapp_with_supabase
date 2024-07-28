

import 'package:pollapp/domain/entities/user.dart';

class UserModel {
  final String? id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String maritalState;
  final String education;
  final String address;
  final String socialState;
  final int numberOfChildren;
  final String phoneNumber;
  final bool hasJob;
  final String role;
  final String? avatarUrl;
  final List<String> achievements; // Add this field

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalState,
    required this.education,
    required this.address,
    required this.socialState,
    required this.numberOfChildren,
    required this.phoneNumber,
    required this.hasJob,
    required this.role,
    this.avatarUrl,
    required this.achievements, // Initialize this field
  });

  Map<String, dynamic> toJson() {
    final map = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'marital_state': maritalState,
      'education': education,
      'address': address,
      'social_state': socialState,
      'number_of_children': numberOfChildren,
      'phone_number': phoneNumber,
      'has_job': hasJob,
      'role': role,
      'avatar_url': avatarUrl,
      'achievements': achievements, // Include this field
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      gender: json['gender'],
      maritalState: json['marital_state'],
      education: json['education'],
      address: json['address'],
      socialState: json['social_state'],
      numberOfChildren: json['number_of_children'],
      phoneNumber: json['phone_number'],
      hasJob: json['has_job'],
      role: json['role'],
      avatarUrl: json['avatar_url'],
      achievements: List<String>.from(json['achievements'] ?? []), // Parse this field
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      password: user.password,
      firstName: user.firstName,
      lastName: user.lastName,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      maritalState: user.maritalState,
      education: user.education,
      address: user.address,
      socialState: user.socialState,
      numberOfChildren: user.numberOfChildren,
      phoneNumber: user.phoneNumber,
      hasJob: user.hasAJob,
      role: user.role,
      avatarUrl: user.avatarUrl,
      achievements: user.achievements, // Map this field
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      maritalState: maritalState,
      education: education,
      address: address,
      socialState: socialState,
      numberOfChildren: numberOfChildren,
      phoneNumber: phoneNumber,
      hasAJob: hasJob,
      role: role,
      avatarUrl: avatarUrl,
      achievements: achievements, // Map this field
    );
  }
}
