import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseImageUrl =
      "https://ibassets.com.br/ib.item.image.medium/m-";

  static Future<List<Map<String, dynamic>>> fetchCollectionItems() async {
    final url = Uri.parse("https://api.instabuy.com.br/apiv3/layout?subdomain=bigboxdelivery");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data["data"]["collection_items"];

        List<Map<String, dynamic>> tempList = [];
        
        for (var collection in items) {
          if (collection == null || collection["items"] == null) continue;

          for (var item in collection["items"]) {
            tempList.add({
              "name": item["name"],
              "price": item["prices"][0]["price"],
              "image": item["images"].isNotEmpty
                  ? "$baseImageUrl${item['images'][0]}"
                  : null,
            });
          }
        }

        return tempList;
      } else {
          print("Erro: ${response.statusCode}");
          return [];
      }
    } catch (e) {
      print("Erro ao buscar dados: $e");
      return [];
    }
  }
}
