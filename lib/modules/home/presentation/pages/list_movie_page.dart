import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../../core/widgets/type_chip.dart';
import '../controllers/home_controller.dart';

class ListMoviePage extends StatelessWidget {
  const ListMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.appBarTitle.value, style: TextStyle(fontSize: 16),)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }


          return RefreshIndicator(
            onRefresh: controller.refreshMovies,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildSegmentedControl(controller),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: controller.allListMovies.length,
                    itemBuilder: (context, index) {
                      final movie = controller.allListMovies[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.detailMovie,
                            arguments: movie.id,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF3F55C6).withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      height: 185,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: 185,
                                          width: double.infinity,
                                          color: Colors.grey[300],
                                          child: const Center(
                                              child:
                                              CircularProgressIndicator()),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        height: 185,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                        child: const Center(child: Icon(Icons.broken_image)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFACC15),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color:
                                            Color(0xFF713F12),
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${(movie.voteAverage.toStringAsFixed(1))}%',
                                            style: const TextStyle(
                                              color: Color(0xFF713F12),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.originalTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie.overview,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildSegmentedControl(HomeController controller) {
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
