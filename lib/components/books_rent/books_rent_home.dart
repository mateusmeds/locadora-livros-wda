import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books_rent/book_rent_register_form.dart';
import 'package:livraria_wda/components/books_rent/books_rent_list.dart';
import 'package:livraria_wda/components/list_empty.dart';
import 'package:livraria_wda/models/book_rent.dart';
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

  String filterText = "";

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Aluguéis');

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
    final List<BookRent> list = filterText.isEmpty
        ? bookRentProvider.booksRental
        : bookRentProvider.booksRentSearch;
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
                          bookRentProvider.filterBooksRent(text: text);
                        });
                      },
                    ),
                  );
                  customIcon = const Icon(Icons.cancel);
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Aluguéis');
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
                    visible: !_isError && list.isNotEmpty,
                    child: BooksRentList(booksRent: list),
                    replacement: ListEmptyMessage(
                      message: 'Nenhum aluguel encontrado.',
                      icon: Icons.date_range,
                    )),
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
