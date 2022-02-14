import 'package:flutter/material.dart';
import 'package:livraria_wda/components/users/user_list.dart';
import 'package:livraria_wda/components/users/user_register_form.dart';

import '../menu_drawer.dart';

class UsersHome extends StatelessWidget {
  const UsersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuários'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          children: const [
            UserList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const UserRegisterForm(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}