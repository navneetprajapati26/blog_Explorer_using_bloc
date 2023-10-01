import 'package:hive/hive.dart';
part 'blog.g.dart';

@HiveType(typeId: 0)
class Blog {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String imageUrl;

  Blog({required this.title, required this.imageUrl});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
