import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:machine_test/core/componets/CustomTextformField.dart';
import 'package:machine_test/core/componets/customtext.dart';
import 'package:machine_test/core/constants/color_constants.dart';
import 'package:machine_test/core/constants/size_constants.dart';
import 'package:machine_test/provider/homepage_provider/homepage_provider.dart';
import 'package:machine_test/view/home/widgets/stories_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search_controller = TextEditingController();
  @override
  void initState() {
    context.read<HomepageProvider>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: CustomText(
          data: "Messages",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: ColorConstants.primaryWhite,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(8), child: StoriesWidget()),
          SizedBox(height: SizeConstants.height(context) * .01),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConstants.width(context) * .06,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: search_controller,
                  hintText: "Search",
                  suffixIcon: Icon(
                    Icons.search,
                    color: ColorConstants.primaryBlack.withValues(alpha: .5),
                  ),
                ),
                SizedBox(height: SizeConstants.height(context) * .03),
                CustomText(
                  data: "Chat",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: SizeConstants.height(context) * .01),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder:
                      (context, index) => InkWell(
                        onTap: () {
                          context.read<HomepageProvider>().getProfile();
                          context.push("/chatscreen");
                        },
                        child: _buildChats(),
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1200",
              ),
            ),
            SizedBox(width: 10),
            CustomText(
              data: "Name",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ],
        ),
        CustomText(
          data: "6:10 PM",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: ColorConstants.primaryBlack.withValues(alpha: .8),
          ),
        ),
      ],
    );
  }
}
