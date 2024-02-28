import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/views/Controller/orders_controller.dart';
import 'package:emart_seller/views/Orderscreen/componets/order_place.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:emart_seller/views/widgets/ourbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  OrderDetails({super.key, this.data});
  final dynamic data;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Order details", color: fontGrey, size: 16),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: OurButton(
                color: green,
                onpress: () {
                  controller.confirmed(true);
                  controller.changeStates(
                      title: "order_confirmed",
                      status: true,
                      docId: widget.data.id);
                },
                title: "Confirm Order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          boldText(
                              text: "Order status",
                              color: fontGrey,
                              size: 16.0),
                        ],
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                          controller.confirmed(true);
                          controller.changeStates(
                              title: "order_on_delivery",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "on Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.confirmed(true);
                          controller.changeStates(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .outerShadowMd
                      .border(color: lightGrey)
                      .padding(EdgeInsets.all(8))
                      .roundedSM
                      .white
                      .make(),
                ),

                //order details section

                Column(
                  children: [
                    OrderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['Shipping_method']}",
                      title1: "Order code",
                      title2: "Shipping Method",
                    ),
                    OrderPlaceDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((widget.data['order_date'].toDate())),
                      d2: "${widget.data['payment_method']}",
                      title1: "Order Date",
                      title2: "Payment Method",
                    ),
                    OrderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order placed",
                      title1: "Payment status",
                      title2: "Delivery status",
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_phone']}".text.make(),
                              "${widget.data['order_by_PinCode']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount ", color: purpleColor),
                                boldText(
                                    text: " \$${widget.data['total_amount']}",
                                    color: red,
                                    size: 16.0)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .border(color: lightGrey)
                    .roundedSM
                    .white
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Ordered Product", color: fontGrey, size: 16.0),
                10.heightBox,
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderPlaceDetails(
                          title1: "${controller.orders[index]['title']}",
                          title2: "\$${controller.orders[index]['tprice']}",
                          d1: "${controller.orders[index]['qtu']}x",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(EdgeInsets.only(bottom: 4))
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
