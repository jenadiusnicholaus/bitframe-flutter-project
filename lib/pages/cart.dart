import 'package:ente/ApiServices/productService.dart';
import 'package:ente/constants/app_constants.dart';
import 'package:ente/models/product_models.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  List<Order> order;

  ShoppingCart({Key key, this.order}) : super(key: key);
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: 630,
                child: FutureBuilder<List<Order>>(
                    future: getCartlist(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Order>> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        widget.order = snapshot.data.toList();
                        return Stack(
                          children: [
                            Container(
                              height: 500,
                              padding: EdgeInsets.only(top: 100),
                              child: ListView.builder(
                                  itemCount: widget.order.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var orderData = widget.order[index];
                                    return Container(
                                      color: Colors.teal.withOpacity(.1),
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  Colors.teal.withOpacity(.2),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    Constants.onlineTesturl +
                                                        '${orderData.image}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${orderData.productName}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '${orderData.price}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: double.infinity,
                                            width: 100,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.teal.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '${orderData.quantity}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.teal.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                height: 80,
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Shopping Cart',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            'Verify your quantity and click checkout',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Icon(Icons.more_vert_outlined)
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              child: Container(
                                height: 100,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total:',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Tsh in process',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.check_outlined),
                                        label: Text(
                                          'Checkout',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              )),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
