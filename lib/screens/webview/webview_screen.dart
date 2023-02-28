import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:qrf/controllers/webview_controller.dart';
import 'package:qrf/utils/load_web_view.dart';

class WebViewScreen extends GetView<webviewController> {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadWebView(controller.url.value, true);
  }
}
