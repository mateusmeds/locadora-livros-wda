import 'package:flutter/material.dart';
import 'package:livraria_wda/components/list_empty.dart';
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

  String filterText = "";

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Usuários');

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
    final List<User> list =
        filterText.isEmpty ? userProvider.users : userProvider.usersSearch;

    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customSearchBar = ListTile(
                    title: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'Pesquisar...',
                          hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.all(0)),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (text) {
                        setState(() {
                          filterText = text;
                          userProvider.filterUsers(text: text);
                        });
                      },
                    ),
                  );
                  customIcon = const Icon(Icons.cancel);
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Usuários');
                  filterText = "";
                }
              });
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Visibility(
                  visible: !_isError && list.length > 0,
                  child: UserList(list),
                  replacement: ListEmptyMessage(
                    message: 'Nenhum usuário encontrado.',
                    icon: Icons.person,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const UserRegisterForm(),
            ),
          );
        },
      ),
      drawer: const Drawer(
        child: MenuDrawer(),
      ),
    );
  }
}
