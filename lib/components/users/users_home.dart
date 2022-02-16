import 'package:flutter/material.dart';
import 'package:livraria_wda/components/users/user_list.dart';
import 'package:livraria_wda/components/users/user_register_form.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:livraria_wda/providers/UserProvider.dart';
import 'package:provider/provider.dart';

import '../menu_drawer.dart';

class UsersHome extends StatefulWidget {
  UsersHome({Key? key}) : super(key: key);

  @override
  State<UsersHome> createState() => _UsersHomeState();
}

class _UsersHomeState extends State<UsersHome> {
  bool _isLoading = true;
  bool _isError = false;
  

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).loadUsers().then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuários'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  _isError
                      ? Text('Nenhum usuário encontrado.')
                      : UserList(userProvider.users),
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
