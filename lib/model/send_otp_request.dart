// models/send_otp_request.dart
class SendOtpRequest {
  final String phone;

  SendOtpRequest({required this.phone});

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {"phone": phone},
      },
    };
  }
}
