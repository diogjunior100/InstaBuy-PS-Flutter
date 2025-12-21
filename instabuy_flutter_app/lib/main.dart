import 'package:flutter/material.dart';
import 'package:instabuy_flutter_app/data/models/banner_model.dart';
import 'package:instabuy_flutter_app/data/services/banner_service.dart';
import 'package:instabuy_flutter_app/ui/widgets/banner_carousel_slider.dart';
import 'data/services/product_service.dart';
import 'ui/widgets/product_card.dart';
import './data/models/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Produtos da API',
      home: const ProductsPage(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel> products = [];
  List<BannerModel> banners = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final productData = await ProductService.fetchCollectionItems();
    final bannerData = await BannerService.fetchMobileBanners();

    setState(() {
      products = productData;
      banners = bannerData;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produtos da API")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
              if (banners.isNotEmpty)
                BannerCarouselSlider(
                  imageUrls: banners
                      .map((b) => b.imageUrl ?? '')
                      .where((s) => s.isNotEmpty)
                      .toList(),
                ),
              ...products.map((p) => ProductCard(
                  productModel: p,
              )),
            ],
          ),
    );
  }
}
