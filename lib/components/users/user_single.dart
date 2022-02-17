import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/components/users/user_edit.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:livraria_wda/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class UserSingle extends StatelessWidget {
  final User user;

  const UserSingle({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userAtt = userProvider.userById(user.id);
    final msg = ScaffoldMessenger.of(context);

    void onDelete() {
      showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Excluir Usuario'),
          content: const Text('Tem certeza?'),
          actions: [
            TextButton(
              child: const Text('Não'),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            TextButton(
                child: const Text('Sim'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                }),
          ],
        ),
      ).then((value) async {
        if (value ?? false) {
          try {
            await Provider.of<UserProvider>(
              context,
              listen: false,
            ).removeUser(userAtt).then((value) {
              Navigator.of(context).pop();
              msg.showSnackBar(
                SnackBar(
                  content: Text(
                    'Usuário excluído com sucesso.',
                    style: TextStyle(fontSize: 17),
                  ),
                  backgroundColor: Colors.green[400],
                  duration: Duration(seconds: 5),
                ),
              );
            });
          } on HttpException catch (error) {
            msg.showSnackBar(
              SnackBar(
                content: Text(
                  error.toString().replaceAll('HttpException: ', 'Erro: '),
                  style: TextStyle(fontSize: 17),
                ),
                backgroundColor: Colors.red[400],
                duration: Duration(seconds: 5),
              ),
            );
          }
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      userAtt.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            userAtt.email,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(userAtt.address),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_city_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(userAtt.city),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: userAtt.id == -100
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UserEditForm(
                          user: userAtt,
                        ),
                      ),
                    );
                  },
            child: Icon(Icons.edit),
            heroTag: null,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: userAtt.id != -100 ? onDelete : null,
            child: Icon(Icons.delete_forever_rounded),
            heroTag: null,
            backgroundColor: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
