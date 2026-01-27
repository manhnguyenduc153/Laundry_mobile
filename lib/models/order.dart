class Order {
  final String id;
  final String storeName;
  final String serviceType;
  final String date;
  final String status;
  final double price;
  final String storeImage;
  final List<String> services;

  Order({
    required this.id,
    required this.storeName,
    required this.serviceType,
    required this.date,
    required this.status,
    required this.price,
    required this.storeImage,
    required this.services,
  });
}
