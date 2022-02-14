import 'package:flutter/material.dart';
import 'package:livraria_wda/components/books_rent/book_rent_single.dart';
import 'package:livraria_wda/main.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:livraria_wda/models/user.dart';

class BooksRentList extends StatelessWidget {
  const BooksRentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BookRent> booksRent = [
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
      BookRent(
          1,
          User(1, 'Mateus Medeiros', 'mateusmedeiros@mail.com',
              'Rua Teste, 458', 'Natal'),
          Book(1, 'Miguel de Cervantes', 'Dom Quixote',
              Publisher(1, 'Aleph', 'Natal'), 5, 1605, 0),
          '2021-02-15',
          '2021-02-28',
          ''),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: booksRent.length,
        itemBuilder: (ctx, index) {
          final bookRent = booksRent[index];

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
                    Icons.date_range,
                    size: 35,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => BookRentSingle(bookRent: bookRent,),
                    ),
                  );
                },
                title: Text(
                  bookRent.book.name,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            bookRent.user.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text(
                              'Não devolvido',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.red),
                            ),
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
