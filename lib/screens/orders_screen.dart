import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/order_card.dart';
import '../models/order.dart';
import '../data/dummy_data.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final data = await ApiService.getMyOrders();
    setState(() {
      _orders = data.map((json) {
        final shopId = json['shopId'];
        final shop = DummyData.stores.firstWhere(
          (s) => s.id == shopId.toString(),
          orElse: () => DummyData.stores.first,
        );
        return Order(
          id: json['id'].toString(),
          storeName: shop.name,
          serviceType: json['serviceType'],
          date: _formatDate(json['createDate']),
          status: json['orderStatusText'],
          price: (json['amount'] as num).toDouble(),
          storeImage: shop.image,
          services: [json['serviceType']],
        );
      }).toList();
      _isLoading = false;
    });
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng của tôi'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? const Center(child: Text('Chưa có đơn hàng nào'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: OrderCard(order: _orders[index]),
                    );
                  },
                ),
    );
  }
}
