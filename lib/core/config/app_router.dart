import 'package:go_router/go_router.dart';
import 'package:machine_test/view/auth/otp_page.dart';
import 'package:machine_test/view/auth/phoneNo.dart';
import 'package:machine_test/view/auth/signin.dart';
import 'package:machine_test/view/home/chat_screen.dart';
import 'package:machine_test/view/home/homepage.dart';
import 'package:machine_test/view/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/signin', builder: (context, state) => SignIn()),
    GoRoute(path: '/phone', builder: (context, state) => PhoneNo()),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final params = state.extra as String;
        return OtpPage(phoneNo: params);
      },
    ),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/chatscreen', builder: (context, state) => ChatScreen()),
  ],
);
