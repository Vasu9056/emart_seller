import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';

Widget ChatBubble() {
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            normalText(text: "Your message here...."),
            10.heightBox,
            normalText(text: "10:45 PM")
          ],
        ),
      ));
}
