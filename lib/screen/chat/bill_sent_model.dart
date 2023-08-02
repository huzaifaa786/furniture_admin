// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:furniture_admin/chat/controller.dart';
// import 'package:furniture_admin/static/large_button.dart';
// import 'package:furniture_admin/values/Validator.dart';
// import 'package:furniture_admin/values/colors.dart';

// class InvoiceGenertaeScreen extends StatefulWidget {
//   const InvoiceGenertaeScreen({Key? key}) : super(key: key);
//   @override
//   State<InvoiceGenertaeScreen> createState() => _InvoiceGenertaeScreenState();
// }

// class _InvoiceGenertaeScreenState extends State<InvoiceGenertaeScreen> {
//   TextEditingController discriptionController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController timeController = TextEditingController();
//   final dateformatter = FilteringTextInputFormatter.allow(RegExp(r'^[0-9/]*$'));
//   final timeformatter = FilteringTextInputFormatter.allow(RegExp(r'^[0-9-]*$'));

//   // void onSendMessage(String content, int type) {
//   //   if (content.trim().isNotEmpty) {
//   //     textEditingController.clear();
//   //     chatProvider.sendMessage(
//   //         content, type, groupChatId, currentUserId, widget.arguments.peerId);
//   //     if (listScrollController.hasClients) {
//   //       listScrollController.animateTo(0,
//   //           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//   //     }
//   //   } else {
//   //     // Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
//   //   }
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Generate Bill'),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: TextField(
//             controller: discriptionController,
//             scrollPadding: const EdgeInsets.only(bottom: 30),
//             obscureText: false,
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             decoration: InputDecoration(
//               // prefixIcon: Padding(
//               //   padding: const EdgeInsets.all(10.0),
//               //   child: Image.asset(
//               //     'assets/images/location.png',
//               //     width: 1,
//               //     height: 1,
//               //     fit: BoxFit.fill,
//               //   ),
//               // ),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//               ),
//               hintText: 'Discription of delivery items',
//               hintStyle: TextStyle(fontSize: 12)

//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: TextField(
//             controller: priceController,
//             scrollPadding: const EdgeInsets.only(bottom: 30),
//             obscureText: false,
//             keyboardType: TextInputType.datetime,
//             decoration: InputDecoration(
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Text('AED',style: TextStyle(fontSize: 18,color: mainColor),)
//               ),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//               ),
//               hintText: 'Enter Amount',
//               hintStyle: TextStyle(fontSize: 12)
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: TextField(
//             controller: dateController,
//             scrollPadding: const EdgeInsets.only(bottom: 30),
//             obscureText: false,
//             keyboardType: TextInputType.text,
//             inputFormatters: [dateformatter],
//             decoration: InputDecoration(
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(Icons.calendar_today,color: mainColor,)
//               ),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//               ),
//               hintText: 'Enter Date Of Send (e.g: 01/01/2023)',
//               hintStyle: TextStyle(fontSize: 12)
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: TextField(
//             controller: timeController,
//             scrollPadding: const EdgeInsets.only(bottom: 30),
//             obscureText: false,
//             keyboardType: TextInputType.text,
//             inputFormatters: [timeformatter],
//             decoration: InputDecoration(
//               prefixIcon:  Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(Icons.access_time,color: mainColor,)
//               ),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//               ),
//               hintText: 'Enter Time Of Send (e.g: 01:00 Or 13:00)',
//               hintStyle: TextStyle(fontSize: 12)
//             ),
//           ),
//         ),
//         Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: LargeButton(
//                         title: 'Send',
//                         onPressed: () {
//                           final bool isFormValid =
//                               Validators.emptyStringValidator(
//                                           fromController.text, '') ==
//                                       null &&
//                                   Validators.emptyStringValidator(
//                                           tocontroller.text, '') ==
//                                       null;
//                           if (isFormValid) {
//                             String location = 'LOCATIONFrom:' +
//                                 fromController.text +
//                                 '/LOCATIONTo:' +
//                                 tocontroller.text;
//                             onSendMessage(location, TypeMessage.bill);
//                             Navigator.pop(context);
//                           }
//                         },
//                       ),)
//       ],
//     );
//   }
// }
