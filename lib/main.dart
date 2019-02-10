import 'package:flutter/material.dart';

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
      initialRoute: '/first',
      routes: {
        '/first': (context) => FirstScreen(),
        '/second': (context) => SecondScreen('Second'),
        '/third': (context) => SecondScreen('Third'),
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
  //final _controller = TextEditingController();
  //String _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: Center(
        child: Text('Home Screen',
          style: TextStyle(fontSize: 32.0),
        ),
      ),

      // body: Column(
      //   children: <Widget>[
      //     Text('Home Screen',
      //       style: TextStyle(fontSize: 32.0)
      //     ),
      //     Padding(
      //       padding: EdgeInsets.all(10.0),
      //     ),
      //     TextField(
      //       controller: _controller,
      //       style: TextStyle(
      //         fontSize: 28.0,
      //         color: const Color(0xFFFF0000),
      //         fontWeight: FontWeight.w400,
      //         fontFamily: "Roboto"
      //       ),
      //       onChanged: changeField,
      //     ),
      //   ],
      // ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('next'),
            icon: Icon(Icons.navigate_next),
          ),
        ],

        onTap: (int value) {
          if (value == 1)
            Navigator.pushNamed(
              context,
              '/second',
              //MaterialPageRoute(builder: (context) => SecondScreen(_input)),
            );
        },
      ),
    );
  }

  //void changeField(String val) => _input = val;
}

class SecondScreen extends StatelessWidget {
  final String _value;

  SecondScreen(this._value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next"),
      ),

      body: Center(
        child: Text(
          '$_value Screen',
          style: TextStyle(fontSize: 32.0)
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('prev'),
            icon: Icon(Icons.navigate_before),
          ),
          BottomNavigationBarItem(
            title: Text('?'),
            icon: Icon(Icons.android),
          ),
        ],

        onTap: (int value) {
          if (value == 0) Navigator.pop(context);
          if (value == 1)
            Navigator.pushNamed(
              context,
              '/third',
            );
        },
      ),
    );
  }
}
