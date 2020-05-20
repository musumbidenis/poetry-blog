import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poetry/Models/api.dart';
import 'package:poetry/Pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String username, title, description, imageUrl;
  File selectedImage;

  bool isLoading = false;

  /*Get the image from gallery */
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      selectedImage = image;
    });
  }


  /*Create new post*/
  Future createPost() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('userKey', "musumbidenis");
    username = localStorage.getString('userKey');

    var data = {
      'title': title,
      'description': description,
      'username': username,
      'image': base64Encode(selectedImage.readAsBytesSync()),
      'imageName': '1234',
    };
    print(data);
    var response = await CallAPi().postData(data, 'post');
    var body = json.decode(response.body);

    if(body == 'success'){
      print("Yesss! I did it.");
    }else{
      print(body);
    }
  
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
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios,
          size: 25.0,
          color: Colors.black,
        ),
       ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
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
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 9.0),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                          ),
                          onChanged: (val) {
                            title = val;
                          },
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                          ),
                        ),
                        SizedBox(height: 9.0),
                        Container(
                          padding: EdgeInsets.only(bottom: 40.0),
                          child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '\n \n **Creative Piece** \n \n',
                            ),
                            onChanged: (val) {
                              description = val;
                            },
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50.0,
                    child: FloatingActionButton.extended(
                      elevation: 0.0,
                      icon: Icon(
                        Icons.file_upload, 
                        size: 30.0,
                      ),
                      label: Text(isLoading ? 'Uploading..' :
                        "Upload",
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: (){
                        createPost();
                        setState(() {
                          isLoading = true;
                        });
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
              ],
            )
          ),
        ),
      )
    );
  }
}