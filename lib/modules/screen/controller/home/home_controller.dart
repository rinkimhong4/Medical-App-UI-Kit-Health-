import 'package:get/get.dart';
import 'package:medical_app/core/data/data.dart';
import 'package:medical_app/modules/screen/models/models.dart';
import 'package:medical_app/modules/screen/models/top_banner_models.dart';

class HomeController extends GetxController {
  List<SpecialtiesModel> homeModelList = [];
  var loading = true.obs;
  var loadingBanners = true.obs;
  var loadingCategories = true.obs;

  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];
  var doctorsBySpecialty = DoctorsBySpecialtyModels().obs;

  @override
  void onInit() {
    super.onInit();
    loadBanners();
    loadCategories();
    loadDoctors();
  }

  /// Load doctors from Datas
  Future<void> loadDoctors() async {
    final jsonData = Datas.doctorsBySpecialty;
    doctorsBySpecialty.value = DoctorsBySpecialtyModels.fromJson(jsonData);
  }

  Future<void> loadBanners() async {
    loadingBanners.value = true;
    await Future.delayed(const Duration(seconds: 1));
    banners = Datas.bannerData.map((e) => BannerModel.fromJson(e)).toList();
    loadingBanners.value = false;
  }

  Future<void> loadCategories() async {
    loadingCategories.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    categories = Datas.categoriesData
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    loadingCategories.value = false;
  }

  Future<void> loadingData() async {
    loading.value = true;

    await Future.delayed(Duration(seconds: 1));

    // Parse list from Datas.data['specialties']
    final list = Datas.data['specialties'] as List;
    homeModelList = list.map((e) => SpecialtiesModel.fromJson(e)).toList();

    loading.value = false;
  }
}
