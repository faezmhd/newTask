import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImgPicker extends StatefulWidget {
  const ImgPicker({Key? key}) : super(key: key);

  @override
  State<ImgPicker> createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  List<File> _images = [];
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString(); // Unique name for each image
      UploadTask uploadTask = _storage.ref().child('images/$imageName.jpg').putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image uploaded to Firebase: $downloadUrl');
    } catch (e) {
      print('Error uploading image to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(55.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Pho',
                      style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'to',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(27.0),
                    topRight: Radius.circular(27.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 9.0,
                      mainAxisSpacing: 9.0,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                        child: Image.file(_images[index], fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var imgPicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
          if (imgPicker != null) {
            setState(() {
              _images.add(File(imgPicker.path));
            });
            // Upload the selected image to Firebase Storage
            _uploadImageToFirebase(File(imgPicker.path));
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange, // Set button background color to orange
      ),

    );
  }
}
