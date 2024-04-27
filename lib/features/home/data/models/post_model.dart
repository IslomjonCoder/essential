class Post {
  final String title;
  final String image;
  final String? blurhash;
  Post({
    required this.title,
    this.image = '',
    this.blurhash,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'blurhash': blurhash
      };

  Post copyWith({
    String? title,
    String? image,
    String? Function()? blurhash,
  }) {
    return Post(
      title: title ?? this.title,
      image: image ?? this.image,
      blurhash: blurhash != null ? blurhash() : this.blurhash,
    );
  }
}

class PostModel extends Post {
  final int id;
  final DateTime postedAt;

  PostModel({
    required super.title,
    super.image,
    required this.id,
    required this.postedAt,
    super.blurhash,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      postedAt: DateTime.parse(json['created_at']),
      blurhash: json['blurhash'],
    );
  }

  @override
  String toString() {
    return 'PostModel{id: $id, postedAt: $postedAt title: $title, image: $image, blurhash: $blurhash}';
  }
}
