part of 'favorite_blog_cubit.dart';

@immutable
abstract class FavoriteBlogState {}

class FavoriteBlogInitial extends FavoriteBlogState {}

class FavoriteBlogLoading extends FavoriteBlogState {}

class FavoriteBlogLoaded extends FavoriteBlogState {
  final List<Blog> blogs;
  FavoriteBlogLoaded(this.blogs);
}

class FavoriteBlogError extends FavoriteBlogState {
  final String message;

  FavoriteBlogError(this.message);
}
