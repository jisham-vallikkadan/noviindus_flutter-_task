// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// class DropdownCustom extends StatelessWidget {
//   final List<String>? list;
//  final String? value;
//   // final List<DropdownMenuItem<String>> list;
//
//   final void Function(String?)? onChnge;
//
//   const DropdownCustom(
//       {super.key, this.onChnge, required this.list, this.value});
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(
//
//       // value: list,
//       icon: const Icon(
//         Icons.keyboard_arrow_down,
//         color: textColor,
//       ),
//       items: list!.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//
//       onChanged: onChnge,
//       value: value,
//       padding: const EdgeInsets.only(bottom: 8),
//       style: TextStyle(
//           fontSize: 12.sp, fontWeight: FontWeight.w400, color: textColor),
//       decoration: const InputDecoration(
//           hintText: "Select",
//           hintStyle: TextStyle(
//             color: Color(0xFFCACACA),
//             fontSize: 14,
//             fontFamily: "Manrope",
//             fontWeight: FontWeight.w600,
//           ),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.all(10),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
//               borderSide: BorderSide(color: Color(0XFFE1E8F2))),
//           disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
//               borderSide: BorderSide(color: Color(0XFFE1E8F2))),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
//               borderSide: BorderSide(color: Color(0XFFD0DAEA))),
//           filled: true,
//           fillColor: Color(0XFFF5F5F5)),
//     );
//   }
// }
