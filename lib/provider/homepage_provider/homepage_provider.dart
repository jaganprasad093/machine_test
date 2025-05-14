import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:japx/japx.dart';
import 'package:machine_test/core/config/base_url.dart';
import 'package:machine_test/core/constants/log_constanst.dart';
import 'package:machine_test/model/CustomerProfileModel.dart';

class HomepageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;
  List<CustomerProfile> profiles = [];

  final Dio dio = Dio(BaseOptions(baseUrl: BaseUrl.baseUrl));

  Future<void> getProfile() async {
    final url = '/chat/chat-messages/queries/contact-users';

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      logDebug("Fetching chat profiles...");

      final response = await dio.get(url);
      logDebug("Raw response: ${response.statusCode}");

      dynamic responseData = response.data;

      if (responseData is String) {
        responseData = jsonDecode(responseData) as Map<String, dynamic>;
      }

      final Map<String, dynamic> parsed =
          (responseData is Map &&
                  responseData.containsKey('data') &&
                  responseData.containsKey('included'))
              ? Japx.decode(responseData as Map<String, dynamic>)
              : responseData as Map<String, dynamic>;

      logDebug("Processed response: $parsed");

      final List<dynamic> dataList =
          (parsed['data'] is List) ? parsed['data'] as List<dynamic> : [];

      profiles =
          dataList
              .map(
                (item) =>
                    CustomerProfile.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      isSuccess = true;
      logDebug(
        "Profiles parsed successfully. Found ${profiles.length} profiles",
      );
    } catch (e, stackTrace) {
      errorMessage = 'Error fetching profiles: $e';
      isSuccess = false;
      logDebug('$errorMessage\nStack trace: $stackTrace');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
