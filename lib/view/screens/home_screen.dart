import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controllers/getx_controller/getallapis_controller.dart';
import '../../controllers/utils/app_colors.dart';
import '../../controllers/utils/app_styles.dart';
import '../../custom_widgets/ui_components.dart';
import '../../model/getallposts_model.dart';
import 'checkin_screens/checkin_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late final GetAllApis getAllPostsController;
  final AudioPlayer audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  String formattedDate = DateFormat('E, MMM d').format(DateTime.now());
  final ScrollController _secondListController = ScrollController();
  RxInt isSelected = 0.obs;
  void playPauseAudio(String url) async {
    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      try {
        await audioPlayer.play(UrlSource(url));
      } catch (e) {
        // Handle the error here
        print('Error playing audio: $e');
      }
    }
    isPlaying.value = !isPlaying.value;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void dispose() {
    audioPlayer.dispose();
    _secondListController.dispose();
    super.dispose();
  }

  RxString name = "".obs;

  @override
  Widget build(BuildContext context) {
    final GetAllApis getAllPostsController = Get.put(GetAllApis(context));
    getAllPostsController.getAllPosts();
    log('formattedDate: $formattedDate');
    log('name: $name');
    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      position.value = Duration.zero;
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });

    var posts = getAllPostsController.getAllPost.value;

    if (posts != null && posts.data.isNotEmpty) {
      var firstPost = posts.data[0];

      if (firstPost.userId != null) {
        name.value = firstPost.userId.name;
      }
    }

    return Obx(
      () => Scaffold(
        backgroundColor: getAllPostsController.loading.value
            ? AppColors.primaryColor
            : AppColors.blackColor,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Obx(() {
                if (getAllPostsController.loading.value) {
                  return Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                        color: AppColors.blackColor, size: 10.h),
                  );
                }
                if (getAllPostsController.getAllPost.value == null ||
                    getAllPostsController.getAllPost.value!.data.isEmpty) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 16.px,
                              fontFamily: 'regular',
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hey ${name.value}!',
                            style: TextStyle(
                              fontSize: 20.px,
                              fontFamily: 'Bold',
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    getVerticalSpace(2.h),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            getAllPostsController.getAllPost.value?.data.length,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Datum datum = getAllPostsController
                              .getAllPost.value!.data[index];
                          DateTime createdAt =
                              DateTime.parse(datum.createdAt.toIso8601String());
                          String dayOfWeek = DateFormat('E').format(createdAt);
                          String dayOfMonth = DateFormat('d').format(createdAt);
                          void scrollToIndex(int index) {
                            _secondListController.animateTo(
                              index *
                                  790.0, // Adjust as needed based on item height
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }

                          if (getAllPostsController.getAllPost.value == null) {
                            return Center(
                              child: Text("No data available"),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.h),
                            child: Obx(
                              () => GestureDetector(
                                onTap: () {
                                  scrollToIndex(index);
                                  isSelected.value = index;
                                },
                                child: Container(
                                  height: 104.px,
                                  // width: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.h),
                                    color: isSelected.value == index
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.5.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          dayOfWeek,
                                          style: AppTextStyles.subtitleGrey,
                                        ),
                                        Text(
                                          dayOfMonth,
                                          style: AppTextStyles.heading1,
                                        ),
                                        getVerticalSpace(1.h),
                                        Image.network(
                                          datum.mood.path,
                                          height: 35,
                                          width: 35,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    getVerticalSpace(3.h),
                    Expanded(
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32.px),
                            topLeft: Radius.circular(32.px),
                          ),
                          color: AppColors.primaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.px),
                              color: AppColors.whiteColor,
                            ),
                            child: ListView.builder(
                              // itemCount: 1,
                              itemCount: getAllPostsController
                                  .getAllPost.value?.data.length,
                              shrinkWrap: true,
                              controller: _secondListController,
                              itemBuilder: (context, index) {
                                Datum datum = getAllPostsController
                                    .getAllPost.value!.data[index];
                                log('length 1: ${getAllPostsController.getAllPost.value?.data.length}');
                                return Padding(
                                  padding: EdgeInsets.all(2.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'your mood',
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'medium',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      getVerticalSpace(1.h),
                                      Row(
                                        children: [
                                          SizedBox(
                                              height: 28.px,
                                              width: 28.px,
                                              child: Image.network(
                                                  datum.mood.path)),
                                          getHorizentalSpace(1.h),
                                          Text(
                                            datum.mood.title,
                                            style: TextStyle(
                                              fontSize: 10.px,
                                              fontFamily: 'medium',
                                              color: AppColors.blackColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '12:47 PM',
                                            style: TextStyle(
                                              fontSize: 10.px,
                                              fontFamily: 'medium',
                                              color: Color(0xff505050),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      getVerticalSpace(1.5.h),
                                      Divider(),
                                      getVerticalSpace(1.5.h),
                                      Text(
                                        'Your Activates',
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'medium',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      getVerticalSpace(1.h),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: datum.activities.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 5.0,
                                          mainAxisSpacing: 0.0,
                                          childAspectRatio: 2 / 3,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.px),
                                            ),
                                            child: Column(
                                              children: [
                                                // SvgPicture.asset(
                                                //     eveningBad[index]),
                                                Image.network(datum
                                                    .activities[index].path),
                                                getVerticalSpace(1.h),
                                                Text(
                                                  datum.activities[index].title,
                                                  style: TextStyle(
                                                    fontSize: 9.px,
                                                    fontFamily: 'regular',
                                                    color: AppColors.blackColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      getVerticalSpace(1.5.h),
                                      Divider(),
                                      getVerticalSpace(1.5.h),
                                      Text(
                                        'Your Feelings',
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'medium',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      getVerticalSpace(1.h),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: datum.feelings.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 5.0,
                                          mainAxisSpacing: 0.0,
                                          childAspectRatio: 6 / 7,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.px),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  datum.feelings[index].path,
                                                  height: 6.h,
                                                  width: 6.h,
                                                ),
                                                getVerticalSpace(1.h),
                                                Text(
                                                  datum.feelings[index].title,
                                                  style: TextStyle(
                                                    fontSize: 9.px,
                                                    fontFamily: 'regular',
                                                    color: AppColors.blackColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      getVerticalSpace(0.5.h),
                                      Divider(),
                                      getVerticalSpace(1.5.h),
                                      Text(
                                        'Voice memo',
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'medium',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      getVerticalSpace(1.h),
                                      Obx(() {
                                        String formatDuration(Duration d) {
                                          String twoDigits(int n) =>
                                              n.toString().padLeft(2, '0');
                                          final minutes = twoDigits(
                                              d.inMinutes.remainder(60));
                                          final seconds = twoDigits(
                                              d.inSeconds.remainder(60));
                                          return '$minutes:$seconds';
                                        }

                                        return Container(
                                          height: 40.px,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40.px),
                                            color: Color(0xffF5F5F5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(6.px),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => playPauseAudio(
                                                      datum.note.path),
                                                  child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Color(0xff0E9AFF),
                                                    child: Center(
                                                      child: isPlaying.value
                                                          ? Icon(Icons.pause,
                                                              size: 20,
                                                              color:
                                                                  Colors.white)
                                                          : Icon(
                                                              Icons.play_arrow,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    'assets/svgs/waves.svg'),
                                                Spacer(),
                                                Obx(() => Text(
                                                      formatDuration(position
                                                          .value), // Update position.value here
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'regular',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      getVerticalSpace(1.5.h),
                                      Divider(),
                                      getVerticalSpace(1.5.h),
                                      Text(
                                        'Goals for tomorrow',
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'medium',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      getVerticalSpace(1.h),
                                      Text(
                                        datum.tomorrowDescription,
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'regular',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Divider(),
                                      getVerticalSpace(1.5.h),
                                      Text(
                                        'Day Description',
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'medium',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      getVerticalSpace(1.h),
                                      Text(
                                        datum.dayDescription,
                                        style: TextStyle(
                                          fontSize: 12.px,
                                          fontFamily: 'regular',
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      index ==
                                              getAllPostsController.getAllPost
                                                      .value!.data.length -
                                                  1
                                          ? getVerticalSpace(8.h)
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 70,
              right: 0,
              child: FloatingActionButton(
                backgroundColor: AppColors.blackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Get.to(() => HomePage());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    ),
                    Text(
                      'Check in',
                      style: TextStyle(
                        fontSize: 10.px,
                        fontFamily: 'medium',
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// RxBool _isFirstTime = true.obs;

// @override
// void initState() {
//   super.initState();
//   // _checkFirstTime();
// }

// Future<void> _checkFirstTime() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
//
//   if (isFirstTime) {
//     await prefs.setBool('isFirstTime', false);
//   }
//   _isFirstTime.value = isFirstTime;
// }

// RxList eveningBad = [
//   'assets/svgs/some_what_bad_svgs/layer1.svg',
//   'assets/svgs/some_what_bad_svgs/Capa_1.svg',
//   'assets/svgs/some_what_bad_svgs/Capa_1 (1).svg',
//   'assets/svgs/some_what_bad_svgs/Capa_1 (2).svg',
//   'assets/svgs/some_what_bad_svgs/Capa_1 (3).svg',
//   'assets/svgs/some_what_bad_svgs/Capa_1 (4).svg',
//   'assets/svgs/some_what_bad_svgs/flat.svg',
//   'assets/svgs/some_what_bad_svgs/flat (1).svg',
//   'assets/svgs/some_what_bad_svgs/flat (2).svg',
//   'assets/svgs/some_what_bad_svgs/Group (1).svg',
// ].obs;
//
// RxList eveningBadName = [
//   'Work',
//   'Family',
//   'Friends',
//   'School',
//   'Relation',
//   'Traveling',
//   'Food',
//   'Exercise',
//   'Health',
//   'Gaming',
// ].obs;
//
// RxList feelingsSvg = [
//   'assets/svgs/feelings_svgs/Group.svg',
//   'assets/svgs/feelings_svgs/Group (1).svg',
//   'assets/svgs/feelings_svgs/Group (3).svg',
//   'assets/svgs/feelings_svgs/Group (4).svg',
//   'assets/svgs/feelings_svgs/Group (5).svg',
//   'assets/svgs/feelings_svgs/Group (6).svg',
//   'assets/svgs/feelings_svgs/Group (8).svg',
//   'assets/svgs/feelings_svgs/Group (9).svg',
//   'assets/svgs/feelings_svgs/Group (10).svg',
// ].obs;
//
// RxList feelingsName = [
//   'Happy',
//   'Blessed',
//   'Confused',
//   'Lucky',
//   'Bored',
//   'Awkward',
//   'Anxious',
//   'Down',
//   'Stressed',
// ].obs;
