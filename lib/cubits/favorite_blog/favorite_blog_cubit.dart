import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../model/blog.dart';

part 'favorite_blog_state.dart';

class FavoriteBlogCubit extends Cubit<FavoriteBlogState> {
  final favoriteBlogBox = Hive.box<Blog>('favorite_blogs');
  FavoriteBlogCubit() : super(FavoriteBlogInitial());

  void fetchFavoriteBlogs() async{
    emit(FavoriteBlogLoading());

    if (favoriteBlogBox.isNotEmpty) {
      final List<Blog> blogs = favoriteBlogBox.values.toList();
      emit(FavoriteBlogLoaded(blogs));
      return;
    } else {
      emit(FavoriteBlogError('no cached data available.'));
      return;
    }

  }

  void addFavoriteBlog(Blog blog) async{
    print("---------------------------> add");
    favoriteBlogBox.put(blog.title, blog);

  }
  void removeFavoriteBlog(Blog blog) async {
    try {
      await favoriteBlogBox.delete(blog.title);
      print("Blog removed from favorites.");
      fetchFavoriteBlogs();
    } catch (e) {
      print("Error removing blog from favorites: $e");
      emit(FavoriteBlogError('Error removing blog from favorites.'));
    }
  }

}
