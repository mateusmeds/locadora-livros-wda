import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:livraria_wda/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  int get usersCount {
    return _users.length;
  }

  Future<void> loadUsers() async {
    users.clear();

    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/usuarios'),
      headers: {'content-type': 'application/json'},
    );

    if (response.body == 'null') {
      return;
    }

    List<dynamic> usersData = jsonDecode(response.body);

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
      Uri.parse('http://livraria--back.herokuapp.com/api/usuario'),
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
  }

  User userById(int id) {
    User user = _users.firstWhere((element) => element.id == id);

    return user;
  }


  Future<void> updateUser(User user) async {
    //Pegando index do usuário para poder substituir
    int index = _users.indexWhere((p) => p.id == user.id);

    if (index >= 0) {
      final response = await http.put(
        Uri.parse('http://livraria--back.herokuapp.com/api/usuario'),
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

      _users[index] = user;

      notifyListeners();
    }
  }

  // Future<void> removeProduct(Product product) async {
  //   int index = _items.indexWhere((p) => p.id == product.id);

  //   if (index >= 0) {
  //     final product = _items[index];
  //     _items.remove(product);
  //     notifyListeners();

  //     final response = await http.delete(
  //       Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),
  //     );

  //     if (response.statusCode >= 400) {
  //       _items.insert(index, product);
  //       notifyListeners();
  //       throw HttpException(
  //         msg: 'Não foi possível excluir o produto.',
  //         statusCode: response.statusCode,
  //       );
  //     }
  //   }
  // }
}
