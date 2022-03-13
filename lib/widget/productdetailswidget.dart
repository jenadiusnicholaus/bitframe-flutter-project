import 'package:ente/models/product_models.dart';
import 'package:flutter/material.dart';

import 'package:flutter_multi_carousel/carousel.dart';

class ProductDetailsWidget extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsWidget({Key key, this.productModel}) : super(key: key);
  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.on(vertical: 20),
          child: Carousel(
              height: 230.0,
              width: double.infinity,
              initialPage: 3,
              allowWrap: false,
              type: Types.slideSwiper,
              onCarouselTap: (i) {
                print("onTap $i");
              },
              indicatorType: IndicatorTypes.bubble,
              arrowColor: Colors.black,
              axis: Axis.horizontal,
              showArrow: true,
              children: List.generate(
                  7,
                  (i) =>
                      Container(color: Colors.red.withOpacity((i + 1) / 7)))),
        ),
        Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.productModel.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' Tsh: ${widget.productModel.price}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${widget.productModel.description} ',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Location name',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/location.png'),
                  fit: BoxFit.cover)),
        ))
      ],
    );
  }
}
