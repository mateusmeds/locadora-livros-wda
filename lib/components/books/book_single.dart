import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books/book_edit.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/providers/BookProvider.dart';
import 'package:provider/provider.dart';
import 'package:show_status_container/show_status_container.dart';

class BookSingle extends StatefulWidget {
  final Book book;

  const BookSingle({required this.book, Key? key}) : super(key: key);

  @override
  State<BookSingle> createState() => _BookSingleState();
}

class _BookSingleState extends State<BookSingle> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final bookAtt = bookProvider.bookById(widget.book.id);
    final msg = ScaffoldMessenger.of(context);

    void onDelete() {
      showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Excluir Livro'),
          content: const Text('Tem certeza?'),
          actions: [
            TextButton(
              child: const Text('Não'),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            TextButton(
                child: const Text('Sim'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  setState(() => _isLoading = true);
                }),
          ],
        ),
      ).then((value) async {
        if (value ?? false) {
          try {
            await Provider.of<BookProvider>(
              context,
              listen: false,
            ).removeBook(bookAtt).then((value) {
              Navigator.of(context).pop();
              msg.showSnackBar(
                SnackBar(
                  content: const Text(
                    'Livro excluído com sucesso.',
                    style: TextStyle(fontSize: 17),
                  ),
                  backgroundColor: Colors.green[400],
                  duration: const Duration(seconds: 5),
                ),
              );
            });
          } on HttpException catch (error) {
            msg.showSnackBar(
              SnackBar(
                content: Text(
                  error.toString().replaceAll('HttpException: ', 'Erro: '),
                  style: const TextStyle(fontSize: 17),
                ),
                backgroundColor: Colors.red[400],
                duration: const Duration(seconds: 5),
              ),
            );
          } finally {
            setState(() => _isLoading = false);
          }
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Livro'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.menu_book,
                        size: 55,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            bookAtt.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.my_library_books_rounded,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  bookAtt.publisher.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  bookAtt.author,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  bookAtt.releaseYear.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.event_available,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 5),
                              bookAtt.quantity > 0
                                  ? Text(
                                      'Disponíveis: ${bookAtt.quantity.toString()}')
                                  : const ShowStatusContainer(
                                      statusText: 'Indisponível',
                                      colorText: Colors.red,
                                      colorContainer: Colors.red,
                                      textFontSize: 17,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BookEditForm(
                    bookAtt,
                  ),
                ),
              );
            },
            heroTag: null,
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            child: Icon(Icons.delete_forever_rounded),
            onPressed: onDelete,
            heroTag: null,
            backgroundColor: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
