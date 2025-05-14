import 'dart:convert';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:machine_test/core/constants/log_constanst.dart';
import 'package:machine_test/model/send_otp_request.dart';
import 'package:machine_test/model/verify_otp_request.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  bool isSucess = false;
  String? errorMessage;

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://test.myfliqapp.com/api/v1",
      headers: {'Content-Type': 'application/json'},
      followRedirects: true,
      maxRedirects: 5,
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  Future<void> sendOtp(SendOtpRequest request, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await dio.post(
        '/auth/registration-otp-codes/actions/phone/send-otp',
        data: request.toJson(),
        options: Options(headers: headers),
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
      final formattedPhone =
          request.phone.startsWith('+') ? request.phone : "+91${request.phone}";

      final updatedRequest = VerifyOtpRequest(
        phone: formattedPhone,
        otp: request.otp,
        deviceMeta: request.deviceMeta,
      );

      logDebug("Sending verified request: ${updatedRequest.toJson()}");

      final response = await dio.post(
        '/auth/registration-otp-codes/actions/phone/verify-otp',
        data: updatedRequest.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      logDebug("Full server response: ${response.data}");
      logDebug("status code : ${response.statusCode}");

      if (response.statusCode == 302) {}

      handleVerifyResponse(response, context);
    } on DioException catch (e) {
      final errors = e.response?.data['errors'] ?? {};
      errorMessage =
          errors['phone']?.join(', ') ??
          e.response?.data['message'] ??
          'Verification failed';
      logDebug("Server validation errors: $errors");
      context.go("/home");
    } catch (e) {
      errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void handleVerifyResponse(Response response, BuildContext context) {
    try {
      final responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSucess = true;
        errorMessage = null;
        context.go("/home");
      } else {
        errorMessage =
            responseData['error']?.toString() ??
            responseData['message']?.toString() ??
            'Verification failed';
      }
    } catch (e) {
      errorMessage = 'Failed to process response: $e';
    }
  }
}
