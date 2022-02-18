import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books/book_register_form.dart';
import 'package:livraria_wda/components/books/books_list.dart';
import 'package:livraria_wda/components/list_empty.dart';
import 'package:livraria_wda/providers/BookProvider.dart';
import 'package:provider/provider.dart';

import '../menu_drawer.dart';

class BooksHome extends StatefulWidget {
  const BooksHome({Key? key}) : super(key: key);

  @override
  State<BooksHome> createState() => _BooksHomeState();
}

class _BooksHomeState extends State<BooksHome> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    Provider.of<BookProvider>(
      context,
      listen: false,
    ).loadBooks().then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Livros'),
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
                          message: 'Nenhum livro encontrado.',
                          icon: Icons.menu_book_sharp,
                        )
                      : BooksList(books: bookProvider.books),
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
