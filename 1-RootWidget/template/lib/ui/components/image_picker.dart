import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class ImagePickerComponent extends StatefulWidget {
  const ImagePickerComponent({Key? key}) : super(key: key);

  @override
  _ImagePickerComponentState createState() => _ImagePickerComponentState();
}

class _ImagePickerComponentState extends State<ImagePickerComponent> {
  XFile? _image;
  String? _uploadedFileURL;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text('Selected Image'),
        _image != null
            ? Image.asset(
                _image?.path ?? '',
                height: 150,
              )
            : Container(height: 150),
        _image == null
            ? ElevatedButton(
                child: Text('Choose File'),
                onPressed: chooseFile,
              )
            : Container(),
        _image != null
            ? ElevatedButton(
                child: Text('Upload File'),
                onPressed: uploadFile,
              )
            : Container(),
        _image != null
            ? ElevatedButton(
                child: Text('Clear Selection'),
                onPressed: () {},
              )
            : Container(),
        Text('Uploaded Image'),
        _uploadedFileURL != null
            ? Image.network(
                _uploadedFileURL!,
                height: 150,
              )
            : Container(),
      ],
    ));
  }

  Future chooseFile() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future chooseFileBrowser() async {
    // TODO2: Introduce a webbrowser with a custom button present for user to specify the link to the project is thsi page.
    // Or take the page and pull the first image that is embedded within the page.
    // https://medium.com/flutter-community/creating-a-full-featured-browser-using-webviews-in-flutter-9c8f2923c574

    // TODO1: Also update the version of firestore so that we can use the latest api to connect to our store properly. Then check the app still works.

    //TODO3, use the scroll view handle that we implemented in the listview tutorial from ray wenderlich to then dynamically control the state size of the radius of the avatar profile picture.

    //TODO4: watch the rest of the blockchain Youtube video.
  }

  Future uploadFile() async {
    //  TaskSnapshot taskSnapshot =
    //       await storage.ref('$path/$imageName').putFile(file);

    //   Storage

    //   StorageReference storageReference = FirebaseFirestore.instance
    //       .ref()
    //       .child('chats/${Path.basename(_image.path)}}');
    //   StorageUploadTask uploadTask = storageReference.putFile(_image);
    //   await uploadTask.onComplete;
    //   print('File Uploaded');
    //   storageReference.getDownloadURL().then((fileURL) {
    //     setState(() {
    //       _uploadedFileURL = fileURL;
    //     });
    //   });
  }
}
