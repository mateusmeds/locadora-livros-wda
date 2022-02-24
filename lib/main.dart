import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:livraria_wda/components/menu_drawer.dart';
import 'package:livraria_wda/providers/BookProvider.dart';
import 'package:livraria_wda/providers/BookRentProvider.dart';
import 'package:livraria_wda/providers/PublisherProvider.dart';
import 'package:livraria_wda/providers/UserProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => PublisherProvider()),
        ChangeNotifierProvider(create: (ctx) => BookProvider()),
        ChangeNotifierProvider(create: (ctx) => BookRentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
      ),
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
      body: Center(
        
        child: Image.asset('wda.png', height: 100)
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
