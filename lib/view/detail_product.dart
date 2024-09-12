import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/utils.dart';
import '../model/model.dart';

class DetailProduct extends StatelessWidget {
  final Product product;

  const DetailProduct({
    required this.product,
    Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(Utils.convertBase64Image(product.image!),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${product.price.toString()}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              product.categoryName ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              product.description ?? "",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
