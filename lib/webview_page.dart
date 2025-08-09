import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webview_controller.dart';

class WebviewPage extends StatefulWidget {
  final String intitUrl;
  const WebviewPage({required this.intitUrl, super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebviewPageController _controller;
  late final WebViewController _viewController;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<WebviewPageController>();
    _viewController = _controller.webViewController;

    // Make sure to load the correct intitUrl
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewController.loadRequest(Uri.parse(widget.intitUrl));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // WebView fills the whole screen
            WebViewWidget(controller: _viewController),

            // Bottom navigation bar, animates in/out
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                left: 0,
                right: 0,
                bottom: _controller.showBottomBar.value ? 0 : -70,
                child: SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    color: Colors.black.withValues(alpha: 0.88),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          tooltip: 'Back',
                          onPressed: () async {
                            if (await _viewController.canGoBack()) {
                              _viewController.goBack();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          tooltip: 'Reload',
                          onPressed: () {
                            _viewController.reload();
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          tooltip: 'Forward',
                          onPressed: () async {
                            if (await _viewController.canGoForward()) {
                              _viewController.goForward();
                            }
                          },
                        ),

                        //Show loading...
                        _controller.isLoading.value
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    value: _controller.progress.value / 100,
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // FloatingActionButton to toggle the bar
            Positioned(
              bottom: 90,
              right: 16,
              child: Obx(
                () => FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.black87,
                  child: Icon(
                    _controller.showBottomBar.value
                        ? Icons.unfold_less
                        : Icons.unfold_more,
                    color: Colors.white,
                  ),
                  onPressed: () => _controller.showBottomBar.toggle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
