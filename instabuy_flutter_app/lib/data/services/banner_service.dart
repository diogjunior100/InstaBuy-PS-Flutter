import 'package:flutter/material.dart';

import '../repositories/api_repository.dart';
import '../models/banner_model.dart';

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

  static Future<List<BannerModel>> fetchMobileBanners() async {
    try {
      final data = await ApiRepository.fetchLayout(subdomain: 'bigboxdelivery');
      final banners = extractBanners(data);

      List<BannerModel> bannerList = [];

      for (var banner in banners) {
        if (banner == null) continue;

        final bool isMobile = banner['is_mobile'] == true;
        if (!isMobile) continue;

        final String? imageName = banner['image'];
        final String? imageUrl =
            imageName != null ? "$baseBannerUrl$imageName" : null;

        bannerList.add(
          BannerModel(
            imageUrl: imageUrl,     
            isMobile: isMobile,
          ),
        );
      }

      return bannerList;
    } catch (e) {
      print("Erro ao buscar banners: $e");
      return [];
    }
  }
}

