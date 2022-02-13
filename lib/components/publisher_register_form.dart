import 'package:flutter/material.dart';

class PublisherRegisterForm extends StatefulWidget {
  const PublisherRegisterForm({Key? key}) : super(key: key);

  @override
  _PublisherRegisterFormState createState() => _PublisherRegisterFormState();
}

class _PublisherRegisterFormState extends State<PublisherRegisterForm> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();

  ///Função responsável por fechar a modal
  _closePublisherRegisterFormModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Editora'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.my_library_books_rounded,
                size: 90,
              ),
              const SizedBox(height: 20),
              //TODO: Alterar os ícones
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
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
