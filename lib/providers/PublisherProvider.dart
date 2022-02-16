import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:http/http.dart' as http;

class PublisherProvider with ChangeNotifier {
  List<Publisher> _publishers = [];

  List<Publisher> get publishers => _publishers;
  
  Future<void> loadPublishers() async {
    _publishers.clear();

    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/editoras'),
      headers: {'content-type': 'application/json'},
    );

    if (response.body == 'null') {
      return;
    }

    List<dynamic> publishersData = jsonDecode(response.body);

    for (var publisher in publishersData) {
      _publishers.add(
        Publisher(
          publisher['id'],
          publisher['nome'],
          publisher['cidade'],
        ),
      );
    }

    notifyListeners();
  }

  // Future<void> saveUser(Map<String, String> data) {
  //   final userId = int.tryParse(data['id'].toString());

  //   bool hasId = userId != 0;

  //   if (data.keys.contains('id')) {}

  //   final user = User(
  //     hasId ? userId : 0,
  //     data['name'] as String,
  //     data['email'] as String,
  //     data['address'] as String,
  //     data['city'] as String,
  //   );

  //   if (hasId) {
  //     return updateUser(user);
  //   } else {
  //     return addUser(user);
  //   }
  // }

  // Future<void> addUser(User user) async {
  //   final response = await http.post(
  //     Uri.parse('http://livraria--back.herokuapp.com/api/usuario'),
  //     headers: {'content-type': 'application/json'},
  //     body: jsonEncode(
  //       {
  //         "id": 0,
  //         "nome": user.name,
  //         "email": user.email,
  //         "endereco": user.address,
  //         "cidade": user.city,
  //       },
  //     ),
  //   );

  //   //Pegando id do usuário cadastrado
  //   final userId = jsonDecode(response.body)['id'];

  //   _users.add(User(
  //     userId,
  //     user.name,
  //     user.email,
  //     user.address,
  //     user.city,
  //   ));
  //   notifyListeners();
  // }

  // User userById(int id) {
  //   if (_users.any((element) => element.id == id)) {
  //     return _users. firstWhere((element) => element.id == id);
  //   }
  //   return User(-100, '@anonimo', '@anonimo', '@anonimo', '@anonimo');
  // }

  // Future<void> updateUser(User user) async {
  //   //Pegando index do usuário para poder substituir
  //   int index = _users.indexWhere((p) => p.id == user.id);

  //   if (index >= 0) {
  //     final response = await http.put(
  //       Uri.parse('http://livraria--back.herokuapp.com/api/usuario'),
  //       headers: {'content-type': 'application/json'},
  //       body: jsonEncode(
  //         {
  //           "id": user.id,
  //           "nome": user.name,
  //           "email": user.email,
  //           "endereco": user.address,
  //           "cidade": user.city,
  //         },
  //       ),
  //     );

  //     _users[index] = user;

  //     notifyListeners();
  //   }
  // }

  // Future<void> removeUser(User user) async {
  //   int index = _users.indexWhere((u) => u.id == user.id);

  //   if (index >= 0) {
  //     await http
  //         .delete(
  //       Uri.parse('http://livraria--back.herokuapp.com/api/usuario'),
  //       headers: {'content-type': 'application/json'},
  //       body: jsonEncode(
  //         {
  //           "id": user.id,
  //           "nome": user.name,
  //           "email": user.email,
  //           "endereco": user.address,
  //           "cidade": user.city,
  //         },
  //       ),
  //     )
  //         .catchError((onError) {
  //       throw HttpException(
  //         'Não foi possível excluir o usuário.',
  //       );
  //     }).then((value) {
  //       final user = _users[index];
  //       _users.remove(user);
  //       notifyListeners();
  //     });
  //   } else {
  //     throw HttpException(
  //       'Usuário não existe.',
  //     );
  //   }
  // }
}
