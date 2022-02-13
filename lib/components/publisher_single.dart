import 'package:flutter/material.dart';
import 'package:livraria_wda/components/user_edit.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:livraria_wda/models/user.dart';

class PublisherSingle extends StatelessWidget {
  final Publisher publisher;

  const PublisherSingle({required this.publisher, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      publisher.name,
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
                          Icons.location_city_rounded,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            publisher.city,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Quantidade de livros que a livraria tem dessa editora
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu_book,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            '5',
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
          FloatingActionButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => UserEditForm(
              //       user: user,
              //     ),
              //   ),
              // );
            },
            child: Icon(Icons.edit),
            heroTag: null,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.delete_forever_rounded),
            heroTag: null,
            backgroundColor: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
