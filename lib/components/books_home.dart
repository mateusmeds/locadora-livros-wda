import 'package:flutter/material.dart';
import 'package:livraria_wda/components/book_register_form.dart';
import 'package:livraria_wda/components/books_list.dart';
import 'package:livraria_wda/components/publisher_register_form.dart';
import 'package:livraria_wda/components/publishers_list.dart';

import 'menu_drawer.dart';

class BooksHome extends StatelessWidget {
  const BooksHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Editoras'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          children: const [
            BooksList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const BookRegisterForm(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
