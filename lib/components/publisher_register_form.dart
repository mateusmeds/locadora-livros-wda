import 'package:flutter/material.dart';

class PublisherRegisterForm extends StatefulWidget {
  const PublisherRegisterForm({Key? key}) : super(key: key);

  @override
  _PublisherRegisterFormState createState() => _PublisherRegisterFormState();
}

class _PublisherRegisterFormState extends State<PublisherRegisterForm> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const Text("Cadastrar Editora"),
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
            decoration: const  InputDecoration(
              labelText: 'Cidade',
              suffixIcon: Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //TODO: Adicionar evento de fechar a modal ao clicar em 'cancelar'
              TextButton(
                  onPressed: () {},
                  child: Text('Cancelar'),
                  style: TextButton.styleFrom(primary: Colors.red[400])),
              ElevatedButton(
                onPressed: () {
                  //Apagar
                  debugPrint(nameController.text);
                  debugPrint(cityController.text);
                },
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(primary: Colors.green[700]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
