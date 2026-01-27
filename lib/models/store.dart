class Store {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String description;
  final String address;
  final List<String> services;

  Store({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    required this.address,
    required this.services,
  });
}
