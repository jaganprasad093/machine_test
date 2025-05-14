import 'dart:convert';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:japx/japx.dart';

import 'package:machine_test/core/config/base_url.dart';
import 'package:machine_test/core/constants/log_constanst.dart';
import 'package:machine_test/model/send_otp_request.dart';
import 'package:machine_test/model/verify_otp_request.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  bool isSucess = false;
  String? errorMessage;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: BaseUrl.baseUrl,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<void> sendOtp(SendOtpRequest request, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // logDebug("Sending OTP...");

      final response = await dio.post(
        '/auth/registration-otp-codes/actions/phone/send-otp',
        data: request.toJson(),
      );

      logDebug("Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final otp = responseData['data'];

        isSucess = true;
        errorMessage = null;
        notifyListeners();

        context.push("/otp", extra: request.phone);

        CherryToast.success(
          autoDismiss: true,
          animationType: AnimationType.fromRight,
          animationDuration: const Duration(milliseconds: 1000),
          title: const Text(
            "Success",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          action: Text(
            "Your otp is $otp",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ).show(context);
      } else {
        isSucess = false;
        errorMessage = response.data['error'] ?? 'Something went wrong';
      }
    } catch (e) {
      isSucess = false;
      errorMessage = 'Failed to connect: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // verify otp
  Future<void> verifyOtp(VerifyOtpRequest request, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      logDebug("Verifying OTP: ${request}");

      final response = await dio.post(
        '/auth/registration-otp-codes/actions/phone/verify-otp',
        data: request.toJson(),
      );

      logDebug("Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSucess = true;
        errorMessage = null;
        context.go("/home");
      } else {
        errorMessage = response.data['error'] ?? 'Verification failed';
        logDebug("OTP verify failed: $errorMessage");
      }
    } catch (e) {
      // Log the error with full details
      if (e is DioException) {
        logDebug("DioException caught: ${e.message}");
        logDebug("Response: ${e.response?.data}");
      } else {
        logDebug("Error: $e");
      }
      errorMessage = 'Failed to verify OTP: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
