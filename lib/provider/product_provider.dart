import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../model/model.dart';
import '../service/product_service.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  String apiCode = "eb9b07a72659496487877bd6a4876bab";
  List<Product> _products = [];
  List<Product> _filteredProducts = [];  // The filtered list for search results
  int _currentPage = 1;
  int totalRecord = 0;
  bool _isLoading = false;
  int pagination = 10;

  List<Product> get products => _filteredProducts.isEmpty ? _products : _filteredProducts;
  bool get isLoading => _isLoading;

  int get _totalRecord => totalRecord;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final products = await fetchProducts(_currentPage, pagination); // Fetch 10 products per page
      _products.addAll(products);
      _currentPage++;
      totalRecord = pagination;
      pagination += pagination;
      _filteredProducts = _products;
    } catch (e) {
      // Handle error
      log(e.toString());
      return;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search products based on the query
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products;  // If the query is empty, reset to the full product list
    } else {
      _filteredProducts = _products
          .where((product) => product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('https://crudcrud.com/api/$apiCode/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 201) {
        _products.add(Product.fromJson(jsonDecode(response.body)));
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      log(e.toString());
      return;
    }
  }

}
