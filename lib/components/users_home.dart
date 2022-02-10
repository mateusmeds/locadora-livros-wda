import 'package:flutter/material.dart';
import 'package:livraria_wda/components/menu_drawer.dart';
import 'package:livraria_wda/components/user_list.dart';
import 'package:livraria_wda/components/user_register_form.dart';

class UsersHome extends StatelessWidget {
  final String title;

  const UsersHome({required this.title, Key? key}) : super(key: key);

  ///Função responsável por abrir a modal
  _openUserRegisterFormModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return UserRegisterForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openUserRegisterFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openUserRegisterFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
