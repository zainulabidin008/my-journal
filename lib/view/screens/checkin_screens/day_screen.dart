import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_journel/controllers/getx_controller/checkin_controller.dart';
import 'package:my_journel/controllers/utils/app_colors.dart';
import 'package:my_journel/controllers/utils/app_styles.dart';
import 'package:my_journel/custom_widgets/ui_components.dart';
import 'package:my_journel/view/screens/checkin_screens/whatbad_evenining_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../model/checkin_models/moodes_model.dart';
import 'checkin_bar.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class DayScreen extends StatelessWidget {
  DayScreen({super.key});

  final CheckInBarController controller = Get.put(CheckInBarController());
  // final HomeController controller = Get.put(HomeController());

  // RxList faces = [
  //   'assets/svgs/faces/angry.svg',
  //   'assets/svgs/faces/sad.svg',
  //   'assets/svgs/faces/Wonderful.svg',
  //   'assets/svgs/faces/Enjoyable.svg',
  //   'assets/svgs/faces/Busy.svg',
  //   'assets/svgs/faces/Lazy.svg',
  // ].obs;
  //
  // RxList faceName = [
  //   'Angry',
  //   'Sad',
  //   'Wonderful',
  //   'Enjoyable',
  //   'Busy',
  //   'Lazy',
  // ].obs;

  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    final CheckInController moodsController =
        Get.put(CheckInController(context));
    moodsController.moodsDetails();
    return Obx(() {
      if (moodsController.loading.value) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: AppColors.blackColor, size: 10.h),
        );
      }
      if (moodsController.moods.value == null) {
        return Center(
          child: Text("No data available"),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.h),
        child: Column(
          children: [
            Text(
              'How was your day Mohsin ?',
              style: AppTextStyles.heading,
            ),
            getVerticalSpace(5.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: moodsController.moods.value?.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 5 / 6,
              ),
              itemBuilder: (context, index) {
                print('Length: ${moodsController.moods.value?.data.length}');
                Datum datum = moodsController.moods.value!.data[index];
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.moodsId.value = datum.id;
                      log('Selected ID: ${controller.moodsId.value}');
                      selectedIndex.value = index;
                    },
                    child: Container(
                      height: 17.h,
                      // width: 14.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.px),
                          color: AppColors.primaryColor,
                          border: Border.all(
                            width: 2.px,
                            color: controller.moodsId.value == datum.id
                                ? Colors.black
                                : Colors.white,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 9.h,
                              width: 9.h,
                              child: Image.network(datum.path),
                            ),
                            getVerticalSpace(2.5.h),
                            Text(
                              datum.title,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            CustomNextButton(
              title: 'Next',
              onTap: () {
                controller.nextScreen();
              },
            ),
          ],
        ),
      );
    });
  }
}

// class AudioRecorder extends StatefulWidget {
//   @override
//   _AudioRecorderState createState() => _AudioRecorderState();
// }
//
// class _AudioRecorderState extends State<AudioRecorder> {
//   final record = AudioRecorder();
//   bool _isRecording = false;
//   String? _filePath;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadFilePath();
//   }
//
//   Future<void> _loadFilePath() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _filePath = prefs.getString('audioFilePath');
//       print('Loaded file path: $_filePath');
//     });
//   }
//
//   Future<void> _startRecording() async {
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = '${tempDir.path}/temp.m4a';
//     bool hasPermission = await record.hasPermission();
//     if (hasPermission) {
//       await record.start(
//         RecordConfig(),
//         path: tempPath,
//       );
//       setState(() {
//         _isRecording = true;
//         _filePath = tempPath;
//       });
//       print('Recording started: $tempPath');
//     } else {
//       print('Permission denied');
//     }
//   }
//
//   Future<void> _stopRecording() async {
//     await record.stop();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (_filePath != null) {
//       prefs.setString('audioFilePath', _filePath!);
//       print('Recording stopped and saved to: $_filePath');
//     }
//     setState(() {
//       _isRecording = false;
//     });
//   }
//
//   Future<void> _playRecording() async {
//     if (_filePath != null && File(_filePath!).existsSync()) {
//       // Using Flutter's built-in player or another package to play the audio.
//       print('Playing recording from: $_filePath');
//       // Add your player code here.
//     } else {
//       print('No recording found or file does not exist');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _isRecording ? _stopRecording : _startRecording,
//               child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
//             ),
//             ElevatedButton(
//               onPressed: _playRecording,
//               child: Text('Play Recording'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AudioRecorderPlayer extends StatefulWidget {
  @override
  _AudioRecorderPlayerState createState() => _AudioRecorderPlayerState();
}

class _AudioRecorderPlayerState extends State<AudioRecorderPlayer> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String _audioPath = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await requestPermissions();
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    _audioPath = '${tempDir.path}/audio_record.aac';

    await _recorder.startRecorder(
      toFile: _audioPath,
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    log('Audio recorded and saved to: $_audioPath');
  }

  Future<void> _playAudio() async {
    await _player.startPlayer(
      fromURI: _audioPath,
      codec: Codec.aacADTS,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
        });
      },
    );
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _stopAudio() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  void _handleTap() {
    if (_isRecording) {
      _stopRecording();
    } else if (_isPlaying) {
      _stopAudio();
    } else if (_audioPath.isEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder and Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _handleTap,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 20,
                        child: Center(
                          child: _isRecording
                              ? SvgPicture.asset('assets/svgs/mic.svg')
                              : _isPlaying
                                  ? Icon(Icons.pause,
                                      size: 20, color: Colors.white)
                                  : Icon(Icons.play_arrow,
                                      size: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
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
