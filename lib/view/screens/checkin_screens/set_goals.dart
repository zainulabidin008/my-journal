import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_journel/controllers/getx_controller/checkin_controller.dart';
import 'package:my_journel/controllers/utils/constants.dart';
import 'package:my_journel/controllers/utils/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/api_services/base_url.dart';
import '../../../controllers/getx_controller/getallapis_controller.dart';
import '../../../controllers/utils/app_colors.dart';
import '../../../controllers/utils/app_styles.dart';
import '../../../custom_widgets/ui_components.dart';
import '../../../model/getallposts_model.dart';
import 'checkin_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class SetGoalsScreen extends StatefulWidget {
  const SetGoalsScreen({super.key});

  @override
  State<SetGoalsScreen> createState() => _SetGoalsScreenState();
}

class _SetGoalsScreenState extends State<SetGoalsScreen> {
  final CheckInBarController controller = Get.put(CheckInBarController());
  late final GetAllApis getAllPostsController;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  RxBool isRecording = false.obs;
  RxBool isPlaying = false.obs;

  @override
  void initState() {
    super.initState();
    getAllPostsController = Get.put(GetAllApis(context));
    _initialize();
  }

  Future<void> _initialize() async {
    await requestPermissions();
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/audio_record.aac';
    controller.audioPath.value = filePath;

    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );
    isRecording.value = true;
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    isRecording.value = false;
    File recordedFile = File(controller.audioPath.value);
    log('Audio recorded and saved to: ${recordedFile.path}');
  }

  Future<void> _playAudio() async {
    await _player.startPlayer(
      fromURI: controller.audioPath.value,
      codec: Codec.aacADTS,
      whenFinished: () {
        isPlaying.value = false;
      },
    );
    isPlaying.value = true;
  }

  Future<void> _stopAudio() async {
    await _player.stopPlayer();
    isPlaying.value = false;
  }

  Future<void> _deleteAudio() async {
    File(controller.audioPath.value).delete();
    controller.audioPath.value = '';
    // setState(() {});
  }

  void _handleTap() {
    if (isRecording.value) {
      _stopRecording();
    } else if (isPlaying.value) {
      _stopAudio();
    } else if (controller.audioPath.value.isEmpty) {
      _startRecording();
    } else {
      _playAudio();
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // final GetAllApis getAllPostsController = Get.put(GetAllApis(context));
        final data = getAllPostsController.getAllPost.value?.data ?? [];

        String contentText;

        if (data.isNotEmpty) {
          final int lastIndex = data.length - 1;
          Datum datum = data[lastIndex];
          contentText = datum.tomorrowDescription.toString();
        } else {
          contentText = 'No Goals';
        }
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.px, horizontal: 12.px),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.px),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    'Today\'s Goal',
                    style: TextStyle(
                      fontSize: 16.px,
                      fontFamily: 'Bold',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              getVerticalSpace(1.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.px),
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.px),
                  child: Text(
                    contentText,
                    // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget urna vel felis sollicitudin euismod. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin sit amet nunc quis sapien ultrices facilisis. Integer euismod leo ac urna gravida, sit amet feugiat risus interdum. Morbi a lacus ac purus gravida fermentum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam et sem vel mauris pharetra scelerisque. Suspendisse potenti. Cras sagittis, urna in interdum cursus, magna leo convallis metus, id tempus ex lorem eget libero.',
                    style: TextStyle(
                      fontSize: 8.px,
                      fontFamily: 'regular',
                      color: AppColors.simpleSmallTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log("Note Id: ${controller.noteId.value}");
    log("path: ${controller.audioPath.value}");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(3.h),
          child: Column(
            children: [
              Text(
                'Did you achieved your set goals ${getAllPostsController.name}?',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              getVerticalSpace(5.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectYes();
                        log('bool: ${controller.isYesSelected.value}');
                      },
                      child: Obx(
                        () => Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.px),
                            color: controller.isYesSelected.value
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              color: AppColors.blackColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: AppTextStyles.medium.copyWith(
                                color: controller.isYesSelected.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.px),
                  GestureDetector(
                    onTap: () {
                      showCustomDialog(context);
                    },
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: AppColors.whiteColor,
                      child: Center(
                        child: SvgPicture.asset('assets/svgs/goal1.svg'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.px),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectNo();
                        log('bool: ${controller.isYesSelected.value}');
                      },
                      child: Obx(
                        () => Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.px),
                            color: controller.isYesSelected.value
                                ? Colors.white
                                : Colors.red,
                            border: Border.all(
                              color: AppColors.blackColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: AppTextStyles.medium.copyWith(
                                color: controller.isYesSelected.value
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Tap here to see\nTodays goal',
                style: TextStyle(
                  fontSize: 10.px,
                  fontFamily: 'regular',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              getVerticalSpace(1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Write about your day...',
                    style: AppTextStyles.medium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              getVerticalSpace(1.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.px),
                  color: AppColors.whiteColor,
                ),
                child: TextFormField(
                  controller: controller.describeDayController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Describe your day...',
                    hintStyle: TextStyle(
                      fontSize: 10.px,
                      fontFamily: 'medium',
                      color: AppColors.simpleSmallTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  maxLines: 4,
                ),
              ),
              getVerticalSpace(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Talk about your day',
                    style: AppTextStyles.medium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              getVerticalSpace(1.h),
              GestureDetector(
                onTap: _handleTap,
                child: Obx(
                  () => Container(
                    height: 48.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.px),
                      color: AppColors.whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.audioPath.value.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColors.red,
                                  size: 25.px,
                                ),
                                onPressed: _deleteAudio,
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.px),
                          child: CircleAvatar(
                            backgroundColor: isRecording.value
                                ? Colors.red
                                : isPlaying.value
                                    ? Color(0xff0E9AFF)
                                    : AppColors.blackColor,
                            radius: 20,
                            child: Center(
                              child: isRecording.value
                                  ? Icon(Icons.mic,
                                      size: 20, color: AppColors.whiteColor)
                                  : isPlaying.value
                                      ? Icon(Icons.pause,
                                          size: 20, color: AppColors.whiteColor)
                                      : controller.audioPath.value.isEmpty
                                          ? SvgPicture.asset(
                                              'assets/svgs/mic.svg')
                                          : Icon(
                                              Icons.play_arrow,
                                              size: 20,
                                              color: AppColors.whiteColor,
                                            ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Spacer(),
              getVerticalSpace(25.h),
              CustomNextButton(
                title: 'Next',
                onTap: () {
                  if (controller.describeDayController.text.isEmpty) {
                    customScaffoldMessenger(
                        context, 'your day description is not be empty');
                  } else if (controller.audioPath.value.isEmpty) {
                    customScaffoldMessenger(
                        context, 'please try again to record voice');
                  } else {
                    controller.nextScreen();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> requestPermissions() async {
  var status = await Permission.microphone.status;
  if (!status.isGranted) {
    await Permission.microphone.request();
  }
}
