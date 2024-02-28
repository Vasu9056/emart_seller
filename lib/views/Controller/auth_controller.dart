import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class AuthController extends GetxController
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  //login method
  Future<UserCredential?> LoginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }
  //signout Method
  signoutmethod({context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
