import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:show_status_container/show_status_container.dart';

class BookRentSingle extends StatelessWidget {
  final BookRent bookRent;

  const BookRentSingle({required this.bookRent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Convertendo datas de String para DateTime
    final DateTime previsionDate =
        DateFormat('y-MM-dd').parse(bookRent.previsionDate);
    final DateTime rentalDate =
        DateFormat('y-MM-dd').parse(bookRent.rentalDate);
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
              ? FloatingActionButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => UserEditForm(
                    //       user: user,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Icon(Icons.check),
                  backgroundColor: Colors.green,
                  heroTag: null,
                )
              : SizedBox(height: 0),
          //Verificação para ver se vai precisar colocar espaçamento vertical entre os botões
          bookRent.devolutionDate == 'null'
              ? SizedBox(height: 20)
              : SizedBox(height: 0),
          bookRent.devolutionDate == 'null'
              ? FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.delete_forever_rounded),
                  heroTag: null,
                  backgroundColor: Colors.red[400],
                )
              : const SizedBox(width: 0)
        ],
      ),
    );
  }
}
