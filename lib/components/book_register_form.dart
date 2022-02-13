import 'package:flutter/material.dart';

class BookRegisterForm extends StatefulWidget {
  const BookRegisterForm({Key? key}) : super(key: key);

  @override
  _BookRegisterFormState createState() => _BookRegisterFormState();
}

class _BookRegisterFormState extends State<BookRegisterForm> {
  final nameController = TextEditingController();
  final publisherController = TextEditingController();
  final authorController = TextEditingController();
  final releaseYearController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Livro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.menu_book_sharp,
                size: 90,
              ),
              const SizedBox(height: 20),
              const Text("Cadastrar Livro"),
              const SizedBox(height: 20),
              //TODO: alterar os ícones
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              //TODO: colocar input selecionável com a lista de editoras
              TextField(
                controller: publisherController,
                decoration: const InputDecoration(
                  labelText: 'Editora',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              TextField(
                controller: releaseYearController,
                decoration: const InputDecoration(
                  labelText: 'Ano de lançamento',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              //TODO: colocar input de incrementar e decrementar
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
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
