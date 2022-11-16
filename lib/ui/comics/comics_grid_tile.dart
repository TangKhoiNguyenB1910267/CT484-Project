import 'package:flutter/material.dart';
import '../../models/comic.dart';
import 'comics_detail_screen.dart';
import 'comics_manager.dart';
import 'package:provider/provider.dart';
class ComicGridTile extends StatelessWidget{
  const ComicGridTile(
    this.comic,{
      super.key,
    });
    final Comic comic;
    @override
    Widget build(BuildContext context){
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),

        child: GridTile(
          footer: buildGridFooterBar(context),
          
          child: GridTile(
            child: GestureDetector(
              onTap: (){
               Navigator.of(context).pushNamed(
                  ComicsDetailScreen.routeName,
                  arguments: comic.id,
               );
              },
              child: Image.network(
                comic.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }
    Widget buildGridFooterBar(BuildContext context){
      return Container(
          child:  GridTileBar(
            backgroundColor: Colors.black54,
               trailing: ValueListenableBuilder<bool>(
                valueListenable: comic.isFavoriteListenable,
                    builder:(ctx,isFavorite,child){
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () {
                          comic.isFavorite = !isFavorite;
                        },
                      );
                    },
              ),
            title: Text(
              comic.title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 12,
              ) ,
            ),
          ),
      );
    }
}