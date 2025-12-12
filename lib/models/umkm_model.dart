class UMKM {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final String location;
  final String owner;
  final String phone;
  final double rating;

  UMKM({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.owner,
    required this.phone,
    required this.rating,
  });

  factory UMKM.fromJson(Map<String, dynamic> json) {
    return UMKM(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? '',
      owner: json['owner'] ?? '',
      phone: json['phone'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}
