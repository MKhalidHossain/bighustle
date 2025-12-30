import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LearningVideoScreen extends StatefulWidget {
  const LearningVideoScreen({super.key});

  @override
  State<LearningVideoScreen> createState() => _LearningVideoScreenState();
}

class _LearningVideoScreenState extends State<LearningVideoScreen> {
  static const _fallbackUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  late VideoPlayerController _controller;
  Timer? _hideTimer;
  bool _hasController = false;
  bool _showControls = true;
  bool _isMuted = false;
  bool _isFullscreen = false;
  int? _selectedAnswer;
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    if (_hasController) {
      _controller.dispose();
    }
    _resetSystemUi();
    super.dispose();
  }

  Future<void> _initializeController({bool useNetwork = false}) async {
    final controller = useNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(_fallbackUrl))
        : VideoPlayerController.asset('assets/videos/bee.mp4');
    final success = await _tryInitialize(controller);
    if (!success && !useNetwork) {
      await _initializeController(useNetwork: true);
    }
  }

  Future<bool> _tryInitialize(VideoPlayerController controller) async {
    final oldController = _hasController ? _controller : null;
    _controller = controller;
    _hasController = true;
    await oldController?.dispose();
    _isLoading = true;
    _loadError = null;
    if (mounted) {
      setState(() {});
    }
    try {
      await _controller.initialize();
      await _controller.setVolume(_isMuted ? 0 : 1);
      await _controller.setLooping(false);
      _isLoading = false;
      if (mounted) {
        setState(() {});
      }
      return true;
    } catch (error) {
      _isLoading = false;
      _loadError = 'Unable to load video. Tap to retry.';
      if (mounted) {
        setState(() {});
      }
      return false;
    }
  }

  Future<void> _toggleFullscreen() async {
    setState(() => _isFullscreen = !_isFullscreen);
    if (_isFullscreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await _resetSystemUi();
    }
  }

  Future<void> _resetSystemUi() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _togglePlay() {
    if (!_hasController || !_controller.value.isInitialized) {
      return;
    }
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() => _showControls = true);
    } else {
      _controller.play();
      setState(() {});
      _startHideTimer();
    }
  }

  void _seekRelative(int seconds) {
    if (!_hasController || !_controller.value.isInitialized) {
      return;
    }
    final position = _controller.value.position;
    final duration = _controller.value.duration;
    final target = position + Duration(seconds: seconds);
    final clamped = target < Duration.zero
        ? Duration.zero
        : target > duration
        ? duration
        : target;
    _controller.seekTo(clamped);
  }

  void _toggleMute() {
    if (!_hasController || !_controller.value.isInitialized) {
      return;
    }
    _isMuted = !_isMuted;
    _controller.setVolume(_isMuted ? 0 : 1);
    setState(() {});
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() => _showControls = false);
      }
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final buffer = StringBuffer();
    if (hours > 0) {
      buffer.write('${hours.toString().padLeft(2, '0')}:');
    }
    buffer
      ..write(minutes.toString().padLeft(2, '0'))
      ..write(':')
      ..write(seconds.toString().padLeft(2, '0'));
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const backgroundColor = Color(0xFFF2F2F2);
    final isInitialized = _hasController && _controller.value.isInitialized;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _isFullscreen
          ? null
          : AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                '4 Way Stop Rules',
                style: TextStyle(
                  fontSize: (size.width * 0.055).clamp(18.0, 24.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF111111)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => _showControls = !_showControls);
                  if (_showControls) {
                    _startHideTimer();
                  }
                },
                child: AspectRatio(
                  aspectRatio:
                      isInitialized ? _controller.value.aspectRatio : 16 / 9,
                  child: Stack(
                    children: [
                      Container(color: Colors.black),
                      if (isInitialized)
                        VideoPlayer(_controller)
                      else if (_isLoading)
                        const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      if (_loadError != null)
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () => _initializeController(),
                            child: Container(
                              color: Colors.black54,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                _loadError ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_showControls)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      iconSize: 20,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                      iconSize: 20,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => _seekRelative(-10),
                                      icon: const Icon(
                                        Icons.replay_10,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _togglePlay,
                                      icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause_circle_filled
                                            : Icons.play_circle_filled,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 44,
                                        minHeight: 44,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _seekRelative(10),
                                      icon: const Icon(
                                        Icons.forward_10,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                    ),
                                  ],
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _controller,
                                  builder: (context, VideoPlayerValue value, _) {
                                    final duration = value.duration;
                                    final position = value.position;
                                    final maxMs = duration.inMilliseconds.clamp(
                                      1,
                                      1 << 31,
                                    );
                                    final currentMs = position.inMilliseconds
                                        .clamp(0, maxMs);
                                    final sliderTheme = SliderTheme.of(context)
                                        .copyWith(
                                          trackHeight: 3,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                enabledThumbRadius: 6,
                                              ),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                overlayRadius: 12,
                                              ),
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.white24,
                                          thumbColor: Colors.white,
                                          overlayColor: Colors.white
                                              .withOpacity(0.2),
                                        );
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${_formatDuration(position)} / ${_formatDuration(duration)}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: _toggleMute,
                                                  icon: Icon(
                                                    _isMuted
                                                        ? Icons.volume_off
                                                        : Icons.volume_up,
                                                    color: Colors.white,
                                                  ),
                                                  iconSize: 20,
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(
                                                        minWidth: 32,
                                                        minHeight: 32,
                                                      ),
                                                ),
                                                IconButton(
                                                  onPressed: _toggleFullscreen,
                                                  icon: Icon(
                                                    _isFullscreen
                                                        ? Icons.fullscreen_exit
                                                        : Icons.fullscreen,
                                                    color: Colors.white,
                                                  ),
                                                  iconSize: 20,
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(
                                                        minWidth: 32,
                                                        minHeight: 32,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 24,
                                          child: SliderTheme(
                                            data: sliderTheme,
                                            child: Slider(
                                              min: 0,
                                              max: maxMs.toDouble(),
                                              value: currentMs.toDouble(),
                                              onChanged: (value) {
                                                _controller.seekTo(
                                                  Duration(
                                                    milliseconds: value.toInt(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Chapter: 4 way stop rules',
                style: TextStyle(
                  fontSize: (size.width * 0.05).clamp(16.0, 20.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              SizedBox(height: size.height * 0.008),
              Text(
                'Duration: 40mins',
                style: TextStyle(
                  fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                  color: const Color(0xFF444444),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'KEY POINTS',
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111111),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              _BulletPoint(
                text: 'First to arrive has right of way',
                size: size,
              ),
              _BulletPoint(
                text: 'If simultaneous, right goes first',
                size: size,
              ),
              _BulletPoint(text: 'Complete stop required', size: size),
              _BulletPoint(text: 'Check all directions', size: size),
              SizedBox(height: size.height * 0.02),
              Text(
                'QUICK QUIZ',
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111111),
                ),
              ),
              Text(
                'Test your understanding',
                style: TextStyle(
                  fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                  color: const Color(0xFF444444),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Q: Who has right of way at 4-way stop?',
                style: TextStyle(
                  fontSize: (size.width * 0.046).clamp(14.0, 18.0),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              _QuizOption(
                label: 'Largest vehicle',
                value: 0,
                groupValue: _selectedAnswer,
                onChanged: (value) => setState(() => _selectedAnswer = value),
              ),
              _QuizOption(
                label: 'First to arrive',
                value: 1,
                groupValue: _selectedAnswer,
                onChanged: (value) => setState(() => _selectedAnswer = value),
              ),
              _QuizOption(
                label: 'Driver on the right',
                value: 2,
                groupValue: _selectedAnswer,
                onChanged: (value) => setState(() => _selectedAnswer = value),
              ),
              _QuizOption(
                label: 'Driver going straight',
                value: 3,
                groupValue: _selectedAnswer,
                onChanged: (value) => setState(() => _selectedAnswer = value),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: double.infinity,
                height: (size.height * 0.07).clamp(48.0, 58.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F78F4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: (size.width * 0.05).clamp(16.0, 20.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  final Size size;

  const _BulletPoint({required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.006),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: Color(0xFF111111)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: (size.width * 0.043).clamp(13.0, 17.0),
                color: const Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizOption extends StatelessWidget {
  final String label;
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  const _QuizOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(label),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: const Color(0xFF111111),
      
    );
  }
}
