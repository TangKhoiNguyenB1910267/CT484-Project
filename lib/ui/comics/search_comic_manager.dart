
// import 'package:flutter/foundation.dart';
import 'package:comic/models/comic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'comics_grid_tile.dart';
import 'comics_manager.dart';
// import '../../models/comic.dart';
// import '../../services/comics_service.dart';
class CustomSearchDelegate extends SearchDelegate {
  List<Comic> searchTerms=[];
  // late ComicsManager comicsManager;
  
    // .gettitle(context);
  @override
  List<Widget>? buildActions(BuildContext context)  {
     
    return [
      IconButton(
        onPressed: () {
      
          query = '';
          
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }
 
  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
      final comic = context.select<ComicsManager,List<Comic>>(
      (comicsManager) => comicsManager.comic,
      ) ;
      List<Comic> comics=[];
        // int a = comicsManager.comicCount 
      for(int i=0 ;i < comic.length; i++ ){
          comics += [comic[i]];
        }   
        searchTerms =comics;
    return IconButton(
      onPressed: () {
        
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
 
  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Comic> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: matchQuery.length,
          itemBuilder: (ctx, i) => ComicGridTile(matchQuery[i]),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,  
          ),
        );
  }
 
  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Comic> matchQuery = [];
    for (var fruit in searchTerms) {
       if (fruit.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: matchQuery.length,
      itemBuilder: (ctx, i) => ComicGridTile(matchQuery[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,  
      ),
    );
  }
}