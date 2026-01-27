import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/store_card.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiệm giặt'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DummyData.stores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: StoreCard(store: DummyData.stores[index]),
          );
        },
      ),
    );
  }
}
