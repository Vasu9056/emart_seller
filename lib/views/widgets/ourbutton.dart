import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';

Widget OurButton({title, color = purpleColor, onpress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: color,
        padding: EdgeInsets.all(12),
      ),
      onPressed: onpress,
      child: normalText(
        text: title,
        size: 16,
      ));
}
