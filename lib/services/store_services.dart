import 'package:emart_seller/const/firebase_const.dart';

class StoreService {
  static getProfile(uid) {
    return firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }
  static getMessage(uid){
    return  firestore.collection(chatCollection).where('told', isEqualTo: uid).snapshots();

  }
  static getOrders(uid)
  {
    return firestore.collection(orderCollection).where('vendors', arrayContains: uid).snapshots();
  }

  static getProducts(uid)
  {
    return firestore.collection(productCollection).where('vendor_id',isEqualTo: uid).snapshots();
  }

  static getPopularProducts(uid)
  {
      return firestore.collection(productCollection).where('vendor_id' ,isEqualTo: uid).orderBy('p_wishlist'.length);
  }
}
