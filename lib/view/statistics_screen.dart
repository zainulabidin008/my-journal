import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10.5.h,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.h),
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
        // getVerticalSpace(5.h),
        Padding(
          padding: EdgeInsets.all(5.h),
          child: Column(
            children: [
              Row(
                children: [
                  StatisticsCustomWidget(
                    title: '100 Days',
                    subTitle: 'Current Streak',
                    svg: 'assets/svgs/fire.svg',
                  ),
                  getHorizentalSpace(2.h),
                  StatisticsCustomWidget(
                    title: '10',
                    subTitle: 'Achieved Goals',
                    svg: 'assets/svgs/arrow-board.svg',
                  ),
                ],
              ),
              getVerticalSpace(2.h),
              Row(
                children: [
                  StatisticsCustomWidget(
                    title: '25',
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
              getVerticalSpace(5.h),
              Text(
                'Statistic Goals',
                style: TextStyle(
                  fontSize: 16.px,
                  fontFamily: 'Bold',
                  color: AppColors.deepBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              getVerticalSpace(5.h),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.px),
                  color: Colors.white,
                ),
                child: Center(child: Expanded(child: LineChartSample2())),
              ),
            ],
          ),
        ),
      ],
    );
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
      aspectRatio: 1.90,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    TextStyle style = TextStyle(
                      fontSize: 7,
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
                      fontSize: 7,
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
                color: AppColors.primaryColor,
                barWidth: 1,
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
