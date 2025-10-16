import 'package:flutter/material.dart';
import 'package:flutter_app/modules/detail_movie/presentation/controllers/detail_movie_controller.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/review.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({super.key});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailMovieController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detailMovie = controller.detailMovie;
        final review = controller.review;

        return RefreshIndicator(
          onRefresh: controller.refreshDetailMovie,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final isCollapsed = constraints.biggest.height <
                        (kToolbarHeight +
                            MediaQuery.of(context).padding.top +
                            8.0);

                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isCollapsed ? 1.0 : 0.0,
                      child: Text(
                        detailMovie?.originalTitle ?? '',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.titleLarge?.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                centerTitle: false,
                // iconTheme: const IconThemeData(color: Colors.white),
                foregroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  // The title property is now managed by the LayoutBuilder above.
                  title:
                      null, // Set to null as the title is handled in the SliverAppBar's main title property (using LayoutBuilder)
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      detailMovie?.backdropPath != null
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500${detailMovie!.backdropPath}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image)),
                            )
                          : Container(color: Colors.grey[800]),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detailMovie!.originalTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              detailMovie.genres.map((g) => g.name).join(', '),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  controller.formatReleaseDate(
                                      detailMovie.releaseDate),
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 14),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.watch_later_outlined,
                                    color: Colors.white54, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  controller.formatRuntime(detailMovie.runtime),
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    label: const Text('Lihat Trailer'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryBlue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  label: const Text('Watchlist',
                                      style: TextStyle(color: Colors.white)),
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        const BorderSide(color: Colors.white54),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.black, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${(detailMovie.voteAverage.toStringAsFixed(1))}%',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gambaran Umum',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            detailMovie.overview.isNotEmpty
                                ? detailMovie.overview
                                : 'No overview available.',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDetailInfo('Status', detailMovie.status),
                              _buildDetailInfo('Bahasa',
                                  detailMovie.originalLanguage.toUpperCase()),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDetailInfo(
                                  'Anggaran',
                                  controller
                                      .formatCurrency(detailMovie.budget)),
                              _buildDetailInfo(
                                  'Pemasukan',
                                  controller
                                      .formatCurrency(detailMovie.revenue)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          review.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ulasan',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height:8),
                                    Column(
                                      children: review
                                          .take(3)
                                          .map(
                                            (review) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0),
                                              child: _buildReviewCard(review),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    final controller = Get.find<DetailMovieController>();

    String avatarUrl = '';
    if (review.avatarPath != null) {
      if (review.avatarPath!.startsWith('/')) {
        avatarUrl = 'https://image.tmdb.org/t/p/w500${review.avatarPath!}';
        if (review.avatarPath!.startsWith('/http')) {
          avatarUrl = review.avatarPath!.substring(1);
        }
      } else {
        avatarUrl = review.avatarPath!;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                backgroundImage: avatarUrl.isNotEmpty &&
                        Uri.tryParse(avatarUrl)?.hasAbsolutePath == true
                    ? NetworkImage(avatarUrl) as ImageProvider
                    : null,
                child: avatarUrl.isEmpty ||
                        Uri.tryParse(avatarUrl)?.hasAbsolutePath == false
                    ? const Icon(Icons.person, color: Colors.grey, size: 25)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      controller
                          .formatReleaseDate(review.createdAt.split('T').first),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (review.rating != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        review.rating!.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.content,
            style: const TextStyle(fontSize: 14),
            // maxLines: 4,
            // overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
