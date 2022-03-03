import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/components/books_rent/book_rent_single.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:show_status_container/show_status_container.dart';

class BooksRentList extends StatelessWidget {
  final List<BookRent> booksRent;
  const BooksRentList({required this.booksRent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: booksRent.length,
        itemBuilder: (ctx, index) {
          final bookRent = booksRent[index];

          DateTime previsionDate;
          DateTime rentalDate;

          try {
            previsionDate = DateFormat('y-MM-dd').parse(bookRent.previsionDate);
            rentalDate = DateFormat('y-MM-dd').parse(bookRent.rentalDate);
          } catch (e) {
            previsionDate = DateFormat('dd/MM/y').parse(bookRent.previsionDate);
            rentalDate = DateFormat('dd/MM/y').parse(bookRent.rentalDate);
          }

          var devolutionDate = '';

          ///Controla se o prazo de entrega do livro foi ultrapassado
          bool returnedBookDelayed = false;

          if (bookRent.devolutionDate != '' &&
              bookRent.devolutionDate != 'null') {
            final DateTime devolutionDateParse =
                DateFormat('y-MM-dd').parse(bookRent.devolutionDate);

            //Verifica se o livro foi entregue atrasado
            if (devolutionDateParse.difference(previsionDate).inDays > 0) {
              returnedBookDelayed = true;
            }

            devolutionDate = DateFormat('dd/MM/y').format(devolutionDateParse);
          } else if (DateTime.now().difference(previsionDate).inDays > 0) {
            returnedBookDelayed = true;
          }

          return Container(
            margin: const EdgeInsets.all(5),
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
                      builder: (BuildContext context) => BookRentSingle(
                        bookRent: bookRent,
                      ),
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
                        bookRent.devolutionDate == 'null'
                            ? const ShowStatusContainer(
                                statusText: 'Não devolvido',
                                colorText: Colors.orange,
                                colorContainer: Colors.orange,
                              )
                            : const ShowStatusContainer(
                                statusText: 'Devolvido',
                                colorText: Colors.blue,
                                colorContainer: Colors.blue,
                              ),
                        const SizedBox(width: 5),
                        !returnedBookDelayed
                            ? const ShowStatusContainer(
                                statusText: 'No prazo',
                                colorText: Colors.green,
                                colorContainer: Colors.green,
                              )
                            : const ShowStatusContainer(
                                statusText: 'Atrasado',
                                colorText: Colors.red,
                                colorContainer: Colors.red,
                              )
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
