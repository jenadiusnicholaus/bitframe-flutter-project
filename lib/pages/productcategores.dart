import 'package:ente/ApiServices/productService.dart';
import 'package:ente/constants/baseAppbar.dart';
import 'package:ente/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ProductCategoriesPage extends StatefulWidget {
  @override
  _ProductCategoriesPageState createState() => _ProductCategoriesPageState();
}

class _ProductCategoriesPageState extends State<ProductCategoriesPage> {
  List<ProductCategories> productcategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(),
        body: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  Container(
                      width: 100,
                      // color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.list),
                          Icon(Icons.more_vert),
                        ],
                      ))
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 650,
                    // color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    child: FutureBuilder<List<ProductCategories>>(
                        future: productCategories(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ProductCategories>> snapshot) {
                          if (snapshot.hasData) {
                            productcategories = snapshot.data.toList();
                            return GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 2.0,
                              children: List.generate(productcategories.length,
                                  (index) {
                                return Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    productcategories[index]
                                                        .imageUrl),
                                                fit: BoxFit.cover),
                                            color: Colors.teal.shade900
                                                .withOpacity(.2),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                        child: Chip(
                                          backgroundColor: Colors.teal.shade900,
                                          label: Text(
                                            '${productcategories[index].name}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          avatar: CircleAvatar(
                                            child: Text(
                                                '${productcategories[index].name[0]}'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          } else {
                            return Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
