import 'package:flutter/material.dart';
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

    return Container(
      margin: EdgeInsets.all(5),
      height: 400,
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, index) {
            final user = users[index];

            return Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      height: 100,
                      child: const CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            //TODO: tem que colocar esta linha para quebrar caso chegue ao fim do container
                            Row(
                              children: [
                                const Icon(Icons.email_rounded),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    user.email,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 5),
                                Flexible(child: Text("${user.address}, ${user.city}",overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //Alterar cor de ícone
                      child: TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 40,
                        ),
                      ),
                      //color: Colors.yellow,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
