import 'package:flutter/material.dart';
import 'package:flutter_app/modules/home/domain/entities/genre.dart';
import 'package:flutter_app/modules/home/domain/entities/movie.dart';
import 'package:flutter_app/modules/home/presentation/widgets/section_header.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../watchlist/presentation/pages/watchlist_page.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomeBodyContent(),
    const WatchlistPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all( 16),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavBarItem(
                index: 0,
                activeIcon: Icons.home_rounded,
                inactiveIcon: Icons.home_outlined,
                label: 'Beranda',
              ),
              _buildNavBarItem(
                index: 1,
                activeIcon: Icons.bookmark_rounded,
                inactiveIcon: Icons.bookmark_border,
                label: 'Watchlist',
              ),
              _buildNavBarItem(
                index: 2,
                activeIcon: Icons.person,
                inactiveIcon: Icons.person_outline,
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem({
    required int index,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
  }) {
    final bool isSelected = index == _selectedIndex;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(50),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 12 : 12,
                vertical: isSelected ? 8 : 10
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? activeIcon : inactiveIcon,
                  color: isSelected ? Colors.white : Colors.black26,
                  size: 24,
                ),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeBodyContent extends StatelessWidget {
  const _HomeBodyContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: Row(
          children: [
            Image.asset('assets/logo_tmdb.png', height: 28),
            const SizedBox(width: 8),
            const Text('TMDB', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black87),
          SizedBox(width: 16),
          Icon(Icons.search, color: Colors.black87),
          SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final trending = controller.trendingMovies;
        final nowPlaying = controller.nowPlayingMovies;
        final topRated = controller.topRatedMovies;
        final genre = controller.genres;

        return RefreshIndicator(
          onRefresh: controller.refreshMovies,
          child: SingleChildScrollView(
            child: SafeArea(
              top: true,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTrendingSection(trending, controller),
                    const SizedBox(height: 16),
                    _buildNewReleasesSection(nowPlaying, controller),
                    const SizedBox(height: 16),
                    _buildTopRatedSection(topRated, controller),
                    const SizedBox(height: 16),
                    _buildGenreSection(genre),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }


  Widget _buildTrendingSection(List<Movie> trending, HomeController controller) {
    return Column(
      children: [
        SectionHeader(
          title: 'Trending',
          subtitle: 'Hari ini',
          onTapViewAll: () {
            controller.setListTitle('Trending Hari Ini');
            Get.toNamed(
              Routes.listMovie,
            );
          },
        ),
        SizedBox(
          height: 273,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final item = trending[index];
              bool last = index == trending.length - 1;
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.detailMovie,
                    arguments: item.id,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: const Color(0xFF3F55C6).withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 280,
                  margin: EdgeInsets.only(
                    left: 16,
                    right: last ? 16 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${item.posterPath}',
                              height: 185,
                              width: 330,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 280,
                                  color: Colors.grey[300],
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                );
                              },
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
                                    color: Color(0xFF713F12),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${item.voteAverage.toStringAsFixed(1)}%',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          item.originalTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          item.overview,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildNewReleasesSection(List<Movie> nowPlaying, HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Baru Rilis',
          subtitle: DateFormat('MMMM', 'id_ID').format(DateTime.now()),
          onTapViewAll: () {
            controller.setListTitle('Baru Rilis');
            Get.toNamed(
              Routes.listMovie,
            );
          },
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final item = nowPlaying[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.detailMovie,
                    arguments: item.id,
                  );
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                    right: index == nowPlaying.length - 1 ? 16 : 0,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${item.posterPath}',
                          height: 250,
                          width: 150,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 220,
                              width: 150,
                              color: Colors.grey[300],
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFFFACC15),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(

                            '${item.voteAverage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              color: Color(0xFF713F12),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopRatedSection(List<Movie> topRated, HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Rating Tertinggi',
          onTapViewAll: () {

            controller.setListTitle('Rating Tertinggi');
            Get.toNamed(
              Routes.listMovie,
            );
          },
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              final item = topRated[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.detailMovie,
                    arguments: item.id,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(0xFF3F55C6).withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(16)),
                  width: 320,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                    right: index == topRated.length - 1 ? 16 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${item.posterPath}',
                          height: 180,
                          width: 320,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 180,
                              width: 320,
                              color: Colors.grey[300],
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.originalTitle,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  item.releaseDate,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${item.voteAverage.toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenreSection(List<Genre> genre) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Jelajahi Film & Serial TV",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: genre.map((genre) {
              return InkWell(
                onTap: () {},
                child: Chip(
                  label: Text(genre.name),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
