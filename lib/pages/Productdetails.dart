import 'package:ente/constants/baseAppbar.dart';
import 'package:ente/models/product_models.dart';
import 'package:ente/widget/productdetailswidget.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;
  final String username;

  const ProductDetails({Key key, this.productModel, this.username})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        username: widget.username,
      ),
      body: ProductDetailsWidget(
        productModel: widget.productModel,
      ),
    );
  }
}
