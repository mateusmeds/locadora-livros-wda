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
    if (response.body == 'null') return;

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
    //bool hasId = data['id'] != null;

    final user = User(
      0,
      data['name'] as String,
      data['email'] as String,
      data['address'] as String,
      data['city'] as String,
    );

    // if (hasId) {
    //   return updateProduct(product);
    // } else {
    return addUser(user);
    // }
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

    final bool status = response.statusCode == 200;
    print('OI ${response.statusCode}');
    print(status);

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

  // Future<void> updateProduct(Product product) async {
  //   int index = _items.indexWhere((p) => p.id == product.id);

  //   if (index >= 0) {
  //     await http.patch(
  //       Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),
  //       body: jsonEncode(
  //         {
  //           "name": product.name,
  //           "description": product.description,
  //           "price": product.price,
  //           "imageUrl": product.imageUrl,
  //         },
  //       ),
  //     );

  //     _items[index] = product;
  //     notifyListeners();
  //   }
  // }

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
