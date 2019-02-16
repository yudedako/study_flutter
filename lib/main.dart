import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'かしかりメモ',
      home: new List(),
    );
  }
}

class List extends StatefulWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("リスト画面"),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  }
}
