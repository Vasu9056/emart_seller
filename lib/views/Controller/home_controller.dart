import 'package:emart_seller/const/firebase_const.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getusername();
  }

  var navIndex = 0.obs;
  var username = '';
  getusername() async {
    var n = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });

    username = n;
    print(username);
  }
}
