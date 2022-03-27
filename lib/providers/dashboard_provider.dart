import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/components/most_rented_books.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_wda/providers/PublisherProvider.dart';

class DashboardProvider with ChangeNotifier {
  Map<String, Object> _dataBooks = {};
  Map<String, Object> _dataBooksRent = {};
  Map<String, Object> _dataUsers = {};
  Map<String, Object> _dataPublishers = {};
  List<MostRentedBooksData> _mostRentedBooks = [];

  Map<String, Object> get usersData {
    return _dataUsers;
  }

  List<MostRentedBooksData> get mostRentedBooks {
    _mostRentedBooks.sort((a, b) => a.totalRented.compareTo(b.totalRented));
    return _mostRentedBooks.reversed.take(3).toList();
  }

  Map<String, Object> get booksData {
    return _dataBooks;
  }

  Map<String, Object> get publishersData {
    return _dataPublishers;
  }

  Map<String, Object> get booksRentData {
    return _dataBooksRent;
  }

  Future<void> loadBooks() async {
    _mostRentedBooks.clear();

    List<dynamic> booksData = [];
    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/livros'),
      headers: {'content-type': 'application/json'},
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      booksData = jsonDecode(utf8.decode(response.body.codeUnits));

      for (var book in booksData) {
        print(book);
        _mostRentedBooks.add(MostRentedBooksData(
            bookName: book['nome'], totalRented: book['totalalugado'] as int));
      }

      notifyListeners();
    }

    _dataBooks = {'label': 'Livros', 'count': booksData.length};
  }

  Future<void> loadBooksRent() async {
    List<dynamic> booksRentData = [];
    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/alugueis'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      booksRentData = jsonDecode(utf8.decode(response.body.codeUnits));
    }

    _dataBooksRent = {'label': 'Aluguéis', 'count': booksRentData.length};
  }

  Future<void> loadUsers() async {
    List<dynamic> usersData = [];
    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/usuarios'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      usersData = jsonDecode(utf8.decode(response.body.codeUnits));
    }

    _dataUsers = {'label': 'Usuários', 'count': usersData.length};
  }

  Future<void> loadPublishers() async {
    List<dynamic> publishersData = [];
    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/editoras'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      publishersData = jsonDecode(utf8.decode(response.body.codeUnits));
    }

    _dataPublishers = {'label': 'Editoras', 'count': publishersData.length};
  }
}
