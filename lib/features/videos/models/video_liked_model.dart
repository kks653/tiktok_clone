class VideoLikedModel {
  final int likesCount;
  final bool isLiked;

  VideoLikedModel({
    required this.likesCount,
    required this.isLiked,
  });

  VideoLikedModel.empty()
      : likesCount = 0,
        isLiked = false;
}
