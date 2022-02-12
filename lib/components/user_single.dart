import 'package:flutter/material.dart';
import 'package:livraria_wda/components/user_edit.dart';
import 'package:livraria_wda/models/user.dart';

class UserSingle extends StatelessWidget {
  final User user;

  const UserSingle({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      user.name,
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
                            user.email,
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
                          child: Text(user.address),
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
                          child: Text(user.city),
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
            onPressed: () {},
            child: Icon(Icons.delete_forever_rounded),
            heroTag: null,
            backgroundColor: Colors.red[400],
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UserEditForm(
                    user: user,
                  ),
                ),
              );
            },
            child: Icon(Icons.edit),
            heroTag: null,
          )
        ],
      ),
    );
  }
}
