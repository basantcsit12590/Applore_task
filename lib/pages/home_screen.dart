import 'dart:ui';

import 'package:applore_task/pages/add_products.dart';
import 'package:applore_task/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchITProductsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Home"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProducts()));
            },
            child: Row(
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Center(child: Text("Add Product"))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.shop,
                      size: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, data, index) {
        var productData = data.getITProductsList;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/itproducts.jpg',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 120, bottom: 10),
                            child: Container(
                              height: 35,
                              width: 60,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40)),
                                  color: Colors.blueGrey),
                              child: const Center(
                                child: Text(
                                  "IT Products",
                                  style: TextStyle(
                                      fontSize: 7,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 3,
                                            offset: Offset(2, 2))
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "30% OFF",
                            style: TextStyle(
                                fontSize: 30,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 5,
                                      offset: Offset(3, 3))
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            "On all IT Products",
                            style: TextStyle(
                                fontSize: 16,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 5,
                                      offset: Offset(3, 3))
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                      itemCount: productData.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blueGrey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: double.infinity,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                productData[index]
                                                    .productImage!,
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Name: ${productData[index].productName}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          Container(
                                            height: 90,
                                            width: 130,
                                            child: Text(
                                              productData[index]
                                                  .productDescription!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                            ),
                                          ),
                                          Text(
                                            "Price:${productData[index].productPrice}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
