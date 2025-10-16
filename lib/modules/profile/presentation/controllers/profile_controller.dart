import 'package:flutter_app/modules/profile/domain/usecases/get_profile.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routes/app_pages.dart';
import '../../domain/entities/profile.dart';

class ProfileController extends GetxController {
  late int id;
  final GetProfile getProfile;

  ProfileController({
    required this.getProfile,
  });

  final profile = Rxn<Profile>();
  final String joinDate = 'November 2023';
  var isLoading = false.obs;
  var name = ''.obs;
  var email = ''.obs;
  var isGuest = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    if (Get.arguments is int) {
      id = Get.arguments as int;
      fetchProfile();
    } else {
      Get.back();
    }
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      final res = await getProfile(id);
      profile.value = res;
      // final favorites = await dataSource.fetchFavoriteMovies();
      // lastSeenMovies.assignAll(favorites);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? 'Unknown User';
    email.value = prefs.getString('user_email') ?? '';
    isGuest.value = prefs.getBool('is_guest') ?? false;

    return {
      'name': name,
      'email': email,
      'isGuest': isGuest,
    };
  }

  void logout() {
    SharedPreferences.getInstance().then((prefs) => prefs.clear());

    profile.value = null;
    // lastSeenMovies.clear();

    Get.offAllNamed(Routes.login);
    Get.snackbar('Logout', 'Berhasil logout. Silakan masuk kembali.');
  }
}
