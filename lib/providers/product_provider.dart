import 'package:applore_task/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> productITList = [];
  ProductModel? productModel;
  // int documnetLimit = 4;
  // bool hasNext = true;
  bool isfetchingProduct = false;
  fetchITProductsData() async {
    List<ProductModel> newProductITList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("ITProduct").get();
    value.docs.forEach((element) {
      // print(element.data());
      productModel = ProductModel(
          productImage: element.get('productImage'),
          productName: element.get('productName'),
          productDescription: element.get('productDescription'),
          productPrice: element.get('productPrice'));
      newProductITList.add(productModel!);
    });
    productITList = newProductITList;
    notifyListeners();
  }

  List<ProductModel> get getITProductsList {
    return productITList;
  }
}
