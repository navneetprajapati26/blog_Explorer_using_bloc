import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/blog.dart';

class BlogRepository {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Ensure the 'blogs' key is present and its value is a List
        if (jsonResponse.containsKey('blogs') && jsonResponse['blogs'] is List) {
          return (jsonResponse['blogs'] as List).map((blog) => Blog.fromJson(blog)).toList();
        } else {
          throw FormatException('Invalid data format from the API.');
        }
      } else {
        throw Exception(jsonDecode(response.body)['error']);
      }

    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Network issues: ${e.toString()}');
      } else if (e is FormatException) {
        throw Exception('Data format error: ${e.toString()}');
      } else {
        throw Exception('An error occurred: ${e.toString()}');
      }
    }
  }
}
