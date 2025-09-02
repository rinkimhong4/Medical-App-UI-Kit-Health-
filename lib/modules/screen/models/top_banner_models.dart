class BannerModel {
  final String title;
  final String subtitle;
  final String name;
  final String url;
  final String thumbUrl;

  BannerModel({
    required this.title,
    required this.subtitle,
    required this.name,
    required this.url,
    required this.thumbUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    title: json["title"],
    subtitle: json["subtitle"],
    name: json["name"],
    url: json["url"],
    thumbUrl: json["thumbUrl"],
  );
}

class CategoryModel {
  final String title;
  final String assetPath;

  CategoryModel({required this.title, required this.assetPath});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(title: json["title"], assetPath: json["assetPath"]);
}
