import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kt78/webview_controller.dart';
import 'package:kt78/webview_page.dart';

void main() {
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
      home: WebviewPage(initialUrl: 'https://konohatoto78lintas.com/'),
    );
  }
}
