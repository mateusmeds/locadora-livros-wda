import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books_rent/book_rent_register_form.dart';
import 'package:livraria_wda/components/books_rent/books_rent_list.dart';
import 'package:livraria_wda/components/list_empty.dart';
import 'package:livraria_wda/providers/BookRentProvider.dart';
import 'package:provider/provider.dart';

import '../menu_drawer.dart';

class BooksRentHome extends StatefulWidget {
  const BooksRentHome({Key? key}) : super(key: key);

  @override
  State<BooksRentHome> createState() => _BooksRentHomeState();
}

class _BooksRentHomeState extends State<BooksRentHome> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    Provider.of<BookRentProvider>(
      context,
      listen: false,
    ).loadBooksRental().then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
        _isError = true;
        print(onError);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookRentProvider = Provider.of<BookRentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Aluguéis'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  _isError
                      ? ListEmptyMessage(
                          message: 'Nenhum aluguél encontrado.',
                          icon: Icons.person,
                        )
                      : BooksRentList(
                          booksRent: bookRentProvider.booksRental,
                        ),
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
