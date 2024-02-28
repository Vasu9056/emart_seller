import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Controller/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});
  var controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: purpleColor,
          elevation: 0.0,
          title: boldText(text: settings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(white),
                  ))
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopname: controller.shopnameController.text,
                        shopaddress: controller.shopadressController.text,
                        shopmobile: controller.shopmobileController.text,
                        shopwebsite: controller.shopwebsiteController.text,
                        shopdesc: controller.shopdescController.text,
                      );
                      VxToast.show(context, msg: "shop updated");
                      controller.isLoading(false);
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  label: shopname,
                  hint: nameHint,
                  controller: controller.shopnameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: shopAdressHint,
                  controller: controller.shopadressController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopmobileController),
              10.heightBox,
              customTextField(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopwebsiteController),
              10.heightBox,
              customTextField(
                  label: description,
                  hint: shopDescHint,
                  isdes: true,
                  controller: controller.shopdescController)
            ],
          ),
        ),
      ),
    );
  }
}
