class UserModel {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String city;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.city,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return 'م';
    if (parts.length == 1) return parts.first.substring(0, 1);
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}';
  }
}
