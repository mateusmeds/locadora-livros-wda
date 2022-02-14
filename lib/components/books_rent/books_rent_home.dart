import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books/book_register_form.dart';
import 'package:livraria_wda/components/books_rent/book_rent_register_form.dart';
import 'package:livraria_wda/components/books/books_list.dart';
import 'package:livraria_wda/components/books_rent/books_rent_list.dart';

import '../menu_drawer.dart';

class BooksRentHome extends StatelessWidget {
  const BooksRentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Aluguéis'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          children: const [
            BooksRentList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const BookRentRegisterForm(),
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
