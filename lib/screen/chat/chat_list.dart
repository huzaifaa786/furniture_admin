// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/screen/chat/chat_page.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:shimmer/shimmer.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              TopBar(
                ontap: () {
                  Get.back();
                },
                text: 'Chatting',
              ),
              Flexible(
                child: FirestorePagination(
                  limit: 6, // Number of items to fetch per page
                  isLive: true,
                  viewType: ViewType.list,
                  bottomLoader: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.blue,
                    ),
                  ),
                  query: FirebaseFirestore.instance
                      .collection('messages')
                      .orderBy('timestamp', descending: true),
                  itemBuilder: (context, documentSnapshot, index) {
                    final userData =
                        documentSnapshot.data() as Map<String, dynamic>;
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: fetchUserData(userData),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: shimmerLoadingWidget());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          final userWithData = snapshot.data!.first;
                          return CustomChatListItem(userData: userWithData);
                        } else {
                          return SizedBox(); // Return an empty SizedBox if no user data is found.
                        }
                        // if (snapshot.connectionState ==
                        //     ConnectionState.waiting) {
                        //   return Center(child: shimmerLoadingWidget());
                        // } else if (snapshot.hasError) {
                        //   return Center(
                        //       child: Text('Error: ${snapshot.error}'));
                        // } else {
                        //   final userWithData = snapshot.data?.first;
                        //   return userWithData != null
                        //       ? CustomChatListItem(userData: userWithData)
                        //       : SizedBox(); // Return an empty SizedBox if no user data is found.
                        // }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerLoadingWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
        ),
        height: 100.0,
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchUserData(
      Map<String, dynamic> userData) async {
    final userId = userData['userId'];
    final companyId = userData['companyId'];

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
        .collection('companies')
        .doc(companyId)
        .get();

    if (userSnapshot.exists && companySnapshot.exists) {
      final userMap = userSnapshot.data() as Map<String, dynamic>;
      final companyMap = companySnapshot.data() as Map<String, dynamic>;

      userMap['companyId'] = companyId;
      userMap['companyName'] = companyMap['name'];
      userMap['seen'] = userData['companySeen'];
      print(userMap);
      return [userMap];
    } else {
      return [];
    }
  }
}

class CustomChatListItem extends StatelessWidget {
  final Map<String, dynamic> userData;

  CustomChatListItem({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 2, right: 2, left: 2),
      child: Container(
        height: 97,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
          shadows: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 8,
              offset: Offset(2, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: ListTile(
            leading: SizedBox(
              height: 55,
              width: 59,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: mainColor,
                  child: SvgPicture.asset(
                    'assets/images/profile.svg', // fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.38),
                  child: Text(
                    userData['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: badges.Badge(
                    showBadge: userData['seen'] == true ? false : true,
                  ),
                )
              ],
            ),
            subtitle: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.38),
              child: Text(
                'Company Name: ' + userData['companyName'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontFamily: 'Mazzard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_circle_right_outlined,
              size: 30,
            ),
            onTap: () {
              Get.to(
                () => ChatPage(
                  arguments: ChatPageArguments(
                    peerId: userData['id'],
                    peerAvatar:
                        'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
                    peerNickname: userData['name'],
                    currentId: userData['companyId'],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
