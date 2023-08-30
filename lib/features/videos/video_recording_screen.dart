import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

import '../../constants/sizes.dart';
import 'widgets/flash_mode_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;

  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late FlashMode _flashMode;

  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  final Map<FlashMode, Icon> _flashModeIcons = {
    FlashMode.off: const Icon(Icons.flash_off_rounded),
    FlashMode.always: const Icon(Icons.flash_on_rounded),
    FlashMode.auto: const Icon(Icons.flash_auto),
    FlashMode.torch: const Icon(Icons.flashlight_on_rounded),
  };

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);

    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final file = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: file,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) return;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _startZooming(DragDownDetails details) async {
    if (!_cameraController.value.isInitialized) return;
    if (!mounted) return;

    final minZoomLevel = await _cameraController.getMinZoomLevel();
    final maxZoomLevel = await _cameraController.getMaxZoomLevel();

    double currentZoomLevel = minZoomLevel;
    final dy = details.localPosition.dy;

    if (dy <= 0) {
      currentZoomLevel += (dy * -0.05);
      if (currentZoomLevel >= maxZoomLevel) currentZoomLevel = maxZoomLevel;
      await _cameraController.setZoomLevel(currentZoomLevel);
    } else {
      currentZoomLevel -= (dy * -0.005);
      if (currentZoomLevel <= minZoomLevel) currentZoomLevel = minZoomLevel;
      await _cameraController.setZoomLevel(currentZoomLevel);
    }
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Initializing...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size20,
                      ),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!_noCamera && _cameraController.value.isInitialized)
                      CameraPreview(_cameraController),
                    const Positioned(
                      top: Sizes.size40,
                      left: Sizes.size20,
                      child: CloseButton(
                        color: Colors.white,
                      ),
                    ),
                    if (!_noCamera)
                      Positioned(
                        top: Sizes.size10,
                        right: Sizes.size20,
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: _toggleSelfieMode,
                              icon: const Icon(Icons.cameraswitch),
                            ),
                            //Gaps.v10,
                            for (var flashMode in _flashModeIcons.entries)
                              FlashModeButton(
                                isSelected: _flashMode == flashMode.key,
                                flashMode: flashMode.key,
                                onPressed: () => _setFlashMode(flashMode.key),
                                icon: flashMode.value,
                              ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: Sizes.size20,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onVerticalDragDown: (details) =>
                                _startZooming(details),
                            onVerticalDragCancel: _stopRecording,
                            onTapDown: _startRecording,
                            onTapUp: (details) => _stopRecording(),
                            child: ScaleTransition(
                              scale: _buttonAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: Sizes.size80 + Sizes.size14,
                                    height: Sizes.size80 + Sizes.size14,
                                    child: CircularProgressIndicator(
                                      color: Colors.red.shade400,
                                      strokeWidth: Sizes.size6,
                                      value: _progressAnimationController.value,
                                    ),
                                  ),
                                  Container(
                                    width: Sizes.size80,
                                    height: Sizes.size80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
