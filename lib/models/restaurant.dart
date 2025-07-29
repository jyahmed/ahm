class Restaurant {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final List<String> categories;
  final bool isNew;
  final bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.categories,
    this.isNew = false,
    this.isFavorite = false,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      categories: List<String>.from(json['categories']),
      isNew: json['isNew'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'categories': categories,
      'isNew': isNew,
      'isFavorite': isFavorite,
    };
  }
}

