import 'package:flutter/material.dart';
import 'package:flutter_app/core/widgets/primary_button.dart';
import 'package:flutter_app/modules/profile/presentation/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = controller.profile.value;

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: profile?.avatarPath != null
                                  ? NetworkImage(profile!.avatarPath!)
                                      as ImageProvider
                                  : null,
                              child: profile?.avatarPath == null
                                  ? const Icon(Icons.person,
                                      size: 40, color: Colors.grey)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile?.username ?? controller.name.value,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    profile?.name.isNotEmpty == true
                                        ? profile!.name
                                        : controller.email.value,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                  ),
                                  controller.isGuest.value
                                      ? Container()
                                      : Text(
                                          'Bergabung sejak ${controller.joinDate}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600),
                                        ),
                                ],
                              ),
                            ),
                            controller.isGuest.value
                                ? SizedBox.shrink()
                                : IconButton(
                                    onPressed: () {
                                      _showLogoutBottomSheet(
                                          context, controller);
                                    },
                                    icon: Icon(Icons.more_horiz_rounded),
                                  )
                          ],
                        ),
                        if (controller.isGuest.value == true) ...[
                          SizedBox(height: 20),
                          PrimaryButton(
                              label: 'Login',
                              onPressed: () {
                                Get.toNamed(
                                  Routes.login,
                                );
                              })
                        ]
                      ],
                    ),
                  ),
                ]),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        }),
      ),
    );
  }

  void _showLogoutBottomSheet(
      BuildContext context, ProfileController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text(
                'Pengaturan Akun',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                dense: false,
                leading: const Icon(Icons.logout_rounded),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                subtitle: const Text(
                  'Pastikan untuk log out agar informasi akunmu tetap terlindungi',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                onTap: () async {
                  Get.back();
                  await Future.delayed(const Duration(milliseconds: 200));
                  controller.logout();
                },
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
