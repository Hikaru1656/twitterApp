
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_demo/model/account.dart';
import 'package:twitter_demo/utils/authentication.dart';
import 'package:twitter_demo/utils/firestore/users.dart';
import 'package:twitter_demo/utils/function_utils.dart';
import 'package:twitter_demo/utils/widget_utils.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  File? image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('アカウント作成'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30),
              GestureDetector(
                onTap: () async{
                  var result = await FunctionUtils.getImageFromGallery();
                  if(result != null) {
                    setState(() {
                      image = File(result.path);
                    });
                  }
                  },
                child: CircleAvatar(
                  foregroundImage: image == null ? null : FileImage(image!),
                  radius: 40,
                  backgroundColor: Colors.brown,
                  child: Icon(Icons.add, color: Colors.brown.shade50),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: '名前'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(hintText: 'ユーザーID'),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: selfIntroductionController,
                  decoration: InputDecoration(hintText: '自己紹介'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Eメール'),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(hintText: 'パスワード'),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                ),
                  onPressed: () async{
                    if(
                    nameController.text.isNotEmpty &&
                    userIdController.text.isNotEmpty &&
                    selfIntroductionController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passController.text.isNotEmpty &&
                    image != null
                    ) {
                      var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                      if(result is UserCredential) {
                        String imagePath = await FunctionUtils.uploadImage(result.user!.uid, image!);
                        Account newAccount = Account(
                          id: result.user!.uid,
                          name: nameController.text,
                          userId: userIdController.text,
                          selfIntroduction: selfIntroductionController.text,
                          imagePath: imagePath,
                        );
                        var _result = await UserFirestore.setUser(newAccount);
                        if(_result == true) {
                          Navigator.pop(context);
                        }
                      }
                    }
                  },
                  child: Text('アカウントを作成'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
