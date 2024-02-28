import 'dart:ffi';

import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Controller/product_controller.dart';
import 'package:emart_seller/views/Productsscreen/product_dropdown.dart';
import 'package:emart_seller/views/Productsscreen/product_images.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  Productcontroller controller = Get.find<Productcontroller>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(
        () => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            backgroundColor: purpleColor,
            elevation: 0.0,
            title: boldText(text: "Add Product", color: white, size: 16),
            leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                )),
            actions: [
              controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(white),
                    ))
                  : TextButton(
                      onPressed: () async {
                        controller.isLoading(true);
                        await controller.uploadImages();
                        await controller.uploadProduct(context);
                        Get.back();
                      },
                      child: boldText(text: save, color: white))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(
                      hint: "eg. BMW",
                      label: "Product name",
                      controller: controller.pnamecontroller),
                  10.heightBox,
                  customTextField(
                      hint: "eg. Nice product",
                      label: "Description",
                      isdes: true,
                      controller: controller.pdesccontroller),
                  10.heightBox,
                  customTextField(
                      hint: "eg. \$100",
                      label: "Price",
                      controller: controller.ppricecontroller),
                  10.heightBox,
                  customTextField(
                      hint: "eg. 20",
                      label: "Quantity",
                      controller: controller.pquantitycontroller),
                  10.heightBox,
                  ProductDropdown("Category", controller.categorylist,
                      controller.categoryvalue, controller),
                  10.heightBox,
                  ProductDropdown("SubCategory", controller.subcategoryList,
                      controller.subcategoryvalue, controller),
                  15.heightBox,
                  const Divider(
                    color: white,
                  ),
                  boldText(text: "Choose product images"),
                  10.heightBox,
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => controller.pImageList[index] != null
                              ? Image.file(
                                  controller.pImageList[index],
                                  width: 100,
                                ).onTap(() {
                                  controller.pickImage(index, context);
                                })
                              : ProductImages(label: "${index + 1}").onTap(() {
                                  controller.pickImage(index, context);
                                })),
                    ),
                  ),
                  10.heightBox,
                  normalText(
                      text: "First page will be your display image",
                      color: lightGrey),
                  const Divider(
                    color: white,
                  ),
                  10.heightBox,
                  boldText(text: "Choose product color"),
                  10.heightBox,
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                          9,
                          (index) => Stack(
                                alignment: Alignment.center,
                                children: [
                                  VxBox()
                                      .color(Vx.randomPrimaryColor)
                                      .roundedFull
                                      .size(60, 60)
                                      .make()
                                      .onTap(() {
                                    controller.selectedcolorIndex.value =
                                        index.toString();
                                  }),
                                  controller.selectedcolorIndex.value ==
                                          index.toString()
                                      ? const Icon(Icons.done, color: white)
                                      : SizedBox(),
                                ],
                              )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
