import 'package:flutter/material.dart';
Future<bool?> ShowConfirmDiaLog(BuildContext context,String massage){
  return showDialog(
    context: context, 
    builder: (ctx) => AlertDialog(
      title: const Text('Are you sure'),
      content: Text(massage),
      actions: <Widget>[
        TextButton( 
          child: const Text('No'),
          onPressed: (){
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: (){
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );  
}