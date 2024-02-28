import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Controller/product_controller.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Widget ProductDropdown(
  hint,
  List<String> list,
  dropvalue,
  Productcontroller controller
) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "${hint}", color: fontGrey),
        value: dropvalue == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map(
          (e) {
            return DropdownMenuItem(
              child: e.toString().text.make(),
              value: e,
            );
          },
        ).toList(),
        onChanged: (newvalue) {
          if(hint=="Category")
          {
            // var newvalue;
            controller.subcategoryvalue.value='';
            controller.populateSubcategory(newvalue.toString());
          }
          dropvalue.value=newvalue.toString();
        },
      ),
    ).box.white.roundedSM.padding(EdgeInsets.symmetric(horizontal: 4)).make(),
  );
}
