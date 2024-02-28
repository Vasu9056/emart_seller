import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Controller/auth_controller.dart';
import 'package:emart_seller/views/Controller/profile_controller.dart';
import 'package:emart_seller/views/MessageScreen/message_screen.dart';
import 'package:emart_seller/views/Settingscreen/editprofile_screen.dart';
import 'package:emart_seller/views/ShopScreen/shop_screen.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:get/get.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});
  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  var controller = Get.put(ProfileController());
  // final _auth = FirebaseAuth.instance;
  // CollectionReference ref = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // User? user = _auth.currentUser;
    // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    //     .collection('vendors')
    //     .snapshots();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: boldText(text: settings, size: 16),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                )),
            TextButton(
                onPressed: () async {
                  Get.find<AuthController>().signoutmethod(context: context);
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout))
          ]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('vendors').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(white),
                ),
              );
            } else {
              Get.find<ProfileController>().snapshotData =
                  snapshot.data!.docs[0];
              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imgurl'] == ''
                        ? Image.asset(
                            imgProduct,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                            controller.snapshotData['imgurl'],
                            width: 74,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children: List.generate(
                            2,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() =>  ShopScreen());
                                      case 1:
                                        Get.to(() => const MessageScreen());
                                    }
                                  },
                                  leading: Icon(
                                    ProfileButtonIcons[index],
                                    color: white,
                                  ),
                                  title: normalText(
                                      text: ProfileButtonTtile[index]),
                                ))),
                  ),
                ],
              );
            }
          }),
    );
  }
}
