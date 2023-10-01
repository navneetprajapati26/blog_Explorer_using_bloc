// BlogListView
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_space/screens/favorite_blog_view.dart';

import '../cubits/blog_cubit/blog_cubit.dart';
import '../cubits/favorite_blog/favorite_blog_cubit.dart';
import '../model/blog.dart';
import '../repositories/blog_repository.dart';
import '../widgets/custom_card_tile.dart';


class BlogListView extends StatelessWidget {
  final BlogRepository blogRepository = BlogRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlogCubit>(
          create: (context) => BlogCubit()..fetchBlogs(),
        ),

        BlocProvider<FavoriteBlogCubit>(
          create: (context) => FavoriteBlogCubit(),
        ),
      ],

        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Blog Explorer",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoriteBlogScreen()),
                    );
                  },
                  child: Text(
                    "favorite",style: TextStyle(color: Colors.white,),

                  ))
            ],
          ),
          body: BlocBuilder<BlogCubit, BlogState>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BlogLoaded) {
                return ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return CustomCardTile(
                      title: blog.title,
                      imageUrl: blog.imageUrl,
                      onTap: () {
                        print("--------------> ");
                        context.read<FavoriteBlogCubit>().addFavoriteBlog(blog);
                      },
                    );
                  },
                );
              } else if (state is BlogError) {
                return Center(
                    child: Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                ));
              }
              return Container();
            },
          ),
        ));
  }
}

// BlogDetailView
