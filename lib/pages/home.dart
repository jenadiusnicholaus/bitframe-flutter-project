import 'package:ente/ApiServices/productService.dart';
import 'package:ente/constants/baseAppbar.dart';
import 'package:ente/models/product_models.dart';
import 'package:ente/pages/Productdetails.dart';
import 'package:ente/pages/productcategores.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String username;
  List<ProductModel> products;

  Home({Key key, this.username}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int grid = 1;
  int countTaps = 1;
  String productid;
  var dropdownValue;
  bool _showFrontSide = false;

  Widget __buildLayout({Key key, Icon icon, Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: icon,
      ),
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Colors.green,
      icon: Icon(
        Icons.add_shopping_cart_outlined,
        color: _showFrontSide ? Colors.white : Colors.red,
      ),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.add_shopping_cart_outlined,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal[50],
      body: Container(
        margin: EdgeInsets.only(bottom: 7),
        padding: EdgeInsets.only(bottom: 1),
        child: Column(
          children: [
            // FutureBuilder(builder: (BuildContext context, Asy)),
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: productList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModel>> snapshot) {
                  if (snapshot.hasData) {
                    widget.products = snapshot.data.toList();
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (grid == 1) ? 0 : 0),
                          // margin: EdgeInsets.only(bottom: 2),
                          child: GridView.count(
                            crossAxisCount: grid,
                            children:
                                List.generate(widget.products.length, (index) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                // width: 200,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: (grid == 2) ? 1 : 10),
                                decoration: BoxDecoration(
                                    // color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.4),
                                        width: 2)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: (grid == 1) ? 50 : 37,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(13),
                                          topRight: Radius.circular(13),
                                        ),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.4),
                                            width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${widget.products[index].name}',
                                                style: TextStyle(
                                                    fontSize:
                                                        (grid == 1) ? 20 : 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Vanja Bei ',
                                                      style: TextStyle(
                                                          fontSize: (grid == 1)
                                                              ? 15
                                                              : 10,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons.pin_drop,
                                                      size: 17,
                                                    ),
                                                    (grid == 1)
                                                        ? Text(
                                                            'Dar es salaam, madukani ',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    (grid == 1)
                                                                        ? 15
                                                                        : 10,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(''),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: (grid == 1) ? 230 : .6,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${widget.products[index].imageUrls}'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: (grid == 1) ? 150 : 70,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    (grid == 1) ? 4 : 1),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(.4),
                                                    width: 2)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.favorite_outline,
                                                  size: (grid == 1) ? 20 : 10,
                                                ),
                                                Text(
                                                  ' 122+ likes',
                                                  style: TextStyle(
                                                      fontSize:
                                                          (grid == 1) ? 20 : 10,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: (grid == 1) ? 100 : 60,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(.4),
                                                    width: 2)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    ' Tsh ${widget.products[index].price}',
                                                    style: TextStyle(
                                                        fontSize: (grid == 1)
                                                            ? 13
                                                            : 10,
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withRed(2),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                productid =
                                                    widget.products[index].id;
                                                _showFrontSide =
                                                    !_showFrontSide;
                                              });

                                              await addToCart(
                                                  widget.products[index].id);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: (grid == 1) ? 60 : 30,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width: 2)),
                                              child: AnimatedSwitcher(
                                                duration:
                                                    Duration(milliseconds: 600),
                                                child: (_showFrontSide &&
                                                        productid ==
                                                            widget
                                                                .products[index]
                                                                .id)
                                                    ? _buildFront()
                                                    : _buildRear(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                      productModel: widget
                                                          .products[index],
                                                      username: widget.username,
                                                    )));
                                      },
                                      child: Container(
                                        height: (grid == 1) ? 50 : 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(13),
                                              bottomRight: Radius.circular(13),
                                            ),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 4)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Product details',
                                                style: TextStyle(
                                                    fontSize:
                                                        (grid == 1) ? 20 : 15,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  'Products',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          countTaps++;
                                          if (countTaps % 2 == 0) {
                                            grid = 2;
                                          } else {
                                            grid = 1;
                                          }
                                        });
                                      },
                                      child: (grid % 2 != 0)
                                          ? Icon(
                                              Icons.list,
                                              size: 20,
                                            )
                                          : Icon(
                                              Icons.grid_on_outlined,
                                              size: 17,
                                            ),
                                    ),
                                    PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry>[
                                        PopupMenuItem(
                                          child: GestureDetector(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductCategoriesPage())),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.category_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              title: Text('Categories'),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.map_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            title: Text('View on a Map'),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.recommend,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            title: Text('Recommended'),
                                          ),
                                        ),
                                        // const PopupMenuDivider(),
                                        // const PopupMenuItem(child: Text('')),
                                        // const PopupMenuItem(child: Text('')),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            // color: Colors.amber,
                            height: 30,
                            width: 30,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
