class VerifyOtpRequest {
  final String phone;
  final int otp;
  final Map<String, dynamic> deviceMeta;

  VerifyOtpRequest({
    required this.phone,
    required this.otp,
    required this.deviceMeta,
  });

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {"phone": phone, "otp": otp, "device_meta": deviceMeta},
      },
    };
  }
}
