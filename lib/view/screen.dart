import 'package:flutter/material.dart';
import 'package:twitter_demo/view/account/account_page.dart';
import 'package:twitter_demo/view/time_line/post_page.dart';
import 'package:twitter_demo/view/time_line/time_line_page.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  List<Widget> pageList = [TimeLinePage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        unselectedIconTheme: IconThemeData(
          color: Colors.white54,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,),
              label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined,),
              label: '',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade300,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
        },
        child: Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
