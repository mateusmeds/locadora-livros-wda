import 'package:flutter/material.dart';
import 'package:livraria_wda/components/book_single.dart';
import 'package:livraria_wda/main.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/publisher.dart';

class BooksList extends StatelessWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Book> books = [
      Book(1, 'Miguel de Cervantes', 'Dom Quixote',
          Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
      Book(2, 'Liev Tolstói', 'Guerra e Paz', Publisher(2, 'Suma', 'São Paulo'),
          3, 1869, 0),
      Book(3, 'Thomas Mann', 'A Montanha Mágica',
          Publisher(3, 'Darkside Books', 'Rio de Janeiro'), 10, 1924, 0),
      Book(4, 'Gabriel García Márquez', 'Cem Anos de Solidão',
          Publisher(3, 'Editora Rocco', 'Rio de Janeiro'), 30, 1967, 0),
      Book(5, 'Liev Tolstói', 'Gabriel García Márquez',
          Publisher(3, 'Editora Intrínseca', 'Fortaleza'), 6, 1913, 0),
    ];

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
                      builder: (BuildContext context) => BookSingle(book: book,),
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
