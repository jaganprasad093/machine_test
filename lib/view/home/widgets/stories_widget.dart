import 'package:flutter/material.dart';
import 'package:machine_test/core/componets/customtext.dart';
import 'package:machine_test/core/componets/size_constants.dart';
import 'package:machine_test/core/constants/color_constants.dart';

class StoriesWidget extends StatefulWidget {
  const StoriesWidget({super.key});

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConstants.height(context) * .1,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.pinkColor,
                  ),
                  height: 60,
                  width: 60,
                ),
                CustomText(
                  data: "name",
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.primaryBlack.withValues(alpha: .8),
                  ),
                ),
              ],
            ),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 10),
      ),
    );
  }
}
