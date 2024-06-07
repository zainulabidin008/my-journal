import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/utils/app_colors.dart';
import '../../controllers/utils/app_styles.dart';
import '../../custom_widgets/ui_components.dart';
import '../bottombar.dart';
import 'checkin_screens/checkin_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RxList<HomeScreenModel> weekList = [
    HomeScreenModel(
        week: 'Mon', day: '01', svg: 'assets/svgs/home_screen/Frame 61.svg'),
    HomeScreenModel(
        week: 'Tue',
        day: '02',
        svg: 'assets/svgs/home_screen/Frame 61 (1).svg'),
    HomeScreenModel(
        week: 'Wed',
        day: '03',
        svg: 'assets/svgs/home_screen/Frame 61 (2).svg'),
    HomeScreenModel(
        week: 'Thur',
        day: '04',
        svg: 'assets/svgs/home_screen/Frame 61 (3).svg'),
    HomeScreenModel(
        week: 'Fri',
        day: '05',
        svg: 'assets/svgs/home_screen/Frame 61 (4).svg'),
    HomeScreenModel(
        week: 'Mon', day: '06', svg: 'assets/svgs/home_screen/Frame 61.svg'),
    HomeScreenModel(
        week: 'Wed',
        day: '07',
        svg: 'assets/svgs/home_screen/Frame 61 (2).svg'),
  ].obs;
  RxBool _isFirstTime = true.obs;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
    _isFirstTime.value = isFirstTime;
  }

  RxList eveningBad = [
    'assets/svgs/some_what_bad_svgs/layer1.svg',
    'assets/svgs/some_what_bad_svgs/Capa_1.svg',
    'assets/svgs/some_what_bad_svgs/Capa_1 (1).svg',
    'assets/svgs/some_what_bad_svgs/Capa_1 (2).svg',
    'assets/svgs/some_what_bad_svgs/Capa_1 (3).svg',
    'assets/svgs/some_what_bad_svgs/Capa_1 (4).svg',
    'assets/svgs/some_what_bad_svgs/flat.svg',
    'assets/svgs/some_what_bad_svgs/flat (1).svg',
    'assets/svgs/some_what_bad_svgs/flat (2).svg',
    'assets/svgs/some_what_bad_svgs/Group (1).svg',
  ].obs;

  RxList eveningBadName = [
    'Work',
    'Family',
    'Friends',
    'School',
    'Relation',
    'Traveling',
    'Food',
    'Exercise',
    'Health',
    'Gaming',
  ].obs;

  RxList feelingsSvg = [
    'assets/svgs/feelings_svgs/Group.svg',
    'assets/svgs/feelings_svgs/Group (1).svg',
    'assets/svgs/feelings_svgs/Group (3).svg',
    'assets/svgs/feelings_svgs/Group (4).svg',
    'assets/svgs/feelings_svgs/Group (5).svg',
    'assets/svgs/feelings_svgs/Group (6).svg',
    'assets/svgs/feelings_svgs/Group (8).svg',
    'assets/svgs/feelings_svgs/Group (9).svg',
    'assets/svgs/feelings_svgs/Group (10).svg',
  ].obs;

  RxList feelingsName = [
    'Happy',
    'Blessed',
    'Confused',
    'Lucky',
    'Bored',
    'Awkward',
    'Anxious',
    'Down',
    'Stressed',
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Fri,May 17',
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
                          'Hey Mohsin!',
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
                      itemCount: weekList.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = weekList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: Container(
                            height: 104,
                            // width: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.h),
                              color: AppColors.whiteColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.week,
                                    style: AppTextStyles.subtitleGrey,
                                  ),
                                  Text(
                                    item.day,
                                    style: AppTextStyles.heading1,
                                  ),
                                  getVerticalSpace(1.h),
                                  SvgPicture.asset(item.svg),
                                ],
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
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Mood',
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
                                      SvgPicture.asset(
                                          'assets/svgs/wonderfull.svg'),
                                      getHorizentalSpace(1.h),
                                      Text(
                                        'Wonderful',
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
                                    itemCount: eveningBad.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 0.0,
                                      childAspectRatio: 4 / 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Obx(
                                        () => GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.px),
                                            ),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                    eveningBad[index]),
                                                getVerticalSpace(1.h),
                                                Text(
                                                  eveningBadName[index],
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
                                          ),
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
                                    itemCount: feelingsSvg.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 0.0,
                                      childAspectRatio: 6 / 7,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Obx(
                                        () => GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.px),
                                            ),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                    feelingsSvg[index]),
                                                getVerticalSpace(1.h),
                                                Text(
                                                  feelingsName[index],
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
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  getVerticalSpace(1.5.h),
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
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.h),
                                      color: Color(0xffF5F5F5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15.px,
                                            backgroundColor: Color(0xff0E9AFF),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                  'assets/svgs/play-button.svg'),
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            'assets/svgs/waves.svg',
                                          ),
                                          Spacer(),
                                          Text(
                                            '0:12',
                                            style: TextStyle(
                                              fontSize: 12.px,
                                              fontFamily: 'regular',
                                              color: AppColors.blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  getVerticalSpace(1.5.h),
                                  Divider(),
                                  getVerticalSpace(8.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Obx(() {
              //   return _isFirstTime.value
              //       ? AnimatedContainerExample()
              //       : SizedBox.shrink();
              // }),
            ],
          ),
        ),
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
                Get.to(() => CheckInBar());
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
    );
  }
}

// Column(
// children: [
// getVerticalSpace(2.h),
// Container(
// height: 7,
// width: 80,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(6.px),
// color: Colors.white,
// ),
// ),
// getVerticalSpace(8.h),
// SvgPicture.asset('assets/svgs/home1.svg'),
// Text(
// 'No records for today?',
// style: TextStyle(
// fontSize: 16.px,
// fontFamily: 'medium',
// color: AppColors.blackColor,
// fontWeight: FontWeight.w500,
// ),
// ),
// getVerticalSpace(1.h),
// Text(
// textAlign: TextAlign.center,
// 'You don’t have any entries for today\nPress the Check In button to further continue',
// style: TextStyle(
// fontSize: 12.px,
// fontFamily: 'regular',
// color: AppColors.simpleSmallTextColor,
// fontWeight: FontWeight.w400,
// ),
// ),
// ],
// ),
