class UserModel {
  final int id;
  final String name;
  final String? email;
  final String phoneNumber;
  final String roleName;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.roleName,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'],
      phoneNumber: json['phone_number'] ?? '',
      roleName: json['role_name'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}