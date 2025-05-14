import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:machine_test/core/componets/customtext.dart';
import 'package:machine_test/core/componets/size_constants.dart';
import 'package:machine_test/core/constants/color_constants.dart';
import 'package:machine_test/core/constants/image_constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(context) * .06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConstants.height(context) * .1),
              SizedBox(
                height: SizeConstants.height(context) * .06,
                child: Image.asset(ImageConstants.icon),
              ),

              Center(
                child: CustomText(
                  data: 'Connect. Meet. Love.\nWith Fliq Dating',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: SizeConstants.height(context) * .31),
              _buildButton(
                Colors.white,
                "Sign in with Google",
                ImageConstants.google,
              ),
              SizedBox(height: SizeConstants.width(context) * .05),

              _buildButton(
                Color(0xff3B5998),
                "Sign in with Facebook",
                ImageConstants.facebook,
              ),
              SizedBox(height: SizeConstants.width(context) * .05),
              InkWell(
                onTap: () {
                  context.push("/phone");
                },
                child: _buildButton(
                  ColorConstants.pinkColor,
                  "Sign in with phone number",
                  ImageConstants.phone,
                ),
              ),
              SizedBox(height: SizeConstants.width(context) * .1),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'By signing up, you agree to our ',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),

                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: '. See how we use your data in our ',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Color color, String text, String image) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              // "imagecon",
              height: 20,
              width: 20,
            ),
            SizedBox(width: SizeConstants.width(context) * .01),
            CustomText(
              data: text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color:
                    color == Colors.white
                        ? ColorConstants.primaryBlack
                        : ColorConstants.primaryWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
