import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/common/widgets/single_product.dart';
import 'package:frontend/features/admin/screens/add_product_screen.dart';
import 'package:frontend/features/admin/services/admin_service.dart';
import 'package:frontend/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _adminService = AdminService();

  List<Product>? _products;

  void _navigateToAddProduct() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  void _deleteProduct(Product product, int index) {
    _adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        _products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAllProducts();
  }

  void _fetchAllProducts() async {
    _products = await _adminService.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: _products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final productData = _products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _deleteProduct(productData, index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddProduct,
              tooltip: 'Add a Product',
              backgroundColor: const Color.fromARGB(255, 29, 201, 192),
              foregroundColor: Colors.black,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
