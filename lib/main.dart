//import 'dart:js_util';

//import 'package:flutter/material.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 1, 44, 13)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aladhami Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool pageback = true;
  bool isLoadingItemsFromDatabase = false;
  List<Item> items = [
    Item('Fakhri', 'aladhami', 101, 'Saver'),
    Item('Ali', 'Ahmed', 501, 'Spender'),
    Item('John', 'Laser', 865, 'Occasional'),
    Item('Seri', 'Done', 796, 'Frequent'),
    Item('Cris', 'Miler', 201, 'Spender'),
    Item('Leo', 'messi', 140, 'Saver'),
    Item('Elizabeth', 'Mopez', 651, 'Frequent'),
    Item('Derian', 'Dammon', 824, 'Occasional'),
    Item('Crown', 'Flower', 613, 'Saver'),
    Item('Ronaldo', 'love', 528, 'Player'),
  
  ];
  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });
  

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
      });
    });
  }
    void _restartPage() {
      setState(() {

        Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load items from Database"),
              )
            : isLoadingItemsFromDatabase
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Please wait")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items.map((Item) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text('First Name: ${Item.firstName}'),
                            ),
                            Container(
                              child: Text('Last Name: ${Item.lastName}'),
                            ),
                            Container(
                              child: Text('Id: ${Item.id}'),
                            ),
                            Container(
                              child: Text('Type: ${Item.type}'),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                  )),
      ),
      floatingActionButton: pageFirstLoad
          ? null 
          : FloatingActionButton(
              onPressed: _restartPage, 
              tooltip: 'Reset Page',
              child: Icon(Icons.add),
            ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Item {
  String firstName;
  String lastName;
  int id;
  String type;
  Item(this.firstName, this.lastName, this.id, this.type);
}
