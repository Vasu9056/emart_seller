import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/views/Controller/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Productcontroller extends GetxController {
  var pnamecontroller = TextEditingController();
  var pdesccontroller = TextEditingController();
  var ppricecontroller = TextEditingController();
  var pquantitycontroller = TextEditingController();
  var categorylist = <String>[].obs;
  var subcategoryList = <String>[].obs;
  var isLoading = false.obs;
  List<Category> category = [];

  var pimageslink = [];
  var pImageList = RxList<dynamic>.generate(3, (index) => null);
  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedcolorIndex = ''.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categorylist.clear();
    for (var item in category) {
      categorylist.add(item.name);
    }
  }

  populateSubcategory(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) {
        return;
      } else {
        pImageList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pimageslink.clear();
    for (var item in pImageList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';

        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pimageslink.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'isFeatured': false,
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'p_images': FieldValue.arrayUnion(pimageslink),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdesccontroller.text,
      'p_name': pnamecontroller.text,
      'p_price': ppricecontroller.text,
      'p_quantity': pquantitycontroller.text,
      'p_seller': Get.find<Homecontroller>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isLoading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async {
    await firestore.collection(productCollection).doc(docId).set(
      {
        'featured_id': currentUser!.uid,
        'isFeatured': true,
      },
      SetOptions(merge: true),
    );
  }

  removeFeatured(docId) async {
    await firestore.collection(productCollection).doc(docId).set(
      {
        'featured_id': '',
        'isFeatured': false,
      },
      SetOptions(merge: true),
    );
  }

  removeProduct(docId) async {
    await firestore.collection(productCollection).doc(docId).delete();
  }
}
