import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/favorite_blog/favorite_blog_cubit.dart';
import '../widgets/custom_card_tile.dart';

class FavoriteBlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBlogCubit()..fetchFavoriteBlogs(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Favorite Blogs',style: TextStyle(color: Colors.white),),
        ),
        body: BlocBuilder<FavoriteBlogCubit, FavoriteBlogState>(
          builder: (context, state) {
            if (state is FavoriteBlogLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoriteBlogLoaded) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return CustomCardTile(
                    title: blog.title,
                    imageUrl: blog.imageUrl,
                    isInHome: false,
                    onTap: () {
                    context.read<FavoriteBlogCubit>().removeFavoriteBlog(blog);

                  },

                  );
                },
              );
            } else if (state is FavoriteBlogError) {
              return Center(
                child: Text(state.message ,style: TextStyle(color: Colors.white),),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
