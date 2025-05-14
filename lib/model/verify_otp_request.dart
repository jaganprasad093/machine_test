class VerifyOtpRequest {
  final String phone;
  final int otp;
  final DeviceMeta deviceMeta;

  VerifyOtpRequest({
    required this.phone,
    required this.otp,
    required this.deviceMeta,
  });

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": phone,
          "otp": otp,
          "device_meta": deviceMeta.toJson(),
        },
      },
    };
  }
}

class DeviceMeta {
  final String type;
  final String name;
  final String os;
  final String browser;
  final String browserVersion;
  final String userAgent;
  final String screenResolution;
  final String language;

  DeviceMeta({
    required this.type,
    required this.name,
    required this.os,
    required this.browser,
    required this.browserVersion,
    required this.userAgent,
    required this.screenResolution,
    required this.language,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "name": name,
      "os": os,
      "browser": browser,
      "browser_version": browserVersion,
      "user_agent": userAgent,
      "screen_resolution": screenResolution,
      "language": language,
    };
  }
}
