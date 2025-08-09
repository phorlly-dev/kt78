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
    runScript();
    progress.value = p;
    isLoading.value = p < 100;
  }

  void onPageStarted(String url) {
    runScript();
    isLoading.value = true;
  }

  void onPageFinished(String url) {
    // Hide top banner by class or id
    runScript();
    isLoading.value = false;
  }

  Future<void> runScript() async {
    await webViewController.runJavaScript('''
    // Hide specific elements
    var modal = document.querySelector('.modal-show');
    if (modal) modal.remove();

    var banner = document.getElementById('top-banner');
    if (banner) banner.style.display = 'none';

    // Hide all matching a class
    document.querySelectorAll('a,.owl-carousel,.buttonWrap,.list-menu-mobile,.slideshow-container,.page-header,marquee,.bungkus-jackpot,.slider-olx,.buttoncontact,main,footer')
      .forEach(function(el) { el.style.display = 'none';});
  ''');
  }
}
