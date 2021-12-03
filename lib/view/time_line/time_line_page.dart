import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_demo/model/account.dart';
import 'package:twitter_demo/model/post.dart';
import 'package:twitter_demo/view/time_line/post_page.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'hipomaru',
    selfIntroduction: 'こんにちは',
    userId: 'dgafjiagrfi',
    imagePath: 'https://beefup.work/wp-content/uploads/2019/10/logo_lockup_flutter_horizontal.png',
    createdTime: Timestamp.now(),
    updatedTime: Timestamp.now(),
  );

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                centerTitle: true,
                backgroundColor: Colors.black87,
                elevation: 0.5,
                title: Text('タイムライン',

                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.brown.withOpacity(0.1),
        child: ListView.builder(
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
        ),
      ),
    );
  }
}
