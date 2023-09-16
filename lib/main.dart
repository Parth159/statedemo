import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOU Demo API Call"),
        centerTitle: true,
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
