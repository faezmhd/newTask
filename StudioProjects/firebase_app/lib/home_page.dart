import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeImager extends StatefulWidget {
  const HomeImager({Key? key});

  @override
  State<HomeImager> createState() => _HomeImagerState();
}

class _HomeImagerState extends State<HomeImager> {
  File? imageUpload;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageUrl != null)
                  Image.network(imageUrl!),
                const SizedBox(height: 20),
                if (imageUrl == null && imageUpload == null)
                  const Text("No Image selected"),
                if (imageUrl == null && imageUpload != null)
                  Image(image: FileImage(imageUpload!)),
                ElevatedButton(
                  onPressed: () async {
                    final img = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (img == null) return;
                    setState(() {
                      imageUpload = File(img.path);
                      imageUrl = null;
                    });
                  },
                  child: const Text("Get Image"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (imageUpload == null) return;
                    final ref = FirebaseStorage.instance
                        .ref()
                        .child("images/${imageUpload!.path}");
                    await ref.putFile(imageUpload!);
                    final imageUrl = await ref.getDownloadURL();
                    setState(() {
                      this.imageUrl = imageUrl;
                      imageUpload = null;
                    });
                  },
                  child: const Text("Upload Image"),
                ),
                if (imageUrl != null)
                  Image.network(imageUrl!), // Display uploaded image
              ],
            ),
          ),
        ),
      ),
    );
  }
}
