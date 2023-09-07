import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';

import '../models/video_liked_model.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<VideoLikedModel, String> {
  late final VideosRepository _repository;
  late final _videoId;

  @override
  FutureOr<VideoLikedModel> build(String videoId) async {
    _videoId = videoId;
    _repository = ref.read(videosRepo);

    final list = ref.read(timelineProvider).value!;
    for (var video in list) {
      if (video.id == videoId) {
        return VideoLikedModel(
            likesCount: video.likes, isLiked: video.likes > 0);
      }
    }

    return VideoLikedModel.empty();
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);

    await ref.read(timelineProvider.notifier).refresh();
  }

  refreshLikedCount() {
    state = const AsyncValue.loading();
    state = AsyncValue.data(VideoLikedModel(
        isLiked: !state.value!.isLiked,
        likesCount: state.value!.isLiked
            ? state.value!.likesCount - 1
            : state.value!.likesCount + 1));
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, VideoLikedModel, String>(
  () => VideoPostViewModel(),
);
