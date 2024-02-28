import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Productsscreen/add_product.dart';
import 'package:emart_seller/views/Productsscreen/products_details.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../Controller/product_controller.dart';

// ignore: must_be_immutable
class Productscreen extends StatelessWidget {
  Productcontroller controller = Get.put(Productcontroller());
  Productscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () async {
            await Get.find<Productcontroller>().getCategories();
            Get.find<Productcontroller>().populateCategoryList();
            Get.to(() => AddProduct(
                  key: key,
                ));
          },
          child: Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: boldText(text: products, color: darkGrey, size: 16.0),
          actions: [
            Center(
              child: normalText(
                  text:
                      intl.DateFormat("EEE,MMM d, ''yy").format(DateTime.now()),
                  color: purpleColor),
            )
          ],
        ),
        body: StreamBuilder(
            stream: StoreService.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(purpleColor),
                ));
              } else {
                var data = snapshot.data!.docs;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                        data.length,
                        (index) => Card(
                          child: ListTile(
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
                            subtitle: Row(
                              children: [
                                boldText(
                                    text: "\$${data[index]['p_price']}",
                                    color: darkGrey),
                                10.widthBox,
                                boldText(
                                    text: data[index]['isFeatured'] == true
                                        ? "Featured"
                                        : '',
                                    color: green),
                              ],
                            ),
                            trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                child: Icon(Icons.more_vert_rounded),
                                menuBuilder: () => Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      width: 200,
                                      child: Column(
                                        children: List.generate(
                                            PopupMenuTtile.length,
                                            (i) => Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Icon(PopupMenuIcons[i],
                                                        color: data[index][
                                                                        'featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? green
                                                            : darkGrey),
                                                    10.widthBox,
                                                    normalText(
                                                        text: data[index]['featured_id'] ==currentUser!.uid &&
                                                                i == 0
                                                            ? ' Remove featured'
                                                            : PopupMenuTtile[i],
                                                        color: darkGrey)
                                                  ],
                                                ).onTap(() {
                                                  switch (i) {
                                                    case 0:
                                                      if (data[index]
                                                              ['isFeatured'] ==
                                                          true) {
                                                        Get.find<
                                                                Productcontroller>()
                                                            .removeFeatured(
                                                                data[index].id);
                                                        VxToast.show(context,
                                                            msg: "Removed");
                                                      } else {
                                                        Get.find<
                                                                Productcontroller>()
                                                            .addFeatured(
                                                                data[index].id);
                                                        VxToast.show(context,
                                                            msg: "Added");
                                                      }
                                                      break;

                                                    case 1:
                                                      break;
                                                    case 2:
                                                      Get.find<
                                                              Productcontroller>()
                                                          .removeProduct(
                                                              data[index].id);
                                                      VxToast.show(context,
                                                          msg:
                                                              "Product removed");
                                                  }
                                                }))),
                                      ),
                                    ),
                                clickType: VxClickType.singleClick),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
