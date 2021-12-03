import 'package:flutter/material.dart';

class WidgetUtils {
  static PreferredSize createAppBar(String title) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: Colors.black87,
              elevation: 0.5,
              title: Text(title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
