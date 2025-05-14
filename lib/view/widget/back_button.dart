import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:machine_test/core/constants/color_constants.dart';

class Backbutton extends StatefulWidget {
  const Backbutton({super.key});

  @override
  State<Backbutton> createState() => _BackbuttonState();
}

class _BackbuttonState extends State<Backbutton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 60,
      padding: EdgeInsets.zero,
      // color: ColorConstants.pinkColor,
      icon: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_back,
          size: 15,
          color: ColorConstants.primaryBlack,
        ),
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
