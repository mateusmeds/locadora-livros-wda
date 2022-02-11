import 'package:flutter/material.dart';
import 'package:livraria_wda/components/user_edit.dart';
import 'package:livraria_wda/components/user_register_form.dart';
import 'package:livraria_wda/main.dart';
import 'package:livraria_wda/models/user.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<User> users = [
      User(1, 'Mateus', 'mateus@mail.com hrdhrdhrd h drhdr hrdhdr hdh',
          'Rua Teste, 363 gseg esg se gesg esg seg esg seg', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com hrdhrdhrd h drhdr hrdhdr hdh',
          'Rua Teste, 363 gseg esg se gesg esg seg esg seg', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com hrdhrdhrd h drhdr hrdhdr hdh',
          'Rua Teste, 363 gseg esg se gesg esg seg esg seg', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com hrdhrdhrd h drhdr hrdhdr hdh',
          'Rua Teste, 363 gseg esg se gesg esg seg esg seg', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
      User(1, 'Mateus', 'mateus@mail.com', 'Rua Teste, 363', 'Natal'),
    ];

    return Expanded(
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, index) {
            final user = users[index];

            return Padding(
              //Padding na lista de usuários
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 2.0,
                right: 5.0,
                left: 5.0,
              ),
              child: Container(
                //Padding no card
                padding: EdgeInsets.only(top: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UserEditForm(user),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: const CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              //Altura para dar espaço vertical entre o nome e o email
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email_rounded,
                                    color: Colors.black54,
                                  ),
                                  //Largura para dar espaço entre o ícone e o texto do e-mail
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      user.email,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.black54,
                                          ),
                                          //Largura para dar espaço entre o ícone e o texto do endereço
                                          const SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              "${user.address}, ${user.city}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyHomePage(title: 'ok'),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
