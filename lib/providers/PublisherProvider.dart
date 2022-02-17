import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/models/publisher.dart';
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

  Publisher publisherById(int id) {
    if (_publishers.any((element) => element.id == id)) {
      return _publishers.firstWhere((element) => element.id == id);
    }
    return Publisher(-100, '@anonimo', '@anonimo');
  }

  Future<void> savePublisher(Map<String, String> data) {
    final publisherId = int.tryParse(data['id'].toString());

    bool hasId = publisherId != 0;

    if (data.keys.contains('id')) {}

    final publisher = Publisher(
      hasId ? publisherId! : 0,
      data['name'] as String,
      data['city'] as String,
    );

    if (hasId) {
      return updatePublisher(publisher);
    } else {
      return addPublisher(publisher);
    }
  }

  Future<void> addPublisher(Publisher publisher) async {
    final response = await http.post(
      Uri.parse('http://livraria--back.herokuapp.com/api/editora'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {
          "id": 0,
          "nome": publisher.name,
          "cidade": publisher.city,
        },
      ),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      //Pegando id da editora cadastrada
      final publisherId = jsonDecode(response.body)['id'];

      _publishers.add(Publisher(
        publisherId,
        publisher.name,
        publisher.city,
      ));

      notifyListeners();
    } else {
      throw HttpException(
        'Ocorreu um erro ao tentar salvar a editora.',
      );
    }
  }

  Future<void> updatePublisher(Publisher publisher) async {
    //Pegando index da editora para poder substituir
    int index = _publishers.indexWhere((p) => p.id == publisher.id);

    if (index >= 0) {
      final response = await http.put(
        Uri.parse('http://livraria--back.herokuapp.com/api/editora'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "id": publisher.id,
            "nome": publisher.name,
            "cidade": publisher.city,
          },
        ),
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _publishers[index] = publisher;

        notifyListeners();
      } else {
        throw const HttpException(
          'Ocorreu um erro ao tentar salvar a editora.',
        );
      }
    }
  }

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
