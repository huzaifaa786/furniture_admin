// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:furniture_admin/values/colors.dart';

class StatusMethod extends StatefulWidget {
  StatusMethod(
      {Key? key,
      this.value,
      this.groupvalue,
      this.onpress,
      this.onchaged,
      this.image,
      this.title})
      : super(
          key: key,
        );
  final value;
  final onpress;
  final groupvalue;
  final onchaged;
  final image;
  final title;
  @override
  State<StatusMethod> createState() => _StatusMethodState();
}

class _StatusMethodState extends State<StatusMethod> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onchaged,
      child: Container(
        // margin: EdgeInsets.only(left: 34),
        padding: EdgeInsets.only(top: 7, bottom: 7),
        // width: MediaQuery.of(context).size.width*0.88,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                title: Transform.translate(
                  offset: Offset(-20, 0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.scale(
                          scale: 1.2,
                          child: Radio(
                              value: widget.value.toString(),
                              groupValue: widget.groupvalue.toString(),
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => mainColor),
                              onChanged: (value) {
                                widget.onchaged();
                              })),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          widget.title,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                // trailing:
                dense: true,
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
