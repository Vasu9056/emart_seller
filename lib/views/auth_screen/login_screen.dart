import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Controller/auth_controller.dart';
import 'package:emart_seller/views/Homescreen/home.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:emart_seller/views/widgets/ourbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                normalText(text: welcome, size: 18.0),
                20.heightBox,
                Row(
                  children: [
                    Image.asset(
                      icLogo,
                      width: 70,
                      height: 70,
                    )
                        .box
                        .border(color: white)
                        .rounded
                        .padding(EdgeInsets.all(8.0))
                        .make(),
                    10.widthBox,
                    boldText(text: appname, size: 20.0),
                  ],
                ),
                40.heightBox,
                normalText(text: loginto, size: 18.0, color: lightGrey),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          hintText: emailHint,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          hintText: passwordHint,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          ),
                        ),
                      ),
                      10.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: normalText(
                                text: forgotPassword, color: purpleColor)),
                      ),
                      20.heightBox,
                      SizedBox(
                          width: context.screenWidth - 100,
                          child: controller.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(purpleColor),
                                  ),
                                )
                              : OurButton(
                                  title: login,
                                  onpress: () async {
                                    controller.isLoading(true);
                                    await controller.LoginMethod(
                                            context: context)
                                        .then((value) {
                                      if (value != null) {
                                        VxToast.show(context, msg: "Logged in");
                                        controller.isLoading(false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      } else {
                                        controller.isLoading(false);
                                      }
                                    });
                                  })),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .outerShadowMd
                      .padding(EdgeInsets.all(8.0))
                      .make(),
                ),
                10.heightBox,
                Center(child: normalText(text: anyProblem, color: lightGrey)),
                Spacer(),
                Center(child: boldText(text: credit)),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
