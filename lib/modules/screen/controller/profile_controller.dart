import 'package:get/get.dart';
import 'package:medical_app/core/data/data.dart';
import 'package:medical_app/modules/screen/models/models.dart';

class ProfileController extends GetxController {
  var loading = true.obs;
  var listTitleModels = <ListTitleModel>[].obs;
  @override
  void onInit() {
    loadListTitleProfile();
    super.onInit();
  }

  Future<void> loadListTitleProfile() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    // Here Datas.listTitleModels is List<Map<String, dynamic>>
    listTitleModels.value = Datas.listTitleModels
        .map((e) => ListTitleModel.fromJson(e))
        .toList();

    loading.value = false;
  }
}
