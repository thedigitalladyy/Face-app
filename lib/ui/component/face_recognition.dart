import 'package:flutter/material.dart';
import 'package:liveness_detection_flutter_plugin/index.dart';
import 'package:liveness_detection_flutter_plugin/liveness_detection_flutter_plugin.dart';

class FaceApp extends StatefulWidget {
  const FaceApp({super.key});

  @override
  State<FaceApp> createState() => _HomePageState();
}

class _HomePageState extends State<FaceApp> {
  List<String?> capturedImages = [];
  String? imgPath;
  List<LivenessDetectionStepItem> stepLiveness = [
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.blink,
      title: "Testing Blink",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.lookUp,
      title: "Testing Look Up",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.lookDown,
      title: "Testing Look Down",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.turnRight,
      title: "Testing Turn Right",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.turnLeft,
      title: "Testing Turn Left",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.smile,
      title: "Testing Smile",
      isCompleted: false,
    ),
  ];
  List<LivenessDetectionStepItem> stepSelfies = [
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.smile,
      title: "Smile",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.turnRight,
      title: "Turn Right",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.turnLeft,
      title: "Turn Left",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.lookUp,
      title: "Look Up",
      isCompleted: false,
    ),
    LivenessDetectionStepItem(
      step: LivenessDetectionStep.lookDown,
      title: "Look Down",
      isCompleted: false,
    ),
  ];
  @override
  void initState() {
    super.initState();
    stepLiveness.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    stepLiveness.shuffle();
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            imgPath != null
                ? Align(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(imgPath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: () async {
                final List<String?> listFace =
                    await LivenessDetectionFlutterPlugin.instance
                        .selfiesRegisterUser(
                  context,
                  config: LivenessConfig(
                    steps: stepSelfies,
                  ),
                );
                setState(() {
                  capturedImages = listFace;
                });
              },
              child: const Text('Selfie Automatic Face Motion System'),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: capturedImages.length,
              itemBuilder: (context, index) {
                if (capturedImages[index] != null) {
                  return Align(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(capturedImages[index]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
