import 'package:flutter/material.dart';
import 'package:livraria_wda/models/user.dart';

class UserEditForm extends StatefulWidget {
  User user;

  UserEditForm(this.user, {Key? key}) : super(key: key);

  @override
  _UserEditFormState createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();

  ///Função responsável por fechar a modal
  _closeUserEditFormModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.user.name);
    final addressController = TextEditingController(text: widget.user.address);
    final cityController = TextEditingController(text: widget.user.city);
    final emailController = TextEditingController(text: widget.user.email);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person,
              size: 90,
            ),
            const SizedBox(height: 20),
            //TODO: Alterar os ícones
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Endereço',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Cidade',
                prefixIcon: Icon(Icons.location_city_rounded),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.mail),
              ),
            ),  
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint(nameController.text);
          debugPrint(addressController.text);
          debugPrint(cityController.text);
          debugPrint(emailController.text);
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.save),
      ),
    );
  }
}
