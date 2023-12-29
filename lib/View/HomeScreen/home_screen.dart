import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_video_player_app/View/HomeScreen/Controller/home_controller.dart';
import 'package:simple_video_player_app/View/ViddeScreen/video_play_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _homeController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trending Videos',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A202C)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo is ScrollEndNotification &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _homeController.fetchMoreData();
                          }
                          return false;
                        },
                        child: ListView.builder(
                            itemCount: _homeController.allList.length + 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < _homeController.allList.length) {
                                var resultData = _homeController.allList[index];
                                return Container(
                                  width: 346.w,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(VideoPlayScreen(
                                            videoUrl: resultData.manifest,
                                            title: resultData.title,
                                            viewers:
                                                resultData.viewers.toString(),
                                          ));
                                        },
                                        child: Container(
                                          width: 346.w,
                                          height: 196.h,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      resultData.thumbnail))),
                                        ),
                                      ),
                                      Text(
                                        resultData.title,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF1A202C)),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
