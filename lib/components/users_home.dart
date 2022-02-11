import 'package:flutter/material.dart';
import 'package:livraria_wda/components/user_list.dart';
import 'package:livraria_wda/components/user_register_form.dart';

import 'menu_drawer.dart';

class UsersHome extends StatelessWidget {

  const UsersHome({Key? key}) : super(key: key);

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
        title: Text('Lista de usuários'),

      ),
      body: Column(
        children: [
          UserList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openUserRegisterFormModal(context),
        child: Icon(Icons.person_add_alt_1, size: 30,)
      ),
            drawer: Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
