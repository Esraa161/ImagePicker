import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
class ImageP extends StatefulWidget {


  @override
  State<ImageP> createState() => _ImagePState();
}

class _ImagePState extends State<ImageP> {
  File? profileimage;
  final picker = ImagePicker();
  Future<void> getProfileImageByGallery() async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return null;
    setState(() {
      profileimage = File(imageFileProfile.path);
    });


  }
  Future<void> getProfileImageByCam() async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.camera);
    if (imageFileProfile == null) return;
    setState(() {
      profileimage = File(imageFileProfile.path);
    });

  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('This is a bottom sheet'),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Image picker"),
        centerTitle: true,
        //backgroundColor: Color.fromRGBO(9, 67, 72, 0.7019607843137254),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage:profileimage==null? NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'): FileImage(profileimage!) as ImageProvider,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
    showModalBottomSheet<void>(
      backgroundColor:Colors.white,
    context: context,
    builder: (BuildContext context)
    {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('select photo'),
SizedBox(
  height: MediaQuery.of(context).size.height/15,
),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Icon(Icons.photo_library,),
                    onPressed: (){
                      getProfileImageByGallery();
                      Navigator.pop(context);
                    }

                  ),
                  ElevatedButton(
                      child: Icon(Icons.camera_alt),
                      onPressed: (){
                        getProfileImageByCam();
                        Navigator.pop(context);
                      }
                  ),

                ],
              ),
            ],
          ),
        ),
      );
    }
    );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
