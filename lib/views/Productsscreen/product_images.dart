import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';

Widget ProductImages({required label, onpress}) {
  return Column(
    children: [
      "$label"
          .text
          .bold
          .color(fontGrey)
          .size(16.0)
          .makeCentered()
          .box
          .color(lightGrey)
          .size(100, 100)
          .roundedSM
          .make(),
    ],
  );
}
