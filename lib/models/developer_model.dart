class Developer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String specialty;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviews;

  Developer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.specialty,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      specialty: json['specialty'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
    );
  }
}
