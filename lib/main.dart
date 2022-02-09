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
      home: const MyHomePage(title: 'Livraria WDA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///Função responsável por abrir a modal
  _openBookRentRegisterFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return BookRentRegisterForm(context);
        });
  }

  ///Função responsável por abrir a modal
  _openBookRegisterFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return BookRegisterForm(context);
        });
  }

  ///Função responsável por abrir a modal
  _openPublisherRegisterFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return PublisherRegisterForm();
        });
  }

  ///Função responsável por abrir a modal
  _openUserRegisterFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return UserRegisterForm();
        });
  }

  ///Função responsável por fechar a modal
  _closeUserRegisterFormModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () => _openUserRegisterFormModal(context),
              child: Text("Form Usuário"),
            ),
            TextButton(
              onPressed: () => _openPublisherRegisterFormModal(context),
              child: Text("Form Editora"),
            ),
            TextButton(
              onPressed: () => _openBookRegisterFormModal(context),
              child: Text("Form Livro"),
            ),
            TextButton(
              onPressed: () => _openBookRentRegisterFormModal(context),
              child: Text("Form Empréstimo de Livro"),
            ),
            UserList(),
          ],
        ),
      ),
      drawer: Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
