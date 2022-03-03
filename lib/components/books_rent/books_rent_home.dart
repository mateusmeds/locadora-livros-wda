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
      if (value) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookRentProvider = Provider.of<BookRentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Aluguéis'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _isError
                    ? ListEmptyMessage(
                        message: 'Nenhum aluguel encontrado.',
                        icon: Icons.date_range,
                      )
                    : BooksRentList(
                        booksRent: bookRentProvider.booksRental,
                      ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const BookRentRegisterForm(),
            ),
          );
        },
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
