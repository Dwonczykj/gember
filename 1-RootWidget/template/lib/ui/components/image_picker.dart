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
  File? _image;
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
        _image = File(image?.path ?? '');
      });
    });
  }

  Future inferFileFromBrowserPage() async {
    //TODO5: Implement inferring a picture embedded in the web browser home page of a project. Or show a list view of all embedded images on the page provided and allow the user to pick the one to use.
  }

  Future chooseFileFromBrowserPage() async {
    // TODO2: Introduce a webbrowser with a custom button present for user to specify the link to the project is thsi page.
    // Or take the page and pull the first image that is embedded within the page.
    // https://medium.com/flutter-community/creating-a-full-featured-browser-using-webviews-in-flutter-9c8f2923c574

    // TODO1: Also update the version of firestore so that we can use the latest api to connect to our store properly. Then check the app still works.

    //TODO3, use the scroll view handle that we implemented in the listview tutorial from ray wenderlich to then dynamically control the state size of the radius of the avatar profile picture.

    //TODO4: watch the rest of the blockchain Youtube video.
  }

  Future uploadFile() async {
    if (_image != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('projects/${Path.basename(_image!.path)}');

      final uploadTask = storageReference.putFile(_image!);

      await uploadTask.whenComplete(() => print('Media Uploaded'));

      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
      });
    }
  }
}
