import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> _usersSearch = [];

  List<User> get users => _users;

  List<User> get usersSearch => _usersSearch;

  int get usersCount {
    return _users.length;
  }

  Future<void> loadUsers() async {
    users.clear();

    final response = await http.get(
      Uri.parse('http://wdaw.hopto.org:8185/api/usuarios'),
      headers: {'content-type': 'application/json'},
    );

    if (response.body == 'null') {
      return;
    }

    List<dynamic> usersData = jsonDecode(utf8.decode(response.body.codeUnits));

    for (var user in usersData) {
      _users.add(
        User(
          user['id'],
          user['nome'],
          user['email'],
          user['endereco'],
          user['cidade'],
        ),
      );
    }

    notifyListeners();
  }

  void filterUsers({String text = ""}) {
    if (text.isNotEmpty) {
      _usersSearch = _users
          .where((user) =>
              user.name.toLowerCase().contains(text.toLowerCase()) ||
              user.address.toLowerCase().contains(text.toLowerCase()) ||
              user.city.toLowerCase().contains(text.toLowerCase()) ||
              user.email.toString().contains(text.toLowerCase()))
          .toList();
    }
  }

  Future<void> saveUser(Map<String, String> data) {
    final userId = int.tryParse(data['id'].toString());

    bool hasId = userId != 0;

    if (data.keys.contains('id')) {}

    final user = User(
      hasId ? userId : 0,
      data['name'] as String,
      data['email'] as String,
      data['address'] as String,
      data['city'] as String,
    );

    if (hasId) {
      return updateUser(user);
    } else {
      return addUser(user);
    }
  }

  Future<void> addUser(User user) async {
    final response = await http.post(
      Uri.parse('http://wdaw.hopto.org:8185/api/usuario'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {
          "id": 0,
          "nome": user.name,
          "email": user.email,
          "endereco": user.address,
          "cidade": user.city,
        },
      ),
    );

    //Cadastrou
    if (response.statusCode == 200) {
      //Pegando id do usuário cadastrado
      final userId = jsonDecode(response.body)['id'];

      _users.add(User(
        userId,
        user.name,
        user.email,
        user.address,
        user.city,
      ));
      notifyListeners();

      //E-mail já existe
    } else if (response.statusCode == 400) {
      throw HttpException(
        jsonDecode(utf8.decode(response.body.codeUnits))['error'],
      );

      //Erro inesperado
    } else {
      throw HttpException(
        'Ocorreu um erro ao tentar salvar o usuário.',
      );
    }
  }

  User userById(int id) {
    if (_users.any((element) => element.id == id)) {
      return _users.firstWhere((element) => element.id == id);
    }
    return User(-100, '@anonimo', '@anonimo', '@anonimo', '@anonimo');
  }

  Future<void> updateUser(User user) async {
    //Pegando index do usuário para poder substituir
    int index = _users.indexWhere((p) => p.id == user.id);

    if (index >= 0) {
      final response = await http.put(
        Uri.parse('http://wdaw.hopto.org:8185/api/usuario'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "id": user.id,
            "nome": user.name,
            "email": user.email,
            "endereco": user.address,
            "cidade": user.city,
          },
        ),
      );

      if (response.statusCode == 200) {
        _users[index] = user;
        notifyListeners();
      } else {
        throw HttpException(
          'Ocorreu um erro ao tentar salvar o usuário.',
        );
      }
    } else {
      throw HttpException(
        'Usuário não existe.',
      );
    }
  }

  Future<void> removeUser(User user) async {
    int index = _users.indexWhere((u) => u.id == user.id);

    if (index >= 0) {
      final response = await http.delete(
        Uri.parse('http://wdaw.hopto.org:8185/api/usuario'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "id": user.id,
            "nome": user.name,
            "email": user.email,
            "endereco": user.address,
            "cidade": user.city,
          },
        ),
      );

      if (response.statusCode == 200) {
        _users.remove(_users[index]);
        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException(
          jsonDecode(utf8.decode(response.body.codeUnits))['error'],
        );
      } else {
        throw HttpException(
          "Ocorreu um erro ao tentar remover o usuário. Por favor, tente novamente.",
        );
      }
    } else {
      throw HttpException(
        'Usuário não existe.',
      );
    }
  }
}
