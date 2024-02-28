import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';

Widget dashboardButton(BuildContext context, {String? title, count, icon}) {
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          boldText(text: title, size: 16),
          boldText(text: count, size: 20)
        ],
      )),
      Image.asset(
        icon ?? 'assets/icons/abc.png',
        width: 40,
        color: white,
      ),
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .padding(EdgeInsets.all(8))
      .size(context.screenWidth * 0.4, 80)
      .make();
}
