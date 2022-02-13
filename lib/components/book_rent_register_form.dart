import 'package:flutter/material.dart';

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
  final devolutionDateController = TextEditingController();

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
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 10),
              //TODO: colocar input selecionável com a lista de livros
              TextField(
                controller: bookController,
                decoration: const InputDecoration(
                  labelText: 'Livro',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              //TODO: ao clicar, abrir calendário para selecionar a data
              TextField(
                controller: rentalDateController,
                decoration: const InputDecoration(
                  labelText: 'Data de aluguel',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              TextField(
                controller: devolutionDateController,
                decoration: const InputDecoration(
                  labelText: 'Data de previsão',
                  suffixIcon: Icon(Icons.add),
                ),
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
