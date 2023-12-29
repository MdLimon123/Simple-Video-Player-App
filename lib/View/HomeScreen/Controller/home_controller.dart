import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_video_player_app/ApiServices/api_services.dart';
import 'package:simple_video_player_app/View/HomeScreen/Model/video_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  late VideoModel _videoModel;
  RxList<Result> allList = <Result>[].obs;

  var page = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideo();
  }

  fetchVideo() async {
    isLoading(true);
    try {
      var result = await ApiServices.fetchVideo();

      if (result.runtimeType == int) {
        debugPrint('Video Fetch error $result');
      } else {
        _videoModel = result;
        allList.value = _videoModel.results;
        print(allList);
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchMoreData() {
    page(page.value + 1);
    fetchVideo();
  }
}
