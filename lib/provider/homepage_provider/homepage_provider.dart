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

      logDebug("Raw response: ${response.data}");

      // Decode using Japx
      final parsed = Japx.decode(response.data);
      logDebug("Japx decoded response: $parsed");

      final List<dynamic> dataList = parsed['data'] ?? [];

      profiles =
          dataList.map((item) => CustomerProfile.fromJson(item)).toList();

      isSuccess = true;
      logDebug("Profiles parsed successfully. Count: ${profiles.length}");
    } catch (e) {
      errorMessage = 'Error fetching profiles: $e';
      isSuccess = false;
      logDebug(errorMessage!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
