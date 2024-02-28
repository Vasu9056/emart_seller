import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/Productsscreen/products_details.dart';
import 'package:emart_seller/views/widgets/dashboard_button.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: boldText(text: dashboard, color: darkGrey, size: 16.0),
            actions: [
              Center(
                child: normalText(
                    text: intl.DateFormat("EEE,MMM d, ''yy")
                        .format(DateTime.now()),
                    color: purpleColor),
              )
            ],
          ),
          body: StreamBuilder(
              stream: StoreService.getProducts(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(purpleColor),
                  ));
                } else {
                  var data = snapshot.data!.docs;
                  data = data.sortedBy(((a, b) => b['p_wishlist']
                      .length
                      .compareTo(a['p_wishlist'].length)));
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: products,
                              count: "${data.length}",
                              icon: icProduct),
                          dashboardButton(context,
                              title: order, count: "15", icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: rating, count: "60", icon: icStar),
                          dashboardButton(context,
                              title: totalsales, count: "15", icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Divider(),
                      10.heightBox,
                      boldText(text: popular, color: fontGrey),
                      10.heightBox,
                      ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_images'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: boldText(
                                      text: "\$${data[index]['p_price']}",
                                      color: darkGrey),
                                ),
                        ),
                      )
                    ],
                  );
                }
              })),
    );
  }
}
