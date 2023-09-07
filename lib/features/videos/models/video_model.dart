class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final String id;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creatorUid,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.title,
    required this.creator,
  });

  VideoModel copywith({
    String? id,
    String? description,
    String? fileUrl,
    String? thumbnailUrl,
    String? creatorUid,
    String? creator,
    String? title,
    int? likes,
    int? comments,
    int? createdAt,
  }) {
    return VideoModel(
      id: id ?? this.id,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      creatorUid: creatorUid ?? this.creatorUid,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      creator: creator ?? this.creator,
    );
  }

  VideoModel.fromJson(
      {required Map<String, dynamic> json, required String videoId})
      : description = json["description"],
        fileUrl = json["fileUrl"],
        thumbnailUrl = json["thumbnailUrl"],
        creatorUid = json["creatorUid"],
        likes = json["likes"],
        comments = json["comments"],
        createdAt = json["createdAt"],
        id = videoId,
        title = json["title"],
        creator = json["creator"];

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "creatorUid": creatorUid,
      "likes": likes,
      "comments": comments,
      "createdAt": createdAt,
      "title": title,
      "creator": creator,
      "id": id,
    };
  }
}
