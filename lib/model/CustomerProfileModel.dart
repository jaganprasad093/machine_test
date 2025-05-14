class CustomerProfile {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int age;
  final bool isOnline;

  CustomerProfile({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.age,
    required this.isOnline,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['profile_photo_url'],
      age: json['age'] ?? 0,
      isOnline: json['is_online'] ?? false,
    );
  }
}
