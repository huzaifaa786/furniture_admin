// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/chat/chat_page.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class ChatLsitScreen extends StatelessWidget {
  const ChatLsitScreen({super.key});

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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final messagesSnapshot = snapshot.data;
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: fetchUserData(messagesSnapshot!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              final usersData = snapshot.data;
                              return ListView.builder(
                                itemCount: usersData!.length,
                                itemBuilder: (context, index) {
                                  final userData = usersData[index];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 8, bottom: 2),
                                    child: Container(
                                      height: 97,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(38),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x21000000),
                                            blurRadius: 28,
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                              Text(
                                                userData['name'],
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left:4.0),
                                                child: badges.Badge(
                                                  showBadge: userData['seen'] == true ? false: true,
                                                ),
                                              )
                                            ],
                                          ),
                                          subtitle: Text(
                                            'Company Name: ' +
                                                userData['companyName'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontFamily: 'Mazzard',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          trailing: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            size: 30,
                                          ),
                                          onTap: () {
                                            Get.to(() => ChatPage(
                                                arguments: ChatPageArguments(
                                                    peerId: userData['id'],
                                                    peerAvatar: 'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
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
                                },
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//////////////.//// Fetch the User's list with company data with whom he is catting /////////////////

  Future<List<Map<String, dynamic>>> fetchUserData(
      QuerySnapshot messagesSnapshot) async {
    List<Map<String, dynamic>> userDataWithID = [];

    for (var document in messagesSnapshot.docs) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(document['userId'])
          .get();
      DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
          .collection('companies')
          .doc(document['companyId'])
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> companyData =
            companySnapshot.data() as Map<String, dynamic>;
        userData['companyId'] = document['companyId'];
        userData['companyName'] = companyData['name'];
        userData['seen'] = document['companySeen'];
        userDataWithID.add(userData);
      }
    }
    return userDataWithID;
  }
}
