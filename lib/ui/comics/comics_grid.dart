import 'package:flutter/material.dart';
import 'package:comic/models/comic.dart';
import 'comics_grid_tile.dart';
import 'comics_manager.dart';
import 'package:provider/provider.dart';
import '../../models/comic.dart';

class ComicGrid extends StatelessWidget{
  final bool showFavorites;
  const ComicGrid(this.showFavorites, {super.key});
  @override
  Widget build(BuildContext context){
    final comicsManager = ComicsManager();
    final comic = context.select<ComicsManager,List<Comic>>(
      (comicsManager) => showFavorites ? comicsManager.favoritecomic : comicsManager.comic
      ) ;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: comic.length,
      itemBuilder: (ctx, i) => ComicGridTile(comic[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,  
      ),
    );
  }
}