import 'package:flutter/material.dart';

class UserRegisterForm extends StatefulWidget {
  const UserRegisterForm({Key? key}) : super(key: key);

  @override
  _UserRegisterFormState createState() => _UserRegisterFormState();
}

class _UserRegisterFormState extends State<UserRegisterForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();

  ///Função responsável por fechar a modal
  _closeUserRegisterFormModal(BuildContext context) {
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
          Icon(
            Icons.person_add_alt_1,
            size: 90,
          ),
          const SizedBox(height: 20),
          Text("Cadastrar Usuário"),
          const SizedBox(height: 20),
          //TODO: Alterar os ícones
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nome',
              suffixIcon: Icon(Icons.add),
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Endereço',
              suffixIcon: Icon(Icons.add),
            ),
          ),
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              labelText: 'Cidade',
              suffixIcon: Icon(Icons.add),
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              suffixIcon: Icon(Icons.add),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => _closeUserRegisterFormModal(context),
                  child: Text('Cancelar'),
                  style: TextButton.styleFrom(primary: Colors.red[400])),
              ElevatedButton(
                onPressed: () {
                  debugPrint(nameController.text);
                  debugPrint(addressController.text);
                  debugPrint(cityController.text);
                  debugPrint(emailController.text);
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
