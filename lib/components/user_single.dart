import 'package:flutter/material.dart';
import 'package:livraria_wda/models/user.dart';

class UserSingle extends StatelessWidget {
  User user;

  UserSingle({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mateus Medeiros"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.email_rounded),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    "mateus@mail.com",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 5),
                Flexible(
                    child: Text(
                  "Rua da Silva, Natal",
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }
}
