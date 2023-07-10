import 'package:flutter/material.dart';
import 'package:furniture_admin/values/colors.dart';
import '../../static/large_button.dart';

class MessageViewScreen extends StatefulWidget {
  const MessageViewScreen({super.key});

  @override
  State<MessageViewScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MessageViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginback.png'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: mainColor, width: 2.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 100),
                child: Text(
                  'Mingo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                border: Border.all(color: Colors.grey)),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment(-0.7, -0.8),
              child: Center(
                  child: Icon(
                Icons.more_vert,
                size: 20,
                color: Colors.black,
              )),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  border: Border.all(color: Colors.grey.shade300, width: 2.0)),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text('Today'),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  //bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                            ),
                            padding: EdgeInsets.all(20),
                            //color: mainColor,
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                            ),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                // color: mainColor.withOpacity(0.1),
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  //  bottomLeft: Radius.circular(10.0)
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              constraints: const BoxConstraints(
                                maxWidth: 200,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Please Send your location",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      "From :",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "TO :",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDataAlert();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '3:10 PM',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                // color: mainColor.withOpacity(0.1),
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  //  bottomLeft: Radius.circular(10.0)
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              constraints: const BoxConstraints(
                                maxWidth: 250,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Please take photos and videos from your luggage bill",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '1 Table',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      '3 Chairs',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(children: [
                                      Text("Date of Send:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                      Text(
                                        "03/03/23:",
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(children: [
                                      Text("Time:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                      Text(
                                        "08:00",
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(children: [
                                      Text("Amount:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                      Text(
                                        "300 AED:",
                                      )
                                    ]),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        ),
                                        Container(
                                            height: 20,
                                            child: Image.asset(
                                                'assets/images/apple.png')),
                                        Text(
                                          'Apply Pay',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                height: 15,
                                                child: Image.asset(
                                                    'assets/images/google.png')),
                                            Text(
                                              'Pay',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Google Pay',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 15),
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                        ),
                                        Container(
                                            height: 20,
                                            child: Image.asset(
                                                'assets/images/visa.png')),
                                        Text(
                                          'Credit/Debit Card',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  LargeButton(
                                      title: 'Checkout', onPressed: () {}),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  scrollPadding: EdgeInsets.only(bottom: 30),
                  obscureText: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'Your message',
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            content: Container(
              height: 250,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        scrollPadding: EdgeInsets.only(bottom: 30),
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/images/location.png',
                              width: 1,
                              height: 1,
                              fit: BoxFit.fill,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'FROM',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        scrollPadding: EdgeInsets.only(bottom: 30),
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/images/location.png',
                              width: 1,
                              height: 1,
                              fit: BoxFit.fill,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'TO',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LargeButton(title: 'Checkout', onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
