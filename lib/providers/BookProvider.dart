import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_wda/providers/PublisherProvider.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> _booksSearch = [];

  List<Book> get books => _books;

  List<Book> get booksSearch => _booksSearch;

  Future<void> loadBooks() async {
    _books.clear();

    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/livros'),
      headers: {'content-type': 'application/json'},
    );

    List<dynamic> booksData = jsonDecode(utf8.decode(response.body.codeUnits));

    for (var book in booksData) {
      _books.add(
        Book(
          book['id'],
          book['autor'],
          book['nome'],
          Publisher(
            book['editora']['id'],
            book['editora']['nome'],
            book['editora']['cidade'],
          ),
          book['quantidade'],
          book['lancamento'],
          book['totalalugado'],
        ),
      );
    }

    notifyListeners();
  }

  void filterBooks({String text = ""}) {
    if (text.isNotEmpty) {
      _booksSearch = _books
          .where((book) =>
              book.author.toLowerCase().contains(text.toLowerCase()) ||
              book.name.toLowerCase().contains(text.toLowerCase()) ||
              book.releaseYear.toString().contains(text.toLowerCase()) ||
              book.publisher.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
  }

  Future<void> loadAvailableBooks() async {
    _books.clear();

    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/disponiveis'),
      headers: {'content-type': 'application/json'},
    );

    List<dynamic> booksData = jsonDecode(utf8.decode(response.body.codeUnits));

    for (var book in booksData) {
      _books.add(
        Book(
          book['id'],
          book['autor'],
          book['nome'],
          Publisher(
            book['editora']['id'],
            book['editora']['nome'],
            book['editora']['cidade'],
          ),
          book['quantidade'],
          book['lancamento'],
          book['totalalugado'],
        ),
      );
    }

    notifyListeners();
  }

  Book bookById(int id) {
    if (_books.any((element) => element.id == id)) {
      return _books.firstWhere((element) => element.id == id);
    }
    return Book(
      -100,
      '@anonimo',
      '@anonimo',
      Publisher(-100, '@anonimo', '@anonimo'),
      1,
      1,
      1,
    );
  }

  Future<void> saveBook(Map<String, Object> data, Publisher pub) {
    final int bookId = int.parse(data['id'].toString());

    bool hasId = bookId != 0;

    final book = Book(
      hasId ? bookId : 0,
      data['author'].toString(),
      data['name'].toString(),
      pub,
      int.parse(data['quantity'].toString()),
      int.parse(data['releaseYear'].toString()),
      hasId ? int.parse(data['totalRented'].toString()) : 0,
    );

    if (hasId) {
      return updateBook(book);
    } else {
      return addBook(book);
    }
  }

  Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse('http://livraria--back.herokuapp.com/api/livro'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {
          "autor": book.author,
          "editora": {
            "cidade": book.publisher.city,
            "id": book.publisher.id,
            "nome": book.publisher.name
          },
          "id": book.id,
          "lancamento": book.releaseYear,
          "nome": book.name,
          "quantidade": book.quantity,
          "totalalugado": book.totalRented,
        },
      ),
    );

    if (response.statusCode == 200) {
      //Pegando id do livro cadastrado
      final bookId = jsonDecode(response.body)['id'];

      books.add(Book(
        bookId,
        book.author,
        book.name,
        book.publisher,
        book.quantity,
        book.releaseYear,
        book.totalRented,
      ));

      notifyListeners();
    } else if (response.statusCode == 400) {
      throw HttpException(
          jsonDecode(utf8.decode(response.body.codeUnits))['error']);
    } else {
      throw const HttpException(
        'Ocorreu um erro ao tentar salvar o livro.',
      );
    }
  }

  Future<void> updateBook(Book book) async {
    //Pegando index do livro para poder substituir
    int index = _books.indexWhere((p) => p.id == book.id);

    if (index >= 0) {
      final response = await http.put(
        Uri.parse('http://livraria--back.herokuapp.com/api/livro'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "autor": book.author,
            "editora": {
              "cidade": book.publisher.city,
              "id": book.publisher.id,
              "nome": book.publisher.name
            },
            "id": book.id,
            "lancamento": book.releaseYear,
            "nome": book.name,
            "quantidade": book.quantity,
            "totalalugado": book.totalRented,
          },
        ),
      );

      if (response.statusCode == 200) {
        _books[index] = book;

        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException(
            jsonDecode(utf8.decode(response.body.codeUnits))['error']);
      } else {
        throw const HttpException(
          'Ocorreu um erro ao tentar salvar o livro.',
        );
      }
    }
  }

  Future<void> removeBook(Book book) async {
    int index = _books.indexWhere((u) => u.id == book.id);

    if (index >= 0) {
      final response = await http.delete(
        Uri.parse('http://livraria--back.herokuapp.com/api/livro'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "autor": book.author,
            "editora": {
              "cidade": book.publisher.city,
              "id": book.publisher.id,
              "nome": book.publisher.name
            },
            "id": book.id,
            "lancamento": book.releaseYear,
            "nome": book.name,
            "quantidade": book.quantity,
            "totalalugado": book.totalRented,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _books.remove(_books[index]);
        notifyListeners();
      } else if (response.statusCode == 400) {
        throw HttpException(
            jsonDecode(utf8.decode(response.body.codeUnits))['error']);
      } else {
        throw const HttpException(
          'Ocorreu um erro ao tentar remover o livro.',
        );
      }
    } else {
      throw const HttpException(
        'Livro não existe.',
      );
    }
  }
}
