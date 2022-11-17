import 'package:comic/ui/screens.dart';
import 'package:flutter/material.dart';

import 'comics_grid.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
enum FilterOptions { favorites , all }
class ComicsOverviewScreen extends StatefulWidget{
  const ComicsOverviewScreen({super.key});
  @override
  State<ComicsOverviewScreen> createState() => _ComicsOverviewScreenState();
}
class _ComicsOverviewScreenState extends State<ComicsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchComics;

  @override
  void initState() {
    super.initState();
    _fetchComics = context.read<ComicsManager>().fetchComics();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('NET Comic'),
        actions: <Widget>[
           IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate()
              );
            },
            icon: const Icon(Icons.search),
          ),
          buildComicFilterMenu(),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchComics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<bool>(
              valueListenable: _showOnlyFavorites,
              builder:(context, onlyFavorites, child) {
                return ComicGrid(onlyFavorites);
              }); 
          }
        return const Center(
          child: CircularProgressIndicator(),
        );  
       },
      ),

    );
  }
  Widget buildComicFilterMenu(){
    return PopupMenuButton(
       onSelected:(FilterOptions selectedValue){  
          if (selectedValue == FilterOptions.favorites){
            _showOnlyFavorites.value=true;
          }else{
            _showOnlyFavorites.value=false;
          }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) =>[
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}