enum AppointmentStatus { upcoming, completed, cancelled }

enum PaymentMethod { card, paypal, googlePay, applePay, cash }

class User {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final DateTime dateOfBirth;
  final String gender;
  final String? avatarUrl;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['full_name'],
    email: json['email'],
    password: json['password'],
    phone: json['phone'],
    dateOfBirth: DateTime.parse(json['date_of_birth']),
    gender: json['gender'],
    avatarUrl: json['avatar_url'],
  );
}

class Doctor {
  final String id;
  final String name;
  final String degree;
  final String specialization;
  final String focus;
  final double rating;
  final int reviews;
  final int experienceYears;
  final String profileImage;
  final List<Schedule> schedules;

  Doctor({
    required this.id,
    required this.name,
    required this.degree,
    required this.specialization,
    required this.focus,
    required this.rating,
    required this.reviews,
    required this.experienceYears,
    required this.profileImage,
    required this.schedules,
  });

  factory Doctor.fromJson(
    Map<String, dynamic> json,
    List<Schedule> schedules,
  ) => Doctor(
    id: json['id'],
    name: json['name'],
    degree: json['degree'],
    specialization: json['specialization'],
    focus: json['focus'],
    rating: (json['rating'] as num).toDouble(),
    reviews: json['reviews'],
    experienceYears: json['experience_years'],
    profileImage: json['profile_image'],
    schedules: schedules,
  );
}

class Schedule {
  final String id;
  final String doctorId;
  final DateTime date;
  final List<TimeSlot> availableSlots;

  Schedule({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.availableSlots,
  });

  factory Schedule.fromJson(
    Map<String, dynamic> json,
    List<TimeSlot> availableSlots,
  ) => Schedule(
    id: json['id'],
    doctorId: json['doctor_id'],
    date: DateTime.parse(json['date']),
    availableSlots: availableSlots,
  );
}

class TimeSlot {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    id: json['id'],
    startTime: DateTime.parse(json['start_time']),
    endTime: DateTime.parse(json['end_time']),
    isBooked: json['is_booked'],
  );
}

class Appointment {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime dateTime;
  final String problemDescription;
  final AppointmentStatus status;
  final String? patientName;
  final int? patientAge;
  final String? patientGender;
  final String? cancellationReason;
  final Payment? payment;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.dateTime,
    required this.problemDescription,
    required this.status,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.cancellationReason,
    this.payment,
  });

  factory Appointment.fromJson(Map<String, dynamic> json, Payment? payment) =>
      Appointment(
        id: json['id'],
        doctorId: json['doctor_id'],
        patientId: json['patient_id'],
        dateTime: DateTime.parse(json['date_time']),
        problemDescription: json['problem_description'],
        status: AppointmentStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
        ),
        patientName: json['patient_name'],
        patientAge: json['patient_age'],
        patientGender: json['patient_gender'],
        cancellationReason: json['cancellation_reason'],
        payment: payment,
      );
}

class Payment {
  final String id;
  final String appointmentId;
  final double amount;
  final PaymentMethod method;
  final DateTime dateTime;
  final bool isSuccessful;

  Payment({
    required this.id,
    required this.appointmentId,
    required this.amount,
    required this.method,
    required this.dateTime,
    required this.isSuccessful,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json['id'],
    appointmentId: json['appointment_id'],
    amount: (json['amount'] as num).toDouble(),
    method: PaymentMethod.values.firstWhere(
      (e) => e.toString().split('.').last == json['method'],
    ),
    dateTime: DateTime.parse(json['date_time']),
    isSuccessful: json['is_successful'],
  );
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime dateTime;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
    this.isRead = false,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        dateTime: DateTime.parse(json['date_time']),
        isRead: json['is_read'],
      );
}

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final bool isTyping;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    this.isTyping = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'],
    senderId: json['sender_id'],
    receiverId: json['receiver_id'],
    message: json['message'],
    dateTime: DateTime.parse(json['date_time']),
    isTyping: json['is_typing'],
  );
}

class ProfileSettings {
  final String id;
  final String userId;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final String language;
  final String themeMode;

  ProfileSettings({
    required this.id,
    required this.userId,
    required this.notificationsEnabled,
    required this.soundEnabled,
    required this.vibrationEnabled,
    required this.language,
    required this.themeMode,
  });

  factory ProfileSettings.fromJson(Map<String, dynamic> json) =>
      ProfileSettings(
        id: json['id'],
        userId: json['user_id'],
        notificationsEnabled: json['notifications_enabled'],
        soundEnabled: json['sound_enabled'],
        vibrationEnabled: json['vibration_enabled'],
        language: json['language'],
        themeMode: json['theme_mode'],
      );
}

class Review {
  final String id;
  final String appointmentId;
  final String userId;
  final String doctorId;
  final double rating;
  final String? comment;

  Review({
    required this.id,
    required this.appointmentId,
    required this.userId,
    required this.doctorId,
    required this.rating,
    this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'],
    appointmentId: json['appointment_id'],
    userId: json['user_id'],
    doctorId: json['doctor_id'],
    rating: (json['rating'] as num).toDouble(),
    comment: json['comment'],
  );
}

class Favorite {
  final String id;
  final String userId;
  final String doctorId;

  Favorite({required this.id, required this.userId, required this.doctorId});

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json['id'],
    userId: json['user_id'],
    doctorId: json['doctor_id'],
  );
}
