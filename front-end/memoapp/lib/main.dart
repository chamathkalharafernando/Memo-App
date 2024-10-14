import 'package:flutter/material.dart';
import 'package:memoapp/pages/home_page.dart';
import 'utilities/theme.dart';
import 'package:get/get.dart';
import 'utilities/dependencies.dart' as dependencies;
import 'utilities/routes.dart' as routes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Memo App',
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: dependencies.InitialBindings(),
      getPages: routes.getPages,
      home: const HomePage(),
    );
  }
}
