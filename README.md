# Medical App 🏥

A comprehensive Flutter-based healthcare application that connects patients with medical professionals and provides easy access to medical specialties, doctor profiles, and healthcare services.

## 📱 Features

### 🔐 Authentication & User Management

- **Secure Authentication**: Sign in/Sign up functionality powered by Supabase
- **User Profiles**: Complete profile management with image upload capabilities
- **Secure Storage**: User data protection with encrypted local storage

### 🏥 Medical Specialties

Browse through 8 comprehensive medical specialties:

- **Cardiology** - Heart and cardiovascular care
- **Dermatology** - Skin and dermatological treatments
- **General Medicine** - Primary healthcare services
- **Gynecology** - Women's health and reproductive care
- **Odontology** - Dental and oral health
- **Oncology** - Cancer care and treatment
- **Ophthalmology** - Eye care and vision health
- **Orthopedics** - Bone, joint, and muscle care

### 👨‍⚕️ Doctor Directory

- **Comprehensive Profiles**: Detailed doctor information including specialties, experience, and focus areas
- **Categorized Browsing**: Easy navigation through Favorites, Doctors, Pharmacy, Specialties, and Records
- **Rich Media**: High-quality doctor photos and detailed career information

### 📱 Navigation & UI

- **Bottom Navigation**: Four main sections - Home, Messages, Profile, and Booking
- **Onboarding Flow**: Smooth user introduction with splash screen
- **Responsive Design**: Optimized for different screen sizes
- **Modern UI**: Material Design with custom theming and smooth animations

### 💊 Medical Content

- **Product Banners**: Featured medical products and medications
- **Category System**: Organized content for easy discovery
- **Rich Media Support**: Images, icons, and detailed descriptions

## 🛠️ Technical Architecture

### **State Management**

- **GetX**: Reactive state management for efficient app performance
- **Controllers**: Organized business logic with dedicated controllers

### **Backend & Database**

- **Supabase**: Backend-as-a-Service for authentication and cloud storage
- **SQLite**: Local database for offline data persistence
- **Secure Storage**: Encrypted local storage for sensitive data

### **UI & Design**

- **Material Design**: Modern Flutter UI components
- **Google Fonts**: Custom typography integration
- **SVG Support**: Scalable vector graphics for crisp icons
- **Shimmer Effects**: Loading animations for better UX
- **Cached Images**: Optimized image loading and caching

## 📦 Key Dependencies

```yaml
dependencies:
  # State Management
  get: ^4.7.2

  # Backend & Storage
  supabase_flutter: ^2.10.0
  sqflite: ^2.3.0
  flutter_secure_storage: ^9.2.4
  shared_preferences: ^2.5.3
  get_storage: ^2.1.1

  # UI & Design
  google_fonts: ^6.3.0
  flutter_svg: ^2.2.0
  font_awesome_flutter: ^10.10.0
  shimmer: ^3.0.0
  cached_network_image: ^3.4.1

  # Functionality
  http: ^1.5.0
  url_launcher: ^6.3.0
  image_picker: ^1.1.2
  flutter_dotenv: ^6.0.0
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.0)
- Dart SDK
- Android Studio / VS Code
- Supabase account

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd medical_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Environment Setup**

   - Create a `.env` file in the root directory
   - Add your Supabase credentials:

   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Supabase Configuration

1. Create a new project on [Supabase](https://supabase.com)
2. Get your project URL and anon key from the API settings
3. Add the credentials to your `.env` file
4. Set up authentication providers as needed

## 📁 Project Structure

```
lib/
├── app.dart                    # Main app configuration
├── main.dart                   # App entry point
├── config/                     # App configuration
│   ├── app_asset/             # Asset management
│   ├── function/              # Utility functions
│   ├── responsive/            # Responsive design
│   ├── routes/                # App routing
│   └── theme/                 # App theming
├── core/                      # Core functionality
│   ├── data/                  # Static data and models
│   ├── db/                    # Database management
│   ├── service/               # API and local services
│   └── string/                # String constants
├── modules/                   # Feature modules
│   ├── auth/                  # Authentication screens
│   ├── items/                 # Detail screens
│   └── screen/                # Main app screens
└── widgets/                   # Reusable UI components
```

## 🎨 Screenshots

_Add screenshots of your app here to showcase the UI_

## 🔧 Development

### Running Tests

```bash
flutter test
```

### Building for Production

**Android:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:

- Create an issue in this repository
- Contact the development team

## 🚀 Future Enhancements

- [ ] Appointment booking system
- [ ] Real-time messaging with doctors
- [ ] Prescription management
- [ ] Health records integration
- [ ] Telemedicine video calls
- [ ] Push notifications
- [ ] Multi-language support
- [ ] Dark mode theme

---

**Built with ❤️ using Flutter**
