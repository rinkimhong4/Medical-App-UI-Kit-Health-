import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/modules/screen/view/profile_odel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final _supabase = Supabase.instance.client;

  final RxString id = ''.obs;
  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxString age = ''.obs;
  final RxString gender = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString address = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final RxString createdAt = ''.obs;
  final RxString updatedAt = ''.obs;
  final RxBool isLoading = true.obs;

  final ImagePicker _picker = ImagePicker();
  static final _cacheManager = DefaultCacheManager();

  ProfileModel profileModel = ProfileModel();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> refreshProfile() async {
    try {
      isLoading.value = true;
      await loadProfile();
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadProfileImage(String userId) async {
    if (userId.isEmpty) return;

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    final fileBytes = await pickedFile.readAsBytes();
    final fileName = 'avatars/$userId.png';

    try {
      isLoading.value = true;

      final profileResponse = await _supabase
          .from('profiles')
          .select('profile_image')
          .eq('id', userId)
          .maybeSingle();

      final oldAvatarPath = profileResponse?['profile_image'] as String?;
      await Future.delayed(Duration(seconds: 2));

      await _supabase.storage
          .from('avatars')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      if (await _doesFileExist(fileName)) {
        if (oldAvatarPath != null &&
            oldAvatarPath.isNotEmpty &&
            oldAvatarPath != fileName) {
          await _supabase.storage.from('avatars').remove([oldAvatarPath]);
        }

        await _supabase
            .from('profiles')
            .update({
              'profile_image': fileName,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId);

        updatedAt.value = DateTime.now().toIso8601String();

        final signedUrl = await _generateSignedUrl(fileName);
        if (signedUrl.isNotEmpty) {
          final uri = Uri.parse(signedUrl);
          final uniqueUrl = uri
              .replace(
                queryParameters: {
                  ...uri.queryParameters,
                  'v': DateTime.now().millisecondsSinceEpoch.toString(),
                },
              )
              .toString();

          await _cacheManager.removeFile(profileImageUrl.value);
          profileImageUrl.value = uniqueUrl;
          await _preloadImage(uniqueUrl);
          await _saveSignedUrl(userId, uniqueUrl);
        } else {
          profileImageUrl.value = '';
        }
      } else {
        profileImageUrl.value = '';
      }
    } catch (e) {
      profileImageUrl.value = '';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadProfile() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      id.value = userId;

      final cachedUrl = await _getCachedSignedUrl(userId);
      if (cachedUrl.isNotEmpty && await _doesFileExist('avatars/$userId.png')) {
        profileImageUrl.value = cachedUrl;
        await _preloadImage(cachedUrl);
      }

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      profileModel = ProfileModel.fromJson(response);

      // Set all reactive fields, including timestamps and id
      id.value = profileModel.id ?? '';
      username.value = profileModel.username ?? '';
      email.value = profileModel.email ?? '';
      age.value = profileModel.age?.toString() ?? '';
      gender.value = profileModel.gender ?? '';
      phoneNumber.value = profileModel.phoneNumber ?? '';
      address.value = profileModel.address ?? '';
      createdAt.value = profileModel.createdAt?.toIso8601String() ?? '';
      updatedAt.value = profileModel.updatedAt?.toIso8601String() ?? '';
      //
      final filePath = response['profile_image'] ?? '';
      if (filePath.isNotEmpty && await _doesFileExist(filePath)) {
        final signedUrl = await _generateSignedUrl(filePath);
        final uri = Uri.parse(signedUrl);
        final versionedUrl = uri
            .replace(
              queryParameters: {
                ...uri.queryParameters,
                'v': DateTime.now().millisecondsSinceEpoch.toString(),
              },
            )
            .toString();
        profileImageUrl.value = versionedUrl;
        await _preloadImage(versionedUrl);
        await _saveSignedUrl(userId, versionedUrl);
      }
    } catch (e) {
      //
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      final userId = _supabase.auth.currentUser?.id;
      final email = _supabase.auth.currentUser?.email;

      if (userId == null || email == null) {
        throw Exception('User not authenticated');
      }

      // First verify current password
      final authResponse = await _supabase.auth.signInWithPassword(
        email: email,
        password: currentPassword,
      );

      if (authResponse.user == null) {
        throw Exception('Current password is incorrect');
      }

      // Then update to new password
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));

      // Update the updated_at timestamp in profiles table
      await _supabase
          .from('profiles')
          .update({'updated_at': DateTime.now().toIso8601String()})
          .eq('id', userId);

      updatedAt.value = DateTime.now().toIso8601String();
      return true;
    } catch (e) {
      throw Exception('Failed to change password: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    String? newUsername,
    String? newEmail,
    String? newGender,
    String? newPhoneNumber,
    String? newAddress,
    String? newAge,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      isLoading.value = true;
      final updates = {
        'id': userId,
        'updated_at': DateTime.now().toIso8601String(),
        if (newUsername != null && newUsername.isNotEmpty)
          'username': newUsername,
        if (newEmail != null && newEmail.isNotEmpty) 'email': newEmail,
        if (newGender != null && newGender.isNotEmpty) 'gender': newGender,
        if (newPhoneNumber != null && newPhoneNumber.isNotEmpty)
          'phoneNumber': newPhoneNumber,
        if (newAddress != null && newAddress.isNotEmpty) 'address': newAddress,
        if (newAge != null && newAge.isNotEmpty)
          'age': int.tryParse(newAge) ?? 0,
      };

      if (updates.length > 2) {
        // More than just id and updated_at
        await _supabase.from('profiles').upsert(updates);
      }

      // Update local state only if the value was provided and not empty
      if (newUsername != null && newUsername.isNotEmpty) {
        username.value = newUsername;
      }
      if (newEmail != null && newEmail.isNotEmpty) email.value = newEmail;
      if (newGender != null && newGender.isNotEmpty) gender.value = newGender;
      if (newPhoneNumber != null && newPhoneNumber.isNotEmpty) {
        phoneNumber.value = newPhoneNumber;
      }
      if (newAddress != null && newAddress.isNotEmpty) {
        address.value = newAddress;
      }
      if (newAge != null && newAge.isNotEmpty) {
        age.value = newAge;
      }

      updatedAt.value = DateTime.now().toIso8601String();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }

    username.value = newUsername ?? username.value;
    email.value = newEmail ?? email.value;
    gender.value = newGender ?? gender.value;
    phoneNumber.value = newPhoneNumber ?? phoneNumber.value;
    address.value = newAddress ?? address.value;
    age.value = newAge ?? age.value;
  }
  // ----------------- Helpers -----------------

  Future<bool> _doesFileExist(String filePath) async {
    try {
      final fileList = await _supabase.storage
          .from('avatars')
          .list(path: filePath.substring(0, filePath.lastIndexOf('/')));
      return fileList.any((file) => file.name == filePath.split('/').last);
    } catch (_) {
      return false;
    }
  }

  Future<String> _generateSignedUrl(String filePath) async {
    try {
      return await _supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 86400);
    } catch (_) {
      return '';
    }
  }

  Future<void> _preloadImage(String url) async {
    try {
      await _cacheManager.getSingleFile(url);
    } catch (_) {}
  }

  Future<void> _saveSignedUrl(String userId, String url) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('profile_image_url_$userId', url);
    await pref.setInt(
      'profile_image_expiry_$userId',
      DateTime.now().add(const Duration(hours: 24)).millisecondsSinceEpoch,
    );
  }

  Future<String> _getCachedSignedUrl(String userId) async {
    final pref = await SharedPreferences.getInstance();
    final url = pref.getString('profile_image_url_$userId') ?? '';
    final expiry = pref.getInt('profile_image_expiry_$userId') ?? 0;
    if (url.isNotEmpty && expiry > DateTime.now().millisecondsSinceEpoch) {
      return url;
    }
    return '';
  }

  Future<bool> verifyCurrentPassword(String password) async {
    try {
      final email = _supabase.auth.currentUser?.email;
      if (email == null) return false;

      final result = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return result.user != null;
    } catch (e) {
      return false;
    }
  }

  void resetProfile() {
    id.value = '';
    username.value = '';
    email.value = '';
    age.value = '';
    gender.value = '';
    phoneNumber.value = '';
    address.value = '';
    profileImageUrl.value = '';
    createdAt.value = '';
    updatedAt.value = '';
    isLoading.value = false;
    ProfileController._cacheManager.emptyCache();
  }
}
