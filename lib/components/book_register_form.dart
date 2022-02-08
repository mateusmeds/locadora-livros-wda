import 'package:flutter/material.dart';

class BookRegisterForm extends StatefulWidget {

  final BuildContext context;

  const BookRegisterForm(this.context, {Key? key}) : super(key: key);

  @override
  _BookRegisterFormState createState() => _BookRegisterFormState();
}

class _BookRegisterFormState extends State<BookRegisterForm> {
  final nameController = TextEditingController();
  final publisherController = TextEditingController();
  final authorController = TextEditingController();
  final releaseYearController = TextEditingController();
  final quantityController = TextEditingController();

  ///Função responsável por fechar a modal
  _closeBookRegisterFormModal(BuildContext context) {
    Navigator.of(context).pop();
  }

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
          const SizedBox(height: 10),
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => _closeBookRegisterFormModal(context),
                  child: Text('Cancelar'),
                  style: TextButton.styleFrom(primary: Colors.red[400])),
              ElevatedButton(
                onPressed: () {
                  //Apagar
                  debugPrint("Nome => ${nameController.text}");
                  debugPrint("Editora => ${publisherController.text}");
                  debugPrint("Autor => ${authorController.text}");
                  debugPrint("Ano de lançamento => ${releaseYearController.text}");
                  debugPrint("Quantidade => ${quantityController.text}");
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
