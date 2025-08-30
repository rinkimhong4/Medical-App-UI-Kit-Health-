// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SupabaseClientService extends GetxService {
//   final SupabaseClient _client = Supabase.instance.client;

//   static Future<void> initialize() async {
//     try {
//       await Supabase.initialize(
//         url:
//             dotenv.env['SUPABASE_URL'] ??
//             'https://kundfpqkbfnagogwrtfq.supabase.co',
//         anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'your_anon_key_here',
//       );
//       print('Supabase initialized successfully');
//     } catch (e) {
//       print('Supabase initialization failed: $e');
//       rethrow;
//     }
//   }

//   Future<User> signUp({
//     required String email,
//     required String password,
//     required String fullName,
//     required String phone,
//     required DateTime dateOfBirth,
//     required String gender,
//   }) async {
//     final response = await _client.auth.signUp(
//       email: email.trim().toLowerCase(),
//       password: password.trim(),
//       data: {
//         'full_name': fullName.trim(),
//         'phone': phone.trim(),
//         'date_of_birth': dateOfBirth.toIso8601String(),
//         'gender': gender,
//       },
//     );
//     return response.user!;
//   }

//   Future<AuthResponse> signIn(String email, String password) async {
//     return await _client.auth.signInWithPassword(
//       email: email.trim().toLowerCase(),
//       password: password.trim(),
//     );
//   }

//   Future<void> resendConfirmationEmail(String email) async {
//     await _client.auth.resend(type: OtpType.signup, email: email);
//   }

//   Future<void> signOut() async {
//     await _client.auth.signOut();
//   }
// }
