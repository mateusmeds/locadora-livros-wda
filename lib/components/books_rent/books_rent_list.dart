import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/components/books_rent/book_rent_single.dart';
import 'package:livraria_wda/models/book_rent.dart';

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

          final DateTime previsionDate =
              DateFormat('y-MM-dd').parse(bookRent.previsionDate);
          final DateTime rentalDate =
              DateFormat('y-MM-dd').parse(bookRent.rentalDate);
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
          }

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
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: bookRent.devolutionDate == 'null'
                                    ? Colors.orange
                                    : Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: bookRent.devolutionDate == 'null'
                                ? Text(
                                    'Não devolvido',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.orange),
                                  )
                                : Text(
                                    'Devolvido',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                          ),
                        ),
                        !returnedBookDelayed
                            ? Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.green),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Text(
                                    'No prazo',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              )
                            : Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.red),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Text(
                                    'Atrasado',
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
