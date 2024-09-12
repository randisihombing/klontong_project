import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategorySelectionScreen(),
    );
  }
}

class CategorySelectionScreen extends StatefulWidget {
  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  List<dynamic> categoryList = [
    {'category_id': '1', 'category_name': 'Makanan'},
    {'category_id': '2', 'category_name': 'Ciki'},
    {'category_id': '3', 'category_name': 'Minuman'},
    {'category_id': '4', 'category_name': 'Dan lain-lain'},
  ];

  // Variable to store the filtered category list
  List<dynamic> filteredCategoryList = [];

  // Variable to track selected category
  String? selectedCategoryId;

  // TextEditingController for the TextField
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCategoryList = categoryList; // Initialize with full list
  }

  // Method to filter the category list based on input
  void filterCategories(String query) {
    List<dynamic> filtered = categoryList.where((category) {
      String categoryName = category['category_name'].toLowerCase();
      return categoryName.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCategoryList = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField for category input
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Search Category',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                filterCategories(value); // Filter categories as user types
              },
            ),
            SizedBox(height: 16.0),
            // ListView to display filtered categories

          ],
        ),
      ),
    );
  }
}
