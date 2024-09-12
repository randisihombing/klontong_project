import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'add_product.dart';
import 'detail_product.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ScrollController _scrollController = ScrollController();

  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial products
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productProvider = Provider.of<ProductProvider>(context, listen: false);

      context.read<ProductProvider>().loadProducts();
    });
  }


  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && (productProvider.products.length < productProvider.totalRecord)) {
    // if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Load more products when reaching the bottom (every 20 items)
      context.read<ProductProvider>().loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProduct()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                productProvider.searchProducts(query);
              },
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return ListTile(
                      title: Text(product.name ?? ""),
                      subtitle: Text('\$${product.price.toString()}'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailProduct(product: product,)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
