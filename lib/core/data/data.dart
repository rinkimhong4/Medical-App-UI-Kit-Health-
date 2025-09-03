import 'package:flutter/material.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';

class Datas {
  static var listTitleModels = [
    {
      'title': 'Profile',
      'iconLeading': Icons.person,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
    {
      'title': 'Favorite',
      'iconLeading': Icons.favorite,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
    {
      'title': 'Payment Method',
      'iconLeading': Icons.payment,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
    {
      'title': 'Privacy Policy',
      'iconLeading': Icons.privacy_tip,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
    {
      'title': 'Settings',
      'iconLeading': Icons.settings,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
    {
      'title': 'Help',
      'iconLeading': Icons.help,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
    {
      'title': 'Logout',
      'iconLeading': Icons.logout,
      'iconAction': Icons.arrow_forward_ios_outlined,
    },
  ];
  static var doctorsBySpecialty = {
    "Cardiology": [
      {
        "name": "Dr. John Doe",
        "specialty": "Interventional Cardiologist",
        "image":
            "https://www.future-doctor.de/wp-content/uploads/2024/08/shutterstock_2480850611.jpg",
      },
    ],
    "Dermatology": [
      {
        "name": "Dr. Sarah Smith",
        "specialty": "Dermatologist",
        "image":
            "https://img.freepik.com/free-photo/portrait-young-female-doctor_23-2148827698.jpg",
      },
    ],
    "General medicine": [
      {
        "name": "Dr. Sarah Smith",
        "specialty": "Dermatologist",
        "image":
            "https://img.freepik.com/free-photo/portrait-young-female-doctor_23-2148827698.jpg",
      },
    ],
    "Gynecology": [
      {
        "name": "Dr. Sarah Smith",
        "specialty": "Dermatologist",
        "image":
            "https://img.freepik.com/free-photo/portrait-young-female-doctor_23-2148827698.jpg",
      },
    ],
    "Odontology": [
      {
        "name": "Dr. Sarah Smith",
        "specialty": "Dermatologist",
        "image":
            "https://img.freepik.com/free-photo/portrait-young-female-doctor_23-2148827698.jpg",
      },
    ],
    "Oncology": [
      {
        "name": "Dr. Michael Lee",
        "specialty": "Neurologist",
        "image":
            "https://img.freepik.com/free-photo/portrait-smiling-male-doctor_171337-1532.jpg",
      },
    ],
    "Ophtamology": [
      {
        "name": "Dr. Emily Davis",
        "specialty": "Pediatrician",
        "image":
            "https://img.freepik.com/free-photo/beautiful-female-doctor_23-2147896007.jpg",
      },
    ],
    "Orthopedics": [
      {
        "name": "Dr. James Wilson",
        "specialty": "Orthopedic Surgeon",
        "image":
            "https://img.freepik.com/free-photo/portrait-confident-male-doctor_1098-19859.jpg",
      },
    ],
  };
  // ========================
  static var data = {
    'specialties': [
      {"title": "Cardiology", "image": AppAssets.cardiology},
      {"title": "Dermatology", "image": AppAssets.dermatology},
      {"title": "General medicine", "image": AppAssets.generalmedicine},
      {"title": "Gynecology", "image": AppAssets.gynecology},
      {"title": "Odontology", "image": AppAssets.odontology},
      {"title": "Oncology", "image": AppAssets.oncology},
      {"title": "Ophtamology", "image": AppAssets.ophtamology},
      {"title": "Orthopedics", "image": AppAssets.orthopedics},
    ],
  };

  // =======================
  static const bannerData = [
    {
      "title": "Pain Relief",
      "subtitle": "Effective and fast-acting",
      "name": "Paracetamol",
      "url":
          "https://static.vecteezy.com/system/resources/thumbnails/004/449/782/small_2x/abstract-geometric-medical-cross-shape-medicine-and-science-concept-background-medicine-medical-health-cross-healthcare-decoration-for-flyers-poster-web-banner-and-card-illustration-vector.jpg",
      "thumbUrl":
          "https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg",
    },
    {
      "title": "Cold & Flu",
      "subtitle": "Treat symptoms quickly",
      "name": "FluMed",
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4kgRAwHBd0aAZCJIH-Wrlz0AzyWaqQAT2KP4EMWP_-5zEB_jClIoedBa9C7jTbjcagPE&usqp=CAU",
      "thumbUrl":
          "https://thumbs.dreamstime.com/b/portrait-physician-looking-down-notepad-portrait-physician-looking-down-notepad-overwhelmed-concerns-man-wearing-157193179.jpg",
    },
    {
      "title": "Allergy Relief",
      "subtitle": "Fast-acting anti-histamine",
      "name": "AllerFree",
      "url":
          "https://img.freepik.com/free-vector/medical-banner-background_23-2148493817.jpg",
      "thumbUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqeFcT12pXgXjcvRreL1lV33rqaDquu_WdLHdZFnKOBh9t6yDjVV8qJBmM5xpp6QWbl7U&usqp=CAU",
    },
    {
      "title": "Heart Health",
      "subtitle": "Supports cardiovascular system",
      "name": "CardioPlus",
      "url":
          "https://img.freepik.com/free-vector/heart-health-banner-background_23-2148493823.jpg",
      "thumbUrl":
          "https://img.freepik.com/free-photo/doctor-holding-heart-model_23-2148502220.jpg",
    },
    {
      "title": "Vitamins & Minerals",
      "subtitle": "Boost your immunity",
      "name": "NutriMax",
      "url":
          "https://img.freepik.com/free-vector/vitamins-supplements-banner-background_23-2148493830.jpg",
      "thumbUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6pXK5Ldi7voiIG14UMcBTCOH3_6sy6yF9IWYkmHSsFai4k11kRj8Wfe8rhG3PVg34YQE&usqp=CAU",
    },
    {
      "title": "Skin Care",
      "subtitle": "Nourish and protect your skin",
      "name": "DermaCare",
      "url":
          "https://img.freepik.com/free-vector/skin-care-medical-banner_23-2148493837.jpg",
      "thumbUrl":
          "https://img.lb.wbmdstatic.com/lhd/provider/462185_7e9a4fc3-accb-4979-b17a-272633023cb9.jpg",
    },
  ];

  static const categoriesData = [
    {"title": "Favorite", "assetPath": AppAssets.favorite},
    {"title": "Doctors", "assetPath": AppAssets.doctor},
    {"title": "Pharmacy", "assetPath": AppAssets.pharmacy},
    {"title": "Specialties", "assetPath": AppAssets.specialties},
    {"title": "Record", "assetPath": AppAssets.record},
  ];
}
