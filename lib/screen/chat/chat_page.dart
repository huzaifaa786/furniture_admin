// ignore_for_file: prefer_final_fields, sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, prefer_is_empty, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_admin/screen/chat/constants.dart';
import 'package:furniture_admin/screen/chat/full_photo_page.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/models/models.dart';
import 'package:furniture_admin/screen/chat/controller.dart';
import 'package:furniture_admin/screen/auth/login_screen.dart';
import 'package:furniture_admin/static/large_button.dart';
import 'package:furniture_admin/values/Validator.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'widgets.dart';
// import 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.arguments});

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late final String currentUserId;

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  late final ChatProvider chatProvider = context.read<ChatProvider>();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    readLocal();
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  void readLocal() {
    if (auth.currentUser!.uid.isNotEmpty == true) {
      currentUserId = widget.arguments.currentId;
    } else {
      Get.offAll(() => const LoginScreen());
    }
    String peerId = widget.arguments.peerId;
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }
    // FirebaseFirestore.instance
    //     .collection(FirestoreConstants.pathMessageCollection)
    //     .doc(groupChatId)
    //     .update({
    //   'companySeen': true,
    // });
    final docRef = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId);

    docRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, proceed with the update
        docRef.update({'companySeen': true}).then((_) {
          print('Update successful');
        }).catchError((error) {
          print('Error updating document: $error');
        });
      } else {
        // Document does not exist, handle accordingly
        print('Document does not exist');
      }
    }).catchError((error) {
      print('Error fetching document: $error');
    });
    // chatProvider.updateDataFirestore(
    //   FirestoreConstants.Pa,
    //   currentUserId,
    //   {FirestoreConstants.chattingWith: peerId},
    // );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {
      // Fluttertoast.showToast(msg: err.toString());
      Get.snackbar('Error', err.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: white);
      return null;
    });
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }

  // void getSticker() {
  //   // Hide keyboard when sticker appear
  //   focusNode.unfocus();
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatProvider.uploadFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, TypeMessage.image);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      // Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(
          content, type, groupChatId, currentUserId, widget.arguments.peerId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == currentUserId) {
        // Right (my message)
        return Row(
          children: <Widget>[
            messageChat.type == TypeMessage.text
                // Text
                ? Container(
                    child: Text(
                      messageChat.content,
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(
                        bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                  )
                : messageChat.type == TypeMessage.image
                    // Image
                    ? Container(
                        child: OutlinedButton(
                          child: Material(
                            child: Image.network(
                              messageChat.content,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: mainColor,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, object, stackTrace) {
                                return Material(
                                  child: Image.asset(
                                    'images/img_not_available.jpeg',
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                );
                              },
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            clipBehavior: Clip.hardEdge,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullPhotoPage(
                                  url: messageChat.content,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0))),
                        ),
                        margin: EdgeInsets.only(
                            bottom: isLastMessageRight(index) ? 20 : 10,
                            right: 10),
                      )
                    // Location
                    : messageChat.type == TypeMessage.location
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From: ${RegExp(r"LOCATIONFrom:(.*?)/").firstMatch(messageChat.content)?.group(1) ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'To: ${RegExp(r"/LOCATIONTo:(.*?)$").firstMatch(messageChat.content)?.group(1) ?? ''}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            width: 200,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20 : 10,
                                right: 10),
                          )
                        // Bill

                        : Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Description:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Mazzard',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  messageChat.content
                                      .split("~~")[0]
                                      .split(":")[1]
                                      .trim(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Mazzard',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Date Of Send: ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Mazzard',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        messageChat.content
                                            .split("~~")[2]
                                            .split(":")[1]
                                            .trim(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Mazzard',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Time: ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Mazzard',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        messageChat.content
                                            .split("~~")[3]
                                            .split("-")[1]
                                            .trim(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Mazzard',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Amount: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Mazzard',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      messageChat.content
                                              .split("~~")[1]
                                              .split(":")[1]
                                              .trim() +
                                          ' AED',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Mazzard',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            width: 240,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20 : 10,
                                right: 10),
                          ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          // child: Image.network(
                          //   widget.arguments.peerAvatar,
                          //   loadingBuilder: (BuildContext context, Widget child,
                          //       ImageChunkEvent? loadingProgress) {
                          //     if (loadingProgress == null) return child;
                          //     return Center(
                          //       child: CircularProgressIndicator(
                          //         color: Colors.grey[300],
                          //         value: loadingProgress.expectedTotalBytes !=
                          //                 null
                          //             ? loadingProgress.cumulativeBytesLoaded /
                          //                 loadingProgress.expectedTotalBytes!
                          //             : null,
                          //       ),
                          //     );
                          //   },
                          //   errorBuilder: (context, object, stackTrace) {
                          //     return Icon(
                          //       Icons.account_circle,
                          //       size: 35,
                          //       color: Colors.grey[300],
                          //     );
                          //   },
                          //   width: 35,
                          //   height: 35,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Icon(
                            Icons.account_circle,
                            size: 35,
                            color: Colors.grey[300],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                        )
                      : Container(width: 35),
                  messageChat.type == TypeMessage.text
                      ? Container(
                          child: Text(
                            messageChat.content,
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(left: 10),
                        )
                      : messageChat.type == TypeMessage.image
                          ? Container(
                              child: TextButton(
                                child: Material(
                                  child: Image.network(
                                    messageChat.content,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        width: 200,
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: mainColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, object, stackTrace) =>
                                            Material(
                                      child: Image.asset(
                                        'images/img_not_available.jpeg',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullPhotoPage(
                                          url: messageChat.content),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(0))),
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          : messageChat.type == TypeMessage.location
                              ? Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From: ${RegExp(r"LOCATIONFrom:(.*?)/").firstMatch(messageChat.content)?.group(1) ?? ''}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        'To: ${RegExp(r"/LOCATIONTo:(.*?)$").firstMatch(messageChat.content)?.group(1) ?? ''}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8)),
                                  margin: EdgeInsets.only(left: 10),
                                )
                              : Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description:',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        messageChat.content
                                            .split("~~")[0]
                                            .split(":")[1]
                                            .trim(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Date Of Send: ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            messageChat.content
                                                .split("~~")[2]
                                                .split(":")[1]
                                                .trim(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Time: ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            messageChat.content
                                                .split("~~")[3]
                                                .split("-")[1]
                                                .trim(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Amount:',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            messageChat.content
                                                .split("~~")[1]
                                                .split(":")[1]
                                                .trim(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  width: 220,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8)),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      child: Text(
                        DateFormat('dd MMM kk:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageChat.timestamp))),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                      margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                    )
                  : SizedBox.shrink()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) ==
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) !=
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.arguments.peerNickname,
          style: TextStyle(color: white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  buildListMessage(),
                  // Input content
                  buildInput(),
                ],
              ),

              // Loading
              buildLoading()
            ],
          ),
          onWillPop: onBackPress,
        ),
      ),
    );
  }

  billSend(context) {
    print('called');
    TextEditingController discriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    final dateformatter =
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9/]*$'));
    final timeformatter =
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9:]*$'));

    Alert(
        context: context,
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Generate Bill'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: discriptionController,
                scrollPadding: const EdgeInsets.only(bottom: 30),
                obscureText: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Image.asset(
                    //     'assets/images/location.png',
                    //     width: 1,
                    //     height: 1,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Discription of delivery items',
                    hintStyle: TextStyle(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: priceController,
                scrollPadding: const EdgeInsets.only(bottom: 30),
                obscureText: false,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'AED',
                          style: TextStyle(fontSize: 18, color: mainColor),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: dateController,
                scrollPadding: const EdgeInsets.only(bottom: 30),
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [dateformatter],
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.calendar_today,
                          color: mainColor,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Enter Date Of Send (e.g: 01/01/2023)',
                    hintStyle: TextStyle(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: timeController,
                scrollPadding: const EdgeInsets.only(bottom: 30),
                obscureText: false,
                keyboardType: TextInputType.text,
                inputFormatters: [timeformatter],
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.access_time,
                          color: mainColor,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Enter Time Of Send (e.g: 01:00 Or 13:00)',
                    hintStyle: TextStyle(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LargeButton(
                title: 'Send',
                onPressed: () {
                  final bool isFormValid = Validators.emptyStringValidator(
                              discriptionController.text, '') ==
                          null &&
                      Validators.emptyStringValidator(
                              priceController.text, '') ==
                          null &&
                      Validators.emptyStringValidator(
                              dateController.text, '') ==
                          null &&
                      Validators.emptyStringValidator(
                              timeController.text, '') ==
                          null;
                  if (isFormValid) {
                    String bill = 'DESCRIPTION:' +
                        discriptionController.text +
                        '~~AMOUNT:' +
                        priceController.text +
                        '~~DATE:' +
                        dateController.text +
                        '~~TIME-' +
                        timeController.text;
                    onSendMessage(bill, TypeMessage.bill);
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
              height: 0, color: white, onPressed: () async {}, child: Text(''))
        ]).show();
  }
  // Widget buildSticker() {
  //   return Expanded(
  //     child: Container(
  //       child: Column(
  //         children: <Widget>[
  //           Row(
  //             children: <Widget>[
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi1', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi1.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi2', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi2.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi3', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi3.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               )
  //             ],
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           ),
  //           Row(
  //             children: <Widget>[
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi4', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi4.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi5', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi5.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi6', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi6.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               )
  //             ],
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           ),
  //           Row(
  //             children: <Widget>[
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi7', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi7.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi8', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi8.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () => onSendMessage('mimi9', TypeMessage.sticker),
  //                 child: Image.asset(
  //                   'images/mimi9.gif',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               )
  //             ],
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           )
  //         ],
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       ),
  //       decoration: BoxDecoration(
  //           border:
  //               Border(top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
  //           color: Colors.white),
  //       padding: EdgeInsets.all(5),
  //       height: 180,
  //     ),
  //   );
  // }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : SizedBox.shrink(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: mainColor,
              ),
            ),
            color: Colors.white,
          ),
          // Button Send Bill
          Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.receipt_long_outlined),
                onPressed: () {
                  billSend(context);
                },
                color: mainColor,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, TypeMessage.text);
                },
                style: TextStyle(color: Colors.black, fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                focusNode: focusNode,
                autofocus: true,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    onSendMessage(textEditingController.text, TypeMessage.text),
                color: mainColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: chatProvider.getChatStream(groupChatId, _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  } else {
                    return Center(child: Text("No message here yet..."));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            ),
    );
  }
}

class ChatPageArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;
  final String currentId;

  ChatPageArguments(
      {required this.peerId,
      required this.peerAvatar,
      required this.peerNickname,
      required this.currentId});
}
