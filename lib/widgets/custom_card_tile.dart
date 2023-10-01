import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCardTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final isInHome;

  CustomCardTile(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onTap,
      this.isInHome = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white12,borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 200,
                        width: 400,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()), // Placeholder until the image loads
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error), // Widget to display in case of error
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(title, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      )),
                  // ListTile(
                  //   title: Text(title),
                  //   onTap: onTap,
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: onTap, icon: Icon( isInHome ? Icons.favorite_rounded : Icons.delete,color: Colors.orangeAccent,)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
