import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../orders/orders_screen.dart';
import '../comics/user_comic_screen.dart';
import '../auth/auth_manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer ({super.key});
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Comic'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.payment),
          //   title: const Text('Orders'),
          //   onTap: (){
          //     Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
          //   },
          // ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserComicsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
