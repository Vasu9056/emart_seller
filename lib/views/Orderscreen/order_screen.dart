import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/views/Orderscreen/order_detail.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;
import '../Controller/orders_controller.dart';

class Orderscreen extends StatelessWidget {
  OrdersController controller = Get.put(OrdersController());

  Orderscreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: boldText(text: order, color: darkGrey, size: 16.0),
          actions: [
            Center(
              child: normalText(
                  text:
                      intl.DateFormat("EEE,MMM d, ''yy").format(DateTime.now()),
                  color: purpleColor),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(white),
                );
              } else {
                var data = snapshot.data!.docs;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(
                              data: data[index],
                              ));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: textfieldGrey,
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: purpleColor),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.car_crash,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(text: unpaid, color: red),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "\$ ${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                );
              }
            }));
  }
}
