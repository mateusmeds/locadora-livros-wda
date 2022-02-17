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
      throw const HttpException(
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

  Future<void> removePublisher(Publisher publisher) async {
    int index = _publishers.indexWhere((u) => u.id == publisher.id);

    if (index >= 0) {
      final response = await http.delete(
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

      if (response.statusCode == 200 || response.statusCode == 204) {
        _publishers.remove(_publishers[index]);
        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException(
          jsonDecode(response.body)['error']
        );
      } else {
        throw const HttpException(
          'Ocorreu um erro ao tentar remover a editora.',
        );
      }
    } else {
      throw const HttpException(
        'Editora não existe.',
      );
    }
  }
}
