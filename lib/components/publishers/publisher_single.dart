import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/components/publishers/publisher_edit.dart';
import 'package:livraria_wda/components/users/user_edit.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:livraria_wda/providers/PublisherProvider.dart';
import 'package:provider/provider.dart';

class PublisherSingle extends StatelessWidget {
  final Publisher publisher;

  const PublisherSingle({required this.publisher, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final publisherProvider = Provider.of<PublisherProvider>(context);
    final publisherAtt = publisherProvider.publisherById(publisher.id);
    final msg = ScaffoldMessenger.of(context);

    void onDelete() {
      showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Excluir Editora'),
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
            await Provider.of<PublisherProvider>(
              context,
              listen: false,
            ).removePublisher(publisherAtt).then((value) {
              Navigator.of(context).pop();
              msg.showSnackBar(
                SnackBar(
                  content: Text(
                    'Editora excluída com sucesso.',
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
        title: const Text('Editora'),
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
                  Icons.my_library_books_rounded,
                  size: 55,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      publisherAtt.name,
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
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_city_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            publisherAtt.city,
                          ),
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
          FloatingActionButton.extended(
            label: Text('Editar'),
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PublisherEditForm(
                    publisher: publisherAtt,
                  ),
                ),
              );
            },
            heroTag: null,
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            label: Text('Excluir'),
            icon: Icon(Icons.delete_forever_rounded),
            onPressed: onDelete,
            heroTag: null,
            backgroundColor: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
