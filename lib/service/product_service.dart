import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/model.dart';

String apiCode = "eb9b07a72659496487877bd6a4876bab";

Future<List<Product>> fetchProducts(int page, int limit) async {
  final response = await http.get(Uri.parse('https://crudcrud.com/api/$apiCode/products?page=$page&limit=$limit'));

  if (response.statusCode == 200) {
    final List<dynamic> productList = jsonDecode(response.body);
    return productList.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

Future<void> addProduct(Product product) async {
  final response = await http.post(
    Uri.parse('https://crudcrud.com/api/$apiCode/products'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(product.toJson()),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to add product');
  }
}

Future<void> updateProduct(Product product) async {
  final response = await http.put(
    Uri.parse('https://crudcrud.com/api/$apiCode/products/${product.id}'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(product.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update product');
  }
}

Future<void> deleteProduct(String id) async {
  final response = await http.delete(Uri.parse('https://crudcrud.com/api/$apiCode/products/$id'));
  if (response.statusCode != 200) {
    throw Exception('Failed to delete product');
  }
}

