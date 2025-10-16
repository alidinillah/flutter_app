import 'package:get/get.dart';
import '../../../../core/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.login);
  }
}
