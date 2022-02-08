import 'package:flutter/material.dart';

class BookRentRegisterForm extends StatefulWidget {

  final BuildContext context;

  const BookRentRegisterForm(this.context, {Key? key}) : super(key: key);

  @override
  _BookRentRegisterFormState createState() => _BookRentRegisterFormState();
}

class _BookRentRegisterFormState extends State<BookRentRegisterForm> {
  final rentalDate = DateTime.now();
  final userController = TextEditingController();
  final bookController = TextEditingController();
  final devolutionDateController = TextEditingController();

  ///Função responsável por fechar a modal
  _closeBookRentFormModal(BuildContext context) {
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
          const Text("Cadastrar Aluguel de Livro"),
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
            controller: devolutionDateController,
            decoration: const InputDecoration(
              labelText: 'Data de devolução',
              suffixIcon: Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => _closeBookRentFormModal(context),
                  child: const Text('Cancelar'),
                  style: TextButton.styleFrom(primary: Colors.red[400])),
              ElevatedButton(
                onPressed: () {
                  //Apagar
                  debugPrint("Usuário => ${userController.text}");
                  debugPrint("Livro => ${bookController.text}");
                  debugPrint("Data de devolução => ${devolutionDateController.text}");
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
