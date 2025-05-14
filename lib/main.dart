import 'package:flutter/material.dart';
import 'package:machine_test/core/config/app_router.dart';
import 'package:machine_test/provider/auth_provider/auth_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MachineTest());
}

class MachineTest extends StatelessWidget {
  const MachineTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
