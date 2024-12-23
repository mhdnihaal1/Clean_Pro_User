import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/constants/app_sizes.dart';
import 'package:clean_pro_user/controller/profile_controller.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/view/address/add%20_new_address.dart';
import 'package:clean_pro_user/view/address/add_address.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          title: const Text(
            "Account",
            style: AppTextStyles.titleTextStyle,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.backgroundWhite,
              height: MediaQuery.of(context).size.height / 5,
              child: Obx(() {
                if (profileController.profileModel.value != null) {
                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.actionBlue,
                            radius: 50,
                            child: Text(
                              profileController
                                  .profileModel.value!.data.user.name[0]
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                profileController
                                    .profileModel.value!.data.user.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.montserrat,
                                    color: AppColors.textBlack),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profileController
                                    .profileModel.value!.data.user.email,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Edit profile",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontFamily: AppFonts.montserrat),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (profileController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (profileController.error.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      'Error: ${profileController.error.value}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No profile data available'),
                  );
                }
              }),
            ),
            SizedBox(
              height: AppSizes.height16,
            ),
            Expanded(
                child: Container(
              color: AppColors.backgroundWhite,
              child: ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: [
                  // ListTile(
                  //   iconColor: AppColors.actionBlue,
                  //   leading: Icon(Icons.line_style),
                  //   title: Text("My Orders",
                  //       style: TextStyle(
                  //           fontSize: 16, fontWeight: FontWeight.w600)),
                  // ),
                  ListTile(
                    onTap: () => Get.to(AddAddress()),
                    iconColor: AppColors.actionBlue,
                    leading: const Icon(Icons.location_city),
                    title: const Text("My Addresses",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const ListTile(
                    iconColor: AppColors.actionBlue,
                    leading: Icon(Icons.note),
                    title: Text("Terms & Services",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const ListTile(
                    iconColor: AppColors.actionBlue,
                    leading: Icon(Icons.email),
                    title: Text("Coantact Us",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const ListTile(
                    iconColor: AppColors.actionBlue,
                    leading: Icon(Icons.logout),
                    title: Text("Log Out",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
