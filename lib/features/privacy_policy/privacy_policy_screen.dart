import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../helpers/navigation_service.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isLoading = true;
  bool hasError = false;

  late final WebViewController controller;

  final String url = "https://a-inspect.com/privacy-policy";

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setBackgroundColor(Colors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (_) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (_) {
            setState(() {
              hasError = true;
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextFontStyle.headLine16c141414InterW400.copyWith(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2D8D7C),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            NavigationService.goBack;
          },
        ),
      ),
      body: Stack(
        children: [
          Container(color: Colors.white),
          if (!hasError)
            Offstage(
              offstage: isLoading,
              child: WebViewWidget(controller: controller),
            ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF2D8D7C)),
            ),
          if (hasError)
            const Center(
              child: Text(
                "Failed to load Privacy Policy",
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
