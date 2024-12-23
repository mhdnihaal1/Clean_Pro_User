import 'package:clean_pro_user/model/profile_model.dart' as pModel;
import 'package:clean_pro_user/repository/profile_repo.dart';
// import 'package:clean_pro_user/repository/profile_repo.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  final Rx<pModel. ProfileResponse?> profileModel = Rx<pModel.ProfileResponse?>(null);
  final RxList<pModel.Address> address = <pModel.Address>[].obs;
  final Rx<String> error = ''.obs;
  final Rx<bool> isLoading = false.obs;

  getProfile() async {
    isLoading.value = true;
    try {
     pModel. ProfileResponse? profileResponse = await ProfileRepository().getProfile();
      profileModel.value = profileResponse;
     
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
