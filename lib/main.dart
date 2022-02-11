import 'package:flutter/material.dart';
import 'package:livraria_wda/components/book_register_form.dart';
import 'package:livraria_wda/components/book_rent_register_form.dart';
import 'package:livraria_wda/components/menu_drawer.dart';
import 'package:livraria_wda/components/publisher_register_form.dart';
import 'package:livraria_wda/components/user_list.dart';
import 'package:livraria_wda/components/user_register_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'WDA Livraria';
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //só para a tela não ficar muito branca e confundir no navegador
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          ],
        ),
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
