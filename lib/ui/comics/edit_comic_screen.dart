import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/comic.dart';
// import '../shared/dialog_utils.dart';
import 'comics_manager.dart';
class EditComicScreen extends StatefulWidget {
  static const routeName = '/edit-comic';
  EditComicScreen(
    Comic? comic, {
      super.key,
    }) {
    if (comic == null) {
      this.comic = Comic(
        id: null,
        title: '',
        description: '',
        imageUrl: '',
      );
  } else {
      this.comic = comic;
    }
}
  late final Comic comic;

  @override
  State<EditComicScreen> createState() => _EditComicScreenState();
}
  class _EditComicScreenState extends State<EditComicScreen> {
    final _imageUrlController = TextEditingController();
    final _imageUrlFocusNode = FocusNode();
    final _editForm = GlobalKey<FormState>();
    late Comic _editedComic;
    var _isLoading = false;

    bool _isValidImageUrl(String value) {
      return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png')||value.endsWith('.jpg') || value.endsWith('.jpeg'));
    }

  @override
    void initState() {
      _imageUrlFocusNode.addListener(() {
        if (!_imageUrlFocusNode.hasFocus){
          if(!_imageUrlFocusNode.hasFocus){
            if(!_isValidImageUrl(_imageUrlController.text)){
              return;
            }
            setState(() {

            });
          }
        }
      });
      _editedComic = widget.comic;
      _imageUrlController.text = _editedComic.imageUrl;
      super.initState();
    }
  @override
    void dispose() {
      _imageUrlController.dispose();
      _imageUrlFocusNode.dispose();
      super.dispose();
    }
    Future<void> _saveForm() async {
      final isValid = _editForm.currentState!.validate();
      if(!isValid){
        return;
      }
      _editForm.currentState!.save();
      setState(() {
        _isLoading =true;
      });
      try{
        final comicsManager =context.read<ComicsManager>();
        if(_editedComic.id != null){
          await comicsManager.updateComic(_editedComic);
        }else{
          await comicsManager.addComic(_editedComic);
        }
      }catch(error){
        await showErrorDialog(context,'Something went wrong.');
      }
      setState(() {
        _isLoading =false;
      });
      if(mounted){
        Navigator.of(context).pop();
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Comic'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
  ],
),
body: _isLoading
  ? const Center(
    child: CircularProgressIndicator(),
  )
  : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _editForm,
        child: ListView(
          children: <Widget>[
            buildTitleField(),
            buildDescriptionField(),
            buildComicPreview(),
          ],
        ),
      ),
    ),
  );
}
 TextFormField buildTitleField(){
  return TextFormField(
    initialValue: _editedComic.title,
    decoration: const InputDecoration(labelText: 'Title'),
    textInputAction: TextInputAction.next,
    autofocus: true,
    validator: (value){
      if(value!.isEmpty){
        return 'Please provide a value.';
      }
      return null;
    },
    onSaved: (value){
      _editedComic = _editedComic.copyWith(title: value);
    },
  );
 }
 TextFormField buildDescriptionField(){
  return TextFormField(
    initialValue: _editedComic.description,
    decoration: const InputDecoration(labelText: 'Description'),
    maxLength: 5000,
    keyboardType: TextInputType.multiline,
    validator: (value){
      if(value!.isEmpty){
        return 'please enter a description';
      }
      if(value.length<10){
        return ' Should be at least 10 characters long.';
      }
      return null;
    },
    onSaved: (value){
      _editedComic = _editedComic.copyWith(description: value);
    },
  );
 }
 Widget buildComicPreview(){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(
          top: 8,
          right: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
        ),
        child: _imageUrlController.text.isEmpty
        ? const Text('Enter a URL')
        : FittedBox(
          child: Image.network(
            _imageUrlController.text,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Expanded(
        child: buildImageURLField(),
        ),
    ],
  );
 }
 TextFormField buildImageURLField(){
  return TextFormField(
    decoration: const InputDecoration(labelText: 'Image URL'),
    keyboardType: TextInputType.url,
    textInputAction: TextInputAction.done,
    controller: _imageUrlController,
    focusNode: _imageUrlFocusNode,
    onFieldSubmitted: (value) => _saveForm(),
    validator: (value){
      if(value!.isEmpty){
        return 'please enter an image URL.';
      }
      if(!_isValidImageUrl(value)){
        return 'Please enter a valid image URL.';
      }
      return null;
    },
    onSaved: (value){
      _editedComic = _editedComic.copyWith(imageUrl: value);
    },
  );
 }
 Future<void> showErrorDialog(BuildContext context,String message){
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
 }
}