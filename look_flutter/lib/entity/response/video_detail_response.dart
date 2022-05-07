class VideoDetailResponse {
  String id;
  String memberId;
  String title;
  String subTitle;
  String tagNameList;
  String cover;
  String videoUrl;
  num seconds;
  num width;
  num height;
  bool watchType;
  String canWatchMember;
  String cannotWatchMember;
  String channel;
  String address;
  num longitude;
  num latitude;
  String createdAt;
  String avatar;
  String nickname;
  num lickCount;
  num commentCount;
  num shareCount;
  num hasLiked;

  VideoDetailResponse(
      {this.id,
        this.memberId,
        this.title,
        this.subTitle,
        this.tagNameList,
        this.cover,
        this.videoUrl,
        this.seconds,
        this.width,
        this.height,
        this.watchType,
        this.canWatchMember,
        this.cannotWatchMember,
        this.channel,
        this.address,
        this.longitude,
        this.latitude,
        this.createdAt,
        this.avatar,
        this.nickname,
        this.lickCount,
        this.commentCount,
        this.shareCount,
        this.hasLiked});

  VideoDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    title = json['title'];
    subTitle = json['subTitle'];
    tagNameList = json['tagNameList'];
    cover = json['cover'];
    videoUrl = json['videoUrl'];
    seconds = json['seconds'];
    width = json['width'];
    height = json['height'];
    watchType = json['watchType'];
    canWatchMember = json['canWatchMember'];
    cannotWatchMember = json['cannotWatchMember'];
    channel = json['channel'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['createdAt'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    lickCount = json['lickCount'];
    commentCount = json['commentCount'];
    shareCount = json['shareCount'];
    hasLiked = json['hasLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['memberId'] = memberId;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['tagNameList'] = tagNameList;
    data['cover'] = cover;
    data['videoUrl'] = videoUrl;
    data['seconds'] = seconds;
    data['width'] = width;
    data['height'] = height;
    data['watchType'] = watchType;
    data['canWatchMember'] = canWatchMember;
    data['cannotWatchMember'] = cannotWatchMember;
    data['channel'] = channel;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['createdAt'] = createdAt;
    data['avatar'] = avatar;
    data['nickname'] = nickname;
    data['lickCount'] = lickCount;
    data['commentCount'] = commentCount;
    data['shareCount'] = shareCount;
    data['hasLiked'] = hasLiked;
    return data;
  }
}
