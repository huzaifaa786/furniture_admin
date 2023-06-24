// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class BugCard extends StatelessWidget {
  const BugCard({super.key, this.ontap});
  final ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8,left: 1,right: 1),
        child: Container(
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3)),
            ],
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/bugimg.png'),
                height: 80,
                width: 70,
              ),
              Container(
                  padding: EdgeInsets.only(left: 8),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer quis auctor nisl. Read More',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
