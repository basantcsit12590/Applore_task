import 'dart:io';

import 'package:applore_task/pages/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController productName;
  late TextEditingController productPrice;
  late TextEditingController productDescription;
  XFile? image;
  final picker = ImagePicker();
  CollectionReference products =
      FirebaseFirestore.instance.collection('ITProduct');

  void addData() async {
    final imgUrl = await uploadImage(image);
    await products.add({
      "productName": productName.text,
      "productPrice": productPrice.text,
      "productDescription": productDescription.text,
      "productImage": imgUrl,
    }).then((value) {
      productName.clear();
      productPrice.clear();
      productDescription.clear();
    });
  }

  String? downloadUrl;

  uploadImage(image) async {
    String url;
    Reference reference =
        FirebaseStorage.instance.ref().child('/images').child("asded");
    await reference.putFile(image);
    url = await reference.getDownloadURL();
    return url;
  }

  Future<void> selectImage() async {
    image = null;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (pickedFile != null) {
      var path = pickedFile.path;
      var bytes = pickedFile.readAsBytes();
      image = XFile(pickedFile.path);
    } else {}
    setState(() {});
  }

  @override
  void initState() {
    productName = new TextEditingController();
    productPrice = new TextEditingController();
    productDescription = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text('Add New Product'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: image == null
                            ? Center(child: Text("No image Selected"))
                            : Container(
                                height: 80,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: FileImage(File(image!.path)),
                                      fit: BoxFit.cover),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: ButtonWidget(
                            text: "Select Image",
                            iconData: Icons.cloud_upload_outlined,
                            onClicked: () {
                              selectImage()
                                  .whenComplete(() => uploadImage(image));
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                  autofocus: true,
                  autocorrect: true,
                  controller: productName,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  autocorrect: true,
                  autofocus: true,
                  controller: productPrice,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Product Description'),
                  autocorrect: true,
                  autofocus: true,
                  controller: productDescription,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    addData();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
