import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPageController extends GetxController {
  late final WebViewController webViewController;

  var isLoading = true.obs;
  var progress = 0.obs;
  var showBottomBar = true.obs;

  @override
  void onInit() {
    super.onInit();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: onProgress,
          onPageStarted: onPageStarted,
          onPageFinished: onPageFinished,
          onNavigationRequest: (NavigationRequest request) {
            // Example: block YouTube
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://konohatoto78lintas.com'));
  }

  void onProgress(int p) {
    progress.value = p;
    isLoading.value = p < 100;
  }

  void onPageStarted(String url) {
    isLoading.value = true;
  }

  void onPageFinished(String url) {
    isLoading.value = false;
  }
}
