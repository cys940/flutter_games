class ProfileEntity {
  const ProfileEntity({
    required this.id,
    required this.username,
    required this.fullName,
    this.avatarUrl,
    this.website,
    this.updatedAt,
  });

  final String id;
  final String username;
  final String fullName;
  final String? avatarUrl;
  final String? website;
  final DateTime? updatedAt;
}
