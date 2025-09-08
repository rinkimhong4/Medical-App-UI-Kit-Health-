import 'package:get/get.dart';
import 'package:medical_app/core/data/data.dart';
import 'package:medical_app/modules/screen/models/models.dart';
import 'package:medical_app/modules/screen/models/top_banner_models.dart';

class HomeController extends GetxController {
  List<SpecialtiesModel> homeModelList = [];
  var loading = true.obs;
  var loadingBanners = true.obs;
  var loadingCategories = true.obs;
  var listTitleModel = true.obs;

  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];
  var listTitleModels = <ListTitleModel>[].obs;
  var doctorsBySpecialty = DoctorsBySpecialtyModels().obs;
  var doctorsByCategory = DoctorsByCategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    loadBanners();
    loadCategories();
    loadDoctors();
    loadDoctorsByCategory();
  }

  /// Load doctors from Datas
  Future<void> loadDoctors() async {
    final jsonData = Datas.doctorsBySpecialty;
    doctorsBySpecialty.value = DoctorsBySpecialtyModels.fromJson(jsonData);
  }

  /// Load doctors from Datas
  Future<void> loadDoctorsByCategory() async {
    final jsonData = Datas.doctorsByCategory;
    doctorsByCategory.value = DoctorsByCategoryModel.fromJson(jsonData);
  }

  /// Convert model → Map for easy UI access
  Map<String, List<Doctor>> get doctorsMap => {
    if (doctorsByCategory.value.favorite != null)
      "Favorite": doctorsByCategory.value.favorite!,
    if (doctorsByCategory.value.doctors != null)
      "Doctors": doctorsByCategory.value.doctors!,
    if (doctorsByCategory.value.pharmacy != null)
      "Pharmacy": doctorsByCategory.value.pharmacy!,
    if (doctorsByCategory.value.specialties != null)
      "Specialties": doctorsByCategory.value.specialties!,
    if (doctorsByCategory.value.record != null)
      "Record": doctorsByCategory.value.record!,
  };

  /// Get all doctors from all categories as a single list
  List<Doctor> get allDoctors {
    final all = <Doctor>[];
    all.addAll(doctorsByCategory.value.favorite ?? []);
    all.addAll(doctorsByCategory.value.doctors ?? []);
    all.addAll(doctorsByCategory.value.pharmacy ?? []);
    all.addAll(doctorsByCategory.value.specialties ?? []);
    all.addAll(doctorsByCategory.value.record ?? []);
    return all;
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
