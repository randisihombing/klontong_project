// {
// "id": 86,
// "CategoryId": 14,
// "categoryName": "Cemilan",
// "sku": "MHZVTK",
// "name": "Ciki ciki",
// "description": "Ciki ciki yang super enak, hanya di toko klontong kami",
// "weight": 500,
// "width": 5,
// "length": 5,
// "height": 5,
// "image": "https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b",
// "harga": 30000
// }


class Product {
  String? id;
  String? categoryId;
  String? categoryName;
  String? sku;
  String? name;
  String? description;
  double? weight;
  double? width;
  double? length;
  double? height;
  String? image;
  double? price;

  Product({
    this.id,
    this.categoryId,
    this.categoryName,
    this.sku,
    this.name,
    this.description,
    this.weight,
    this.width,
    this.length,
    this.height,
    this.image,
    this.price,
  });

  // Convert JSON to Product object
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    sku = json['sku'];
    name = json['name'];
    description = json['description'];
    weight = json['weight'];
    width = json['width'];
    length = json['length'];
    height = json['height'];
    image = json['image'];
    price = json['price'];
  }

  // Convert Product object to JSON

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['sku'] = sku;
    data['name'] = name;
    data['description'] = description;
    data['weight'] = weight;
    data['width'] = width;
    data['length'] = length;
    data['height'] = height;
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}