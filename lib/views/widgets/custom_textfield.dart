import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';

Widget customTextField({label, hint, controller, isdes = false}) {
  return TextFormField(
    style: TextStyle(color: white),
    controller: controller,
    maxLines: isdes ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: white,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: lightGrey)),
  );
}
