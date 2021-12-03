import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_demo/model/account.dart';
import 'package:twitter_demo/model/post.dart';
import 'package:twitter_demo/utils/authentication.dart';
import 'package:twitter_demo/view/account/edit_account_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

  List<Post> postList = [
    Post(
      id: '1',
      content: 'はじめまして,わたしは高崎光とお申します。どうぞよろしくお願いいたします。',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '2',
      content: 'またあいましたね',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  foregroundImage: NetworkImage(myAccount.imagePath),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Text(myAccount.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      ),
                                      Text('@${myAccount.userId}', style: TextStyle(color: Colors.black.withOpacity(0.5))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                              onPressed: () async{
                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountPage()));
                                if(result == true) {
                                  setState(() {
                                    myAccount = Authentication.myAccount!;
                                  });
                                }
                              },
                              child: Text('編集'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Text(myAccount.selfIntroduction),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.black87, width: 0.5
                    ))
                  ),
                ),
                Expanded(child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          border: index == 0 ?
                          Border(top: BorderSide(color: Colors.black87, width: 0),
                              bottom: BorderSide(color: Colors.black87, width: 0))
                              : Border(
                            bottom: BorderSide(color: Colors.black87, width: 0),
                          )
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            foregroundImage: NetworkImage(myAccount.imagePath),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(myAccount.name, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(DateFormat('MM/dd/yyyy').format(postList[index].createdTime!)),
                                          Text(DateFormat('HH:mm').format(postList[index].createdTime!)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    child: Text(postList[index].content),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
