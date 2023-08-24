import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final _scrollDuration = const Duration(milliseconds: 150);
  final _scrollCurver = Curves.linear;

  final PageController _pageController = PageController();

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurver,
    );
  }

  void _onPageChanged(int currentPage) {
    _pageController.animateToPage(
      currentPage,
      duration: _scrollDuration,
      curve: _scrollCurver,
    );

    if (currentPage == (_itemCount - 1)) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 50,
      edgeOffset: 20,
      color: Theme.of(context).primaryColor,
      onRefresh: _onRefresh,
      child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          scrollDirection: Axis.vertical,
          itemCount: _itemCount,
          itemBuilder: (context, index) => VideoPost(
                onVideoFinished: _onVideoFinished,
                index: index,
              )),
    );
  }
}
