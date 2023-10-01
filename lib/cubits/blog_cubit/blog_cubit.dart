
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import '../../model/blog.dart';
import '../../repositories/blog_repository.dart';
part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final blogBox = Hive.box<Blog>('blogs');
  final BlogRepository blogRepository = BlogRepository(); // Declare the repository

  BlogCubit() : super(BlogInitial());

  void fetchBlogs() async {

    emit(BlogLoading());

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (blogBox.isNotEmpty) {
        final List<Blog> blogs = blogBox.values.toList();
        emit(BlogLoaded(blogs));
        return;
      } else {
        emit(BlogError('No internet and no cached data available.'));
        return;
      }
    }

    try {
      final List<Blog> blogs = await blogRepository.fetchBlogs();
      blogBox.clear();
      for (Blog blog in blogs) {
        blogBox.put(blog.title, blog);
      }

      emit(BlogLoaded(blogs));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }



}
