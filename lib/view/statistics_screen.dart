import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/getx_controller/getallapis_controller.dart';
import '../controllers/utils/constants.dart';
import '../controllers/utils/shared_preferences.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAllApis controller = Get.put(GetAllApis(context));
    controller.getStatisticsData();
    log("user Id: ${MySharedPreferences.getString(userIdKey)}");
    return Obx(() {
      if (controller.statistics.value == null ||
          controller.statistics.value!.data == null) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
            color: AppColors.blackColor,
            size: 10.h,
          ),
        );
      }

      var data = controller.statistics.value!.data;
      log("Streaks: ${data.posts}");

      return Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pngs/background_image.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 10.5.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3.h),
                        bottomRight: Radius.circular(3.h),
                      ),
                      color: AppColors.blackColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(''),
                        Text(
                          'Statistic',
                          style: TextStyle(
                            fontSize: 16.px,
                            fontFamily: 'medium',
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            StatisticsCustomWidget(
                              title: data.streak.toString(),
                              subTitle: 'Current Streak',
                              svg: 'assets/svgs/fire.svg',
                            ),
                            getHorizentalSpace(2.h),
                            StatisticsCustomWidget(
                              title: data.posts.toString(),
                              subTitle: 'Achieved Goals',
                              svg: 'assets/svgs/arrow-board.svg',
                            ),
                          ],
                        ),
                        getVerticalSpace(2.h),
                        Row(
                          children: [
                            StatisticsCustomWidget(
                              title: data.notes.toString(),
                              subTitle: 'Voice over',
                              svg: 'assets/svgs/mic-svg.svg',
                            ),
                            getHorizentalSpace(2.h),
                            StatisticsCustomWidget(
                              title: 'Happy',
                              subTitle: 'Mood Average',
                              svg: 'assets/svgs/happy.svg',
                            ),
                          ],
                        ),
                        getVerticalSpace(3.h),
                        Text(
                          'Statistic Goals',
                          style: TextStyle(
                            fontSize: 16.px,
                            fontFamily: 'Bold',
                            color: AppColors.deepBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        getVerticalSpace(3.h),
                        Container(
                          height: 30.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.px),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: LineChartSample2()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class StatisticsCustomWidget extends StatelessWidget {
  final String svg;
  final String title;
  final String subTitle;
  const StatisticsCustomWidget(
      {super.key,
      required this.svg,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 112.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.px),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(svg),
                  SvgPicture.asset('assets/svgs/fluent_info-24-filled.svg'),
                ],
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.px,
                  fontFamily: 'Bold',
                  color: AppColors.deepBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 12.px,
                  fontFamily: 'regular',
                  color: AppColors.deepBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartSample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    TextStyle style = TextStyle(
                      fontSize: 8,
                      fontFamily: 'regular',
                      color: Color(0xffAEAEAE),
                      fontWeight: FontWeight.bold,
                    );
                    switch (value.toInt()) {
                      case 10:
                        return Text('10', style: style);
                      case 20:
                        return Text('20', style: style);
                      case 30:
                        return Text('30', style: style);
                      case 40:
                        return Text('40', style: style);
                      case 50:
                        return Text('50', style: style);
                    }
                    return Container();
                  },
                  interval: 10,
                  reservedSize: 28,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    TextStyle style = TextStyle(
                      fontSize: 8,
                      fontFamily: 'RegularFont',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    );
                    switch (value.toInt()) {
                      case 0:
                        return Text('1 May', style: style);
                      case 1:
                        return Text('2 May', style: style);
                      case 2:
                        return Text('3 May', style: style);
                      case 3:
                        return Text('4 May', style: style);
                      case 4:
                        return Text('5 May', style: style);
                      case 5:
                        return Text('6 May', style: style);
                      case 6:
                        return Text('7 May', style: style);
                    }
                    return Container();
                  },
                  reservedSize: 15,
                  interval: 1,
                  // margin: 8,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: 6,
            minY: 10,
            maxY: 50,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 30),
                  FlSpot(1, 40),
                  FlSpot(2, 35),
                  FlSpot(3, 45),
                  FlSpot(4, 25),
                  FlSpot(5, 40),
                  FlSpot(6, 35),
                ],
                isCurved: true,
                color: AppColors.blackColor,
                barWidth: 2,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
