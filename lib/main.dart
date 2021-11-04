import 'package:example_workshop/tabs/list.dart';
import 'package:example_workshop/tabs/sensor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: 
            AppBar(
              title: const Text("Flutter Demo"),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.sensors)),
                ],
              ),
            ),
          body: TabBarView(
            children: [
              ListTab(),
              SensorTab()
            ],
            )
          ),
        )
    );
  }
}
