import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:machine_test/core/componets/CustomButton.dart';
import 'package:machine_test/core/componets/customtext.dart';
import 'package:machine_test/core/constants/color_constants.dart';
import 'package:machine_test/core/constants/log_constanst.dart';
import 'package:machine_test/core/constants/size_constants.dart';
import 'package:machine_test/model/verify_otp_request.dart';
import 'package:machine_test/provider/auth_provider/auth_controller.dart';
import 'package:machine_test/view/widget/back_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  final String phoneNo;
  const OtpPage({super.key, required this.phoneNo});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otp_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhite,
      appBar: AppBar(
        leading: Backbutton(),
        backgroundColor: ColorConstants.primaryWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(context) * .07,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  textAlign: TextAlign.center,
                  data: "Enter your verification \ncode",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
                ),
              ),
              SizedBox(height: SizeConstants.height(context) * .04),
              RichText(
                text: TextSpan(
                  text: '${widget.phoneNo}' + '.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'Edit',
                      style: TextStyle(
                        fontSize: 13,
                        // decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConstants.height(context) * .02),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                controller: otp_controller,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 45,

                  fieldWidth: 45,
                  activeFillColor: ColorConstants.primaryWhite,
                  disabledColor: ColorConstants.primaryWhite,
                  activeColor: Colors.black.withValues(alpha: .5),
                  selectedColor: Colors.black.withValues(alpha: .5),
                  selectedFillColor: ColorConstants.primaryWhite,
                  inactiveFillColor: ColorConstants.primaryWhite,
                  inactiveColor: Colors.black.withValues(alpha: .3),
                  // borderWidth: 1,
                  borderWidth: .5,
                  disabledBorderWidth: .5,
                  activeBorderWidth: .5,
                  errorBorderWidth: .5,
                  inactiveBorderWidth: .5,
                  selectedBorderWidth: .5,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (v) {
                  // print("Completed: $v");
                },
                onChanged: (value) {
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              SizedBox(height: SizeConstants.height(context) * .01),
              RichText(
                text: TextSpan(
                  text: "Didn’t get anything? No worries, let’s try again.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: '\nResend',
                      style: TextStyle(
                        fontSize: 13,
                        // decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConstants.height(context) * .5),
              CustomButton(
                text: "NEXT",
                onTap: () async {
                  logDebug("enters otp --${otp_controller.text}");

                  final otp = otp_controller.text.trim();

                  if (otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid 6-digit OTP"),
                      ),
                    );
                    return;
                  }

                  final request = VerifyOtpRequest(
                    phone: widget.phoneNo.replaceFirst('+91', ''),
                    otp: int.parse(otp_controller.text),
                    deviceMeta: DeviceMeta(
                      type: "web",
                      name: "HP Pavilion 14-EP0068TU",
                      os: "Linux x86_64",
                      browser: "Mozilla Firefox Snap for Ubuntu (64-bit)",
                      browserVersion: "112.0.2",
                      userAgent:
                          "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0",
                      screenResolution: "1600x900",
                      language: "en-GB",
                    ),
                  );

                  await authProvider.verifyOtp(request, context);

                  // if () {
                  //   // context.push("/home");
                  // } else {
                  //   logDebug(
                  //     "OTP verification failed: ${authProvider.errorMessage}",
                  //   );
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(f hgvoyf69ut
                  //         authProvider.errorMessage ?? "Something went wrong",
                  //       ),
                  //     ),
                  //   );
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
