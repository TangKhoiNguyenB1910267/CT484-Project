import 'package:flutter/material.dart';
import 'package:comic/ui/comics/edit_comic_screen.dart';
import 'package:comic/ui/screens.dart';
import 'package:provider/provider.dart';
import '../comics/comics_manager.dart';
import '../../models/comic.dart';
class UserComicListTile extends StatelessWidget {
  final Comic comic;

  const UserComicListTile(
    this.comic, {
      super.key,
    });
    @override
    Widget build(BuildContext context) {
      return ListTile(
        title: Text(comic.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(comic.imageUrl),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              buildEditButton(context),
              buildDeleButton(context),
            ],
          ),
        ),
      );
    }
    Widget buildDeleButton(BuildContext context){
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed:(){
          context.read<ComicsManager>().deleteComic(comic.id!);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Comic deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        color: Theme.of(context).errorColor,
        );
    }
    Widget buildEditButton(BuildContext context){
      return IconButton(
        icon: const Icon(Icons.edit),
        onPressed: (){
           Navigator.of(context).pushNamed(
            EditComicScreen.routeName,
            arguments: comic.id,
          );
        },
        color: Theme.of(context).primaryColor,
      );
    }
}