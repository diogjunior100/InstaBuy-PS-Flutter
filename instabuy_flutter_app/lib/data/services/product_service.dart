import '../repositories/api_repository.dart';
import '../models/product_model.dart';

class ProductService {
  static const String baseImageUrl = "https://ibassets.com.br/ib.item.image.medium/m-";

  static List<dynamic> extractCollectionItems(Map<String, dynamic>? data) {
    if (data == null) return [];
    final inner = data['data'];
    if (inner == null) return [];
    final items = inner['collection_items'];
    if (items is List) return items;
    return [];
  }

  static Future<List<ProductModel>> fetchCollectionItems() async {
    try {
      final data = await ApiRepository.fetchLayout(subdomain: 'bigboxdelivery');
      final items = extractCollectionItems(data);

      List<ProductModel> products = [];

      for (var collection in items) {
        if (collection == null || collection['items'] == null) continue;

        for (var item in collection['items']) {
          products.add(ProductModel(
            name: item['name'],
            price: (item['prices'][0]['price'] as num).toDouble(),
            imageUrl: item['images'] != null &&
                    (item['images'] as List).isNotEmpty
                ? "$baseImageUrl${item['images'][0]}"
                : null,
          ));
        }
      }

      return products;
    } catch (e) {
      print("Erro ao buscar dados: $e");
      return [];
    }
  }
}
