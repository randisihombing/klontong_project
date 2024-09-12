import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/error_field_required.dart';
import '../helper/constant.dart';
import '../helper/utils.dart';
import '../model/item_selection.dart';
import '../model/model.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  double _price = 0.0;
  String _categoryName = '';
  String _categoryId = '';
  bool categoryValidation = true;

  String? photo;
  String photoPath = "";
  bool pickPhoto = false;
  bool photoValidation = true;

  List<dynamic> categoryList = [
    {
      'category_id': '1',
      'category_name': 'Makanan'
    },
    {
      'category_id': '2',
      'category_name': 'Ciki'
    },
    {
      'category_id': '3',
      'category_name': 'Minuman'
    },
    {
      'category_id': '4',
      'category_name': 'Dan lain-lain'
    },
  ];


  @override
  void initState() {
    super.initState();
  }

  void _submitForm() async {
    if(validationCategory()){
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        Product newProduct = Product(
          id: '', // Backend will generate the ID, so leave it empty initially
          name: _name,
          categoryName: _categoryName,
          categoryId: _categoryId,
          description: _description,
          price: _price,
          image: photo,
        );

        // Add the product using the provider
        await Provider.of<ProductProvider>(context, listen: false).addProduct(newProduct);

        // Navigate back after submission
        if(!mounted) {
          return;
        }
        Navigator.pop(context);
      }
    }
  }

  void _pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickPhoto = true;
        File fileTemp = File(image.path);
        Uint8List photoBusinessPlaceBytes = fileTemp.readAsBytesSync();
        photo = base64Encode(photoBusinessPlaceBytes);
        photoPath = image.path;
        photoValidation = true;
        debugPrint("path local =>${image.path}");
      });
    }
  }

  bool validationCategory(){
    bool validation = true;
    if(_categoryName.isEmpty && _categoryName == ""){
      categoryValidation = false;
      validation = false;
    }

    if(photoPath == ""){
      photoValidation = false;
      validation = false;
    }

    setState(() {
      categoryValidation;
      photoValidation;
      validation;
    });

    return validation;
  }

  Widget _displayAddedPhoto(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: MyColors.mediumGray, width: 1)
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(Utils.convertBase64Image(photo!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: (){
                setState(() {
                  photo = null;
                  photoPath = "";
                  pickPhoto = false;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                width: 30,
                height: 30,
                child: Image.asset(MyIcons.statusRejected),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _plusIconButton(String title, VoidCallback onClicked,
      {double marginTop = 20, double marginBottom = 20}){
    return InkWell(
      onTap: onClicked,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  MyIcons.addCircleBlue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: MyColors.blueSea,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.black, width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Product Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                DropdownMenu(
                  width: MediaQuery.of(context).size.width / 1.1,
                  hintText: "Category",
                  initialSelection: categoryList[0]["category_name"],
                  dropdownMenuEntries: categoryList.map<DropdownMenuEntry<dynamic>>((dynamic value) {
                    return DropdownMenuEntry<dynamic>(
                      value: value,
                      label: value['category_name'],
                    );
                  }).toList(),
                  onSelected: (dynamic value){
                    setState(() {
                      _categoryName = value['category_name'];
                      _categoryId = value['category_id'];
                      categoryValidation = true;
                    });
                  },
                ),
                if(!categoryValidation)
                  const ErrorFieldRequired(),
                const SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.black, width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.black, width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _price = double.parse(value!);
                      },
                    ),
                  ),
                ),
                photo == null ?
                _plusIconButton("Upload Photo",
                        ()=>_pickImage()) :
                _displayAddedPhoto(),
                if(!photoValidation)
                  const ErrorFieldRequired(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
