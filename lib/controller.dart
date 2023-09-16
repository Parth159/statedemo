import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:statedemo/model.dart';

class TestController extends GetxController {
  final data = UserModel().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    isLoading.value = true;
    final responce = await Dio().get("https://api.publicapis.org/entries");
    data.value = UserModel.fromJson(responce.data);
    update();
    isLoading.value = false;
  }
}
