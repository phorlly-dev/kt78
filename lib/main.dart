import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kt78/webview_controller.dart';
import 'package:kt78/webview_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // NOTE: Replace with your own app ID from https://www.onesignal.com
  OneSignal.initialize("554a089c-a5ad-4ec6-9741-1063bb2e07e5");
  OneSignal.Notifications.requestPermission(true);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WebviewPageController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KT78',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: WebviewPage(intitUrl: 'https://konohatoto78lintas.com/'),
    );
  }
}
