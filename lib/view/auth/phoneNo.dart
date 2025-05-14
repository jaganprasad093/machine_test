import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:machine_test/core/componets/CustomButton.dart';
import 'package:machine_test/core/componets/CustomTextformField.dart';
import 'package:machine_test/core/componets/customtext.dart';
import 'package:machine_test/core/constants/color_constants.dart';
import 'package:machine_test/core/constants/log_constanst.dart';
import 'package:machine_test/core/constants/size_constants.dart';
import 'package:machine_test/model/send_otp_request.dart';
import 'package:machine_test/provider/auth_provider/auth_controller.dart';
import 'package:machine_test/view/widget/back_button.dart';
import 'package:provider/provider.dart';

class PhoneNo extends StatefulWidget {
  const PhoneNo({super.key});

  @override
  State<PhoneNo> createState() => _PhoneNoState();
}

class _PhoneNoState extends State<PhoneNo> {
  TextEditingController phone_controller = TextEditingController();
  @override
  void initState() {
    if (kDebugMode) {
      phone_controller.text = '8080808080';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      // backgroundColor: ColorConstants.primaryWhite,
      appBar: AppBar(leading: Backbutton()),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.width(context) * .04,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  textAlign: TextAlign.center,
                  data: "Enter your phone \nnumber",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
                ),
              ),
              SizedBox(height: SizeConstants.height(context) * .03),
              CustomTextField(
                maxLength: 10,
                controller: phone_controller,
                // enabled: login_controller.profileCompletionPercentage == "100"
                //     ? false
                //     : true,
                hintText: "Enter phone",
                keyboardType: TextInputType.number,
                prefix: Text(
                  "   +91 ",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the phone number';
                  }
                  RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                  if (!regex.hasMatch(phone_controller.text)) {
                    return "Enter a valid phone number";
                  }

                  return null;
                },
              ),
              SizedBox(height: SizeConstants.height(context) * .01),
              CustomText(
                textAlign: TextAlign.center,
                data: "Fliq will send you a text with a verification code.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: ColorConstants.primaryBlack.withValues(alpha: .5),
                ),
              ),
              SizedBox(height: SizeConstants.height(context) * .57),
              CustomButton(
                // text: "NEXT",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    logDebug("Form validated");
                    final fullPhone = "+91${phone_controller.text}";
                    authProvider.sendOtp(
                      SendOtpRequest(phone: fullPhone),
                      context,
                    );
                  }
                  // if (authProvider.isSucess) {
                  //   context.go("/home");
                  // }
                },
                child:
                    authProvider.isLoading
                        ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 30,
                        )
                        : Text(
                          "NEXT",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
