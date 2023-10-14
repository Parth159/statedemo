import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:statedemo/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Screen1(),
    );
  }
}

class Screen1 extends StatelessWidget {
  Screen1({super.key});

  final controller = Get.put(TestController());
  final time = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        time.value = DateTime.now();
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOU Demo API Call"),
        centerTitle: true,
        actions: [
          Obx(
            () => Text(DateFormat("dd MM, yyyy hh:mm a").format(time.value))
                .paddingSymmetric(horizontal: 10),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  itemCount: controller.data.value.entries?.length,
                  itemBuilder: (context, index) {
                    final item = controller.data.value.entries?[index];
                    return ListTile(
                      tileColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text("${index + 1}.${item?.aPI ?? "NA"}"),
                      subtitle: Text(
                        "${item?.description ?? "NA"}\n${item?.link ?? "NA"}",
                        maxLines: null,
                      ),
                      isThreeLine: true,
                    ).paddingOnly(bottom: 5);
                  },
                ),
        ),
      ),
    );
  }
}
