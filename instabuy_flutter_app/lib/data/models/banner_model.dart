class BannerModel {
  final bool isMobile;
  final String? imageUrl;

  const BannerModel({
    this.imageUrl,
    required this.isMobile
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      imageUrl: json['image'],
      isMobile: json['is_mobile'],
    );
  } 
}