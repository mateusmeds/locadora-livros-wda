import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books/book_register_form.dart';
import 'package:livraria_wda/components/books/books_list.dart';
import 'package:livraria_wda/components/list_empty.dart';
import 'package:livraria_wda/models/book.dart';
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

  String filterText = "";
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Livros');

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
    final List<Book> list =
        filterText.isEmpty ? bookProvider.books : bookProvider.booksSearch;

    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customSearchBar = ListTile(
                    title: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'Pesquisar...',
                          hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.all(0)),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (text) {
                        setState(() {
                          filterText = text;
                          bookProvider.filterBooks(text: text);
                        });
                      },
                    ),
                  );
                  customIcon = const Icon(Icons.cancel);
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Livros');
                  filterText = "";
                }
              });
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Visibility(
                    visible: !_isError && list.length > 0,
                    child: BooksList(books: list),
                    replacement: ListEmptyMessage(
                      message: 'Nenhum livro encontrado.',
                      icon: Icons.menu_book_sharp,
                    )),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const BookRegisterForm(),
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
