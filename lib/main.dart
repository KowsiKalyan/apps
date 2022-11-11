import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/detail_screen.dart';
import 'package:payment_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // TODO:if you need manual mathod uncomment home
        //home: const DetailScreen()
        home: const HomeScreen());
  }
}
