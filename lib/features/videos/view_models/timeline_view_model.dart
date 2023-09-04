import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

import '../../authentication/repos/authentication_repo.dart';
import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideos(
      //uid: user!.uid,
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map((doc) => VideoModel.fromJson(
          json: doc.data(),
          videoId: doc.id,
        ));

    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    final user = ref.read(authRepo).user;
    _repository = ref.read(videosRepo);

    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);

    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(_list);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
