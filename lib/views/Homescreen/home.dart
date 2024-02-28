import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Controller/home_controller.dart';
import 'package:emart_seller/views/Homescreen/home_screen.dart';
import 'package:emart_seller/views/Orderscreen/order_screen.dart';
import 'package:emart_seller/views/Productsscreen/product_screen.dart';
import 'package:emart_seller/views/Settingscreen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Homecontroller());

    var navscreen = [
      Homescreen(),
      Productscreen(),
      Orderscreen(),
      Profilescreen(),
    ];
    var bottomnavbar = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProduct,
          color: darkGrey,
          width: 24,
        ),
        label: products,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            color: darkGrey,
            width: 24,
          ),
          label: order),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            color: darkGrey,
            width: 24,
          ),
          label: settings),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              onTap: (value) {
                controller.navIndex.value = value;
              },
              currentIndex: controller.navIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: purpleColor,
              unselectedItemColor: darkGrey,
              items: bottomnavbar),
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(child: navscreen.elementAt(controller.navIndex.value))
            ],
          ),
        ),
      ),
    );
  }
}
