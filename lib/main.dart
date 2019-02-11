import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new FirstScreen(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => FirstScreen(),
        '/list': (context) => SecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key); // コンストラクタ

  @override
  _FirstScreenState createState() => new _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();

  final TextStyle styleA = TextStyle(
    fontSize: 28.0,
    color: Colors.black87,
  );
  final TextStyle styleB = TextStyle(
    fontSize: 24.0,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Home Screen',
              style: TextStyle(fontSize: 32.0),
            ),

            Text( 'Name:', style: styleB, ),
            TextField(
              controller: _controllerA,
              style: styleA,
            ),

            Text( 'Mail:', style: styleB, ),
            TextField(
              controller: _controllerB,
              style: styleA,
            ),

            Text( 'Tel:', style: styleB, ),
            TextField(
              controller: _controllerC,
              style: styleA,
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('add'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('list'),
            icon: Icon(Icons.list),
          ),
        ],

        onTap: (int value) {
          if (value == 1) {
            Navigator.pushNamed(context, '/list');
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          saveData();
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("saved!"),
              content: Text("insert data  into database."),
            )
          );
        },
      ),
    );
  }

  void saveData() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "mydata.db");

    String data1 = _controllerA.text;
    String data2 = _controllerB.text;
    String data3 = _controllerC.text;

    String query = 'INSERT INTO mydata(name, mail, tel) VALUES("$data1", "$data2", "$data3")';

    Database database = await openDatabase(
      path, version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS mydata (id INTEGER PRIMARY KEY, name TEXT, mail TEXT, tel TEXT)"
        );
      }
    );

    await database.transaction((txn) async {
      int id = await txn.rawInsert(query);
      print("insert: $id");
    });

    setState(() {
      _controllerA.text = '';
      _controllerB.text = '';
      _controllerC.text = '';
    });
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen({ Key key }) : super(key: key);

  @override
  _SecondScreenState createState() => new _SecondScreenState();
}

class _SecondScreenState extends State <SecondScreen> {
  List<Widget> _items = <Widget>[];

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),

      body: ListView(
        children: _items,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('add'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('list'),
            icon: Icon(Icons.list),
          ),
        ],

        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void getItems() async {
    List<Widget> list = <Widget>[];
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "mydata.db");

    Database database = await openDatabase(
      path, version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS mydata (id INTEGER PRIMARY KEY, name TEXT, mail TEXT, tel TEXT)"
        );
      }
    );

    List<Map> result = await database.rawQuery('SELECT * FROM mydata');

    for (Map item in result) {
      list.add(
        ListTile(
          title: Text(item['name']),
          subtitle: Text(item['mail'] + ' ' + item['tel']),
        )
      );
    }

    setState(() {
      _items = list;
    });
  }
}
