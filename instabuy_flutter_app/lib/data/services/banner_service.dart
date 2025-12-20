import '../repositories/api_repository.dart';

class BannerService {
  static const String baseBannerUrl = 'https://ibassets.com.br/ib.store.banner/bnr-';

  static List<dynamic> extractBanners(Map<String, dynamic>? data) {
    if (data == null) return [];
    final inner = data['data'];
    if (inner == null) return [];
    final banners = inner['banners'];
    if (banners is List) return banners;
    return [];
  }

  static Future<List<Map<String, dynamic>>> fetchMobileBanners() async {
    try {
      final data = await ApiRepository.fetchLayout(subdomain: 'bigboxdelivery');
      final banners = extractBanners(data);

      List<Map<String, dynamic>> tempList = [];

      for (var banner in banners) {
        if (banner == null) continue;
        final isMobile = banner['is_mobile'] == true;
        if (!isMobile) continue;

        final imageName = banner['image'];
        final imageUrl = imageName != null ? "$baseBannerUrl$imageName" : null;

        tempList.add({
          'image': imageUrl,
          'is_mobile': isMobile,
        });
      }

      return tempList;
    } catch (e) {
      print("Erro ao buscar banners: $e");
      return [];
    }
  }
}
