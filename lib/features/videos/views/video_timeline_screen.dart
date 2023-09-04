import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0;

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
      ref.watch(timelineProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Center(
              child: Text(
                "Could not load videos: $error",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        data: (videos) {
          _itemCount = videos.length;
          return RefreshIndicator(
            displacement: 50,
            edgeOffset: 20,
            color: Theme.of(context).primaryColor,
            onRefresh: _onRefresh,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    index: index,
                    videoData: videoData,
                  );
                }),
          );
        });
  }
}
