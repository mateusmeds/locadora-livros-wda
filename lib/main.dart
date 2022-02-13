import 'package:flutter/material.dart';
import 'package:livraria_wda/components/menu_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

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
        title: const Text('WDA Livraria'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text('Página Home'),
          ],
        ),
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
