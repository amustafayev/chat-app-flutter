class UserDetailsDto {
  final String userId;
  String? profilePicUrl;
  final String? name;
  final String? bio;
  final String email;

  UserDetailsDto({
    required this.userId,
    this.profilePicUrl,
    this.name,
    required this.email,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profilePicUrl': profilePicUrl,
      'name': name,
      'bio': bio,
      'email': email,
    };
  }
}
