import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books/book_single.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:show_status_container/show_status_container.dart';

class BooksList extends StatelessWidget {
  final List<Book> books;
  const BooksList({required this.books, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (ctx, index) {
          final book = books[index];

          return Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: Card(
              color: Colors.grey[300],
              elevation: 5,
              child: ListTile(
                //espaçamento interno
                contentPadding: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                  left: 8,
                  right: 8,
                ),
                //avatar
                leading: const CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.menu_book_sharp,
                    size: 35,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => BookSingle(
                        book: book,
                      ),
                    ),
                  );
                },
                title: Text(
                  book.name,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.my_library_books_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            book.publisher.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            book.author,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        book.quantity > 0
                            ? const ShowStatusContainer(
                                statusText: 'Disponível',
                                colorText: Colors.green,
                                colorContainer: Colors.green,
                                textFontSize: 16,
                              )
                            : const ShowStatusContainer(
                                statusText: 'Indisponível',
                                colorText: Colors.red,
                                colorContainer: Colors.red,
                                textFontSize: 16,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
