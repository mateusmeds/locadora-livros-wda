import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:livraria_wda/providers/BookRentProvider.dart';
import 'package:provider/provider.dart';
import 'package:show_status_container/show_status_container.dart';

class BookRentSingle extends StatelessWidget {
  final BookRent bookRent;

  const BookRentSingle({required this.bookRent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final msg = ScaffoldMessenger.of(context);

    //Convertendo datas de String para DateTime
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

    bool returnedBookDelayed = false;

    if (bookRent.devolutionDate != '' && bookRent.devolutionDate != 'null') {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aluguel de Livro'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.date_range,
                  size: 55,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      bookRent.book.name,
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
                          Icons.person,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            bookRent.user.name,
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
                          Icons.email,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            bookRent.user.email,
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
                            'Data de aluguel: ${DateFormat('dd/MM/y').format(rentalDate)}',
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
                            'Data de previsão: ${DateFormat('dd/MM/y').format(previsionDate)}',
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
                            'Data de devolução: $devolutionDate',
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
                        bookRent.devolutionDate == 'null'
                            ? const ShowStatusContainer(
                                statusText: 'Não devolvido',
                                colorText: Colors.orange,
                                colorContainer: Colors.orange,
                                textFontSize: 17,
                              )
                            : const ShowStatusContainer(
                                statusText: 'Devolvido',
                                colorText: Colors.blue,
                                colorContainer: Colors.blue,
                                textFontSize: 17,
                              ),
                        const SizedBox(width: 10),
                        !returnedBookDelayed
                            ? const ShowStatusContainer(
                                statusText: 'No prazo',
                                colorText: Colors.green,
                                colorContainer: Colors.green,
                                textFontSize: 17,
                              )
                            : const ShowStatusContainer(
                                statusText: 'Atrasado',
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
          bookRent.devolutionDate == 'null'
              ? FloatingActionButton.extended(
                  label: Text('Devolver'),
                  icon: Icon(Icons.check),
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Devolver Livro'),
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
                              }),
                        ],
                      ),
                    ).then((value) async {
                      if (value ?? false) {
                        try {
                          await Provider.of<BookRentProvider>(
                            context,
                            listen: false,
                          ).returnBook(bookRent).then((value) {
                            Navigator.of(context).pop();
                            msg.showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Livro devolvido com sucesso.',
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
                                error
                                    .toString()
                                    .replaceAll('HttpException: ', 'Erro: '),
                                style: const TextStyle(fontSize: 17),
                              ),
                              backgroundColor: Colors.red[400],
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                      }
                    });
                  },
                  heroTag: null,
                )
              : const SizedBox(height: 0),
          //Verificação para ver se vai precisar colocar espaçamento vertical entre os botões
          bookRent.devolutionDate == 'null'
              ? const SizedBox(height: 20)
              : const SizedBox(height: 0),
          bookRent.devolutionDate == 'null'
              ? FloatingActionButton.extended(
                  label: Text('Cancelar'),
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Cancelar Aluguel'),
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
                              }),
                        ],
                      ),
                    ).then((value) async {
                      if (value ?? false) {
                        try {
                          await Provider.of<BookRentProvider>(
                            context,
                            listen: false,
                          ).removeBookRental(bookRent).then((value) {
                            Navigator.of(context).pop();
                            msg.showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Aluguel cancelado com sucesso.',
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
                                error
                                    .toString()
                                    .replaceAll('HttpException: ', 'Erro: '),
                                style: const TextStyle(fontSize: 17),
                              ),
                              backgroundColor: Colors.red[400],
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                      }
                    });
                  },
                  heroTag: null,
                  backgroundColor: Colors.red[400],
                )
              : const SizedBox(width: 0)
        ],
      ),
    );
  }
}
