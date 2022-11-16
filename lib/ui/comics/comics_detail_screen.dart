import 'package:flutter/material.dart';
import '../../models/comic.dart';

class ComicsDetailScreen extends StatelessWidget{
  static const routeName = '/comic-detail';
  const ComicsDetailScreen(
    this.comic,{
      super.key,
    });
    final Comic comic;
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text(comic.title),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                comic.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.left,
                'Giới thiệu Truyện: ',
                style: const TextStyle(
                  color: Colors.grey,
                // textAlign: TextAlign.right,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                comic.description,
                textAlign: TextAlign.left,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
      );
    }
}