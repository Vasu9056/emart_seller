import 'package:emart_seller/const/const.dart';
import 'package:intl/src/intl/date_format.dart';
Widget normalText( {text, color = Colors.white, size = 14.0}) {
  return "$text".text.size(size.toDouble()).color(color).make();
}
Widget boldText({text, color = Colors.white, size = 14.0}) {
  return "$text".text.semiBold.color(color).size(size.toDouble()).make();
}
