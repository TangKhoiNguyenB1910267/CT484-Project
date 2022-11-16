import 'package:flutter/material.dart';
import 'package:comic/ui/comics/edit_comic_screen.dart';
import 'user_comic_list_tile.dart';
import 'comics_manager.dart';
import '../shared/app_drawer.dart';
import 'package:provider/provider.dart';
class UserComicsScreen extends StatelessWidget{
  static const routeName = '/user-comics';
  const UserComicsScreen ({super.key});

   Future<void> _refreshComics(BuildContext context) async {
    await context.read<ComicsManager>().fetchComics(true);
  }


  @override
  Widget build(BuildContext context){
    final comicsManager = ComicsManager();
    return Scaffold(
      appBar: AppBar(
      title: const Text('Your Comics'),
      actions: <Widget>[
        buildAddButton(context),
      ],
      ),
    drawer: const AppDrawer(),
     body: FutureBuilder(
        future: _refreshComics(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshComics(context),
            child: buildUserComicListView(),
          );
        },
      ),
    );
  }
  Widget buildAddButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditComicScreen.routeName,
        );
      },
    );
  }
  Widget buildUserComicListView() {
    return Consumer<ComicsManager>(
      builder: (ctx, comicsManager, child) {
        return ListView.builder(
          itemCount: comicsManager.comicCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserComicListTile(
                comicsManager.comic[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}