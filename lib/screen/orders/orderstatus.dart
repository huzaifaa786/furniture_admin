// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../static/topbar.dart';
// import '../../values/colors.dart';

// class OrderStatusScreen extends StatefulWidget {
//   const OrderStatusScreen({super.key});

//   @override
//   State<OrderStatusScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<OrderStatusScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Container(
//         padding: EdgeInsetsDirectional.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TopBar(
//               text: 'Notification',
//               ontap: () {},
//             ),
//             Column(
//               children: [
//                 SvgPicture.asset(
//                   'assets/images/orderstatus.svg',
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 10),
//                     child: Text(
//                       'Your order has been confirmed.',
//                       textAlign: TextAlign.center,
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: mainColor.withOpacity(0.1),
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 25),
//                     child: Text(
//                       '#Ord68292',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 25),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Amount',
//                           style: TextStyle(
//                               color: mainColor,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           '300 AED',
//                           style: TextStyle(
//                               fontSize: 19, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
