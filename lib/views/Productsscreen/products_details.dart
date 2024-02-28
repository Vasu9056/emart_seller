import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              height: 350,
              aspectRatio: 16 / 9,
              autoPlay: true,
              viewportFraction: 1.0,
              itemCount: data['p_images'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_images'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategory']}",
                          color: fontGrey,
                          size: 16.0),
                      10.heightBox,
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                    stepInt: true,
                  ),
                  10.heightBox,
                  boldText(
                      text: "\$${data['p_price']}", color: red, size: 18.0),
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: normalText(text: "Color", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                                3,
                                (index) => VxBox()
                                    .roundedFull
                                    .color(Color(data['p_colors'][index]))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .size(40, 40)
                                    .make()
                                    .onTap(() {})),
                          ),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child:
                                normalText(text: "Quantity", color: fontGrey),
                          ),
                          normalText(
                              text: "${data['p_quantity']} items",
                              color: fontGrey),
                        ],
                      ),
                    ],
                  ).box.white.padding(EdgeInsets.all(8.0)).make(),
                  Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: fontGrey)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
