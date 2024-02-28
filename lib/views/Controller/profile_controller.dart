import 'dart:io';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImgPath = ''.obs;
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  var profileImagelink = '';
  var isLoading = false.obs;

  //shop  controllers

  var shopnameController = TextEditingController();
  var shopmobileController = TextEditingController();
  var shopadressController = TextEditingController();
  var shopwebsiteController = TextEditingController();
  var shopdescController = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) return;
      profileImgPath.value = img.path;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgurl}) async {
    var store = FirebaseFirestore.instance
        .collection(vendorsCollection)
        .doc(currentUser!.uid);
    await store.set({
      'vendor_name': name,
      'password': password,
      'imgurl': imgurl,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthpassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred);
    await currentUser!.updatePassword(newpassword);
  }

  catcherror(error) {
    print(error.toString());
  }

  updateShop({shopname, shopaddress, shopmobile, shopdesc, shopwebsite}) async {
    var store = FirebaseFirestore.instance
        .collection(vendorsCollection)
        .doc(currentUser!.uid);
    await store.set({
      'shop_name': shopname,
      'shop_address': shopaddress,
      'shop_mobile': shopmobile,
      'shop_website': shopwebsite,
      'shop_desc': shopdesc,
    }, SetOptions(merge: true));
  }
}

const usercollection =
    'users'; // Define 'usercollection' if not already defined.

    