import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookRentRegisterForm extends StatefulWidget {
  const BookRentRegisterForm({Key? key}) : super(key: key);

  @override
  _BookRentRegisterFormState createState() => _BookRentRegisterFormState();
}

class _BookRentRegisterFormState extends State<BookRentRegisterForm> {
  final rentalDate = DateTime.now();
  final userController = TextEditingController();
  final bookController = TextEditingController();
  final rentalDateController = TextEditingController();
  final previsionDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Aluguel'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.date_range_rounded,
                size: 90,
              ),
              const SizedBox(height: 20),
              //TODO: alterar os ícones
              //TODO: tornar input selecionável com os usários
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),
              //TODO: colocar input selecionável com a lista de livros
              TextField(
                controller: bookController,
                decoration: const InputDecoration(
                  labelText: 'Livro',
                  prefixIcon: Icon(Icons.menu_book_sharp),
                ),
              ),
              TextField(
                controller: rentalDateController,
                decoration: const InputDecoration(
                  labelText: 'Data de aluguel',
                  prefixIcon: Icon(Icons.date_range),
                ),
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 7)),
                    lastDate: DateTime.now(),
                  ).then((pickedDate) {
                    if (pickedDate == null) {
                      return;
                    }

                    setState(() {
                      rentalDateController.text =
                          DateFormat('dd/MM/y').format(pickedDate);
                    });
                  });
                },
              ),
              TextField(
                controller: previsionDateController,
                decoration: const InputDecoration(
                  labelText: 'Data de previsão',
                  prefixIcon: Icon(Icons.date_range),
                ),
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 7)),
                    lastDate: DateTime.now().add(Duration(days: 90)),
                  ).then((pickedDate) {
                    if (pickedDate == null) {
                      return;
                    }

                    setState(() {
                      previsionDateController.text = DateFormat('dd/MM/y').format(pickedDate);
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.save,
          size: 30,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
