import 'package:flutter/material.dart';
import 'package:flutter_app/core/widgets/type_chip.dart';
import 'package:flutter_app/modules/watchlist/presentation/controllers/watchlist_controller.dart';
import 'package:get/get.dart';

import '../widgets/watchlist_item.dart';

class WatchlistPage extends GetView<WatchlistController> {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Watchlist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _buildSegmentedControl(controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // if (controller.errorMessage.isNotEmpty) {
              //   return Center(
              //     child: Text(
              //       'Tidak ada data',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(color: Colors.red.shade700),
              //     ),
              //   );
              // }

              if (controller.watchlistItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/empty_watchlist.png'),
                      const SizedBox(height: 16),
                      Text(
                        'Watchlistmu masih kosong.\nYuk, tambahkan yang ingin kamu tonton!.',
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: controller.watchlistItems.length,
                itemBuilder: (context, index) {
                  final item = controller.watchlistItems[index];
                  return WatchlistItemCard(movie: item);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(WatchlistController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: TypeEnum.values.map((type) {
          return Obx(() => Expanded(
                child: TypeChip(
                  type: type,
                  isSelected: controller.selectedType.value == type,
                  onTap: () => controller.selectType(type),
                ),
              ));
        }).toList(),
      ),
    );
  }
}
