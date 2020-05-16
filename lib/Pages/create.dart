import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poetry/Models/post.dart';
import 'package:random_string/random_string.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  CrudMethods crudMethods = CrudMethods();
  String author, title, description;
  File selectedImage;

  /*Get the image from gallery */
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() async {
    /*Store the image in Cloud Storage */
    if(selectedImage != null){
    StorageReference firebaseStorageRef = FirebaseStorage.instance
      .ref()
      .child("BlogImages")
      .child("${randomAlphaNumeric(9)}.jpg");
    final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);
    
    /*Get the downloadUrl of image to be stored */
    var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
    print("$downloadUrl");

    /*Get the data to store */
    Map<String, String> blogMap = {
      "imgUrl": downloadUrl,
      "author": author,
      "title": title,
      "description": description,
    };

    /*Push data to Firebase Database */
    crudMethods.addData(blogMap).then((result) {
      print("Volaaaaaa");
    });

    }else{}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Create Post',
          style:TextStyle(fontSize:25, color: Colors.black),
        ),
        centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
          child: Icon(
          Icons.arrow_back_ios,
          size: 25.0,
          color: Colors.black,
        ),
       ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child:Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      getImage();
                    });
                  },
                  child: selectedImage != null ? Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(selectedImage,)),
                  ) :
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Author'
                        ),
                        onChanged: (val) {
                          author = val;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Title'
                        ),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Description'
                        ),
                        onChanged: (val) {
                          description = val;
                        },
                      ),
                    ],
                  ),
              ),
              SizedBox(height:8.0),
              FlatButton.icon(
                color: Colors.redAccent,
                icon: Icon(Icons.file_upload),
                label: Text('Upload'),
                onPressed: () {
                  uploadBlog();
                },
              ),
            ],
          )
        ),
      )
    );
  }
}