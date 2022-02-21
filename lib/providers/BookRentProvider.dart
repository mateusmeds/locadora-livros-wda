import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/book_rent.dart';
import 'package:livraria_wda/models/publisher.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_wda/models/user.dart';

class BookRentProvider with ChangeNotifier {
  List<BookRent> _booksRental = [];

  List<BookRent> get booksRental => _booksRental;

  Future<bool> loadBooksRental() async {
    _booksRental.clear();

    final response = await http.get(
      Uri.parse('http://livraria--back.herokuapp.com/api/alugueis'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> booksRentalData = jsonDecode(response.body);

      for (var bookRent in booksRentalData) {
        _booksRental.add(BookRent(
          bookRent['id'],
          User(
            bookRent['usuario_id']['id'],
            bookRent['usuario_id']['nome'],
            bookRent['usuario_id']['email'],
            bookRent['usuario_id']['endereco'],
            bookRent['usuario_id']['cidade'],
          ),
          Book(
            bookRent['livro_id']['id'],
            bookRent['livro_id']['autor'],
            bookRent['livro_id']['nome'],
            Publisher(
              bookRent['livro_id']['editora']['id'],
              bookRent['livro_id']['editora']['nome'],
              bookRent['livro_id']['editora']['cidade'],
            ),
            bookRent['livro_id']['quantidade'],
            bookRent['livro_id']['lancamento'],
            bookRent['livro_id']['totalalugado'],
          ),
          bookRent['data_aluguel'],
          bookRent['data_previsao'],
          bookRent['data_devolucao'].toString(),
        ));
      }

      notifyListeners();

      return true;
    }
    return false;
  }

  // Book bookById(int id) {
  //   if (_books.any((element) => element.id == id)) {
  //     return _books.firstWhere((element) => element.id == id);
  //   }
  //   return Book(
  //     -100,
  //     '@anonimo',
  //     '@anonimo',
  //     Publisher(-100, '@anonimo', '@anonimo'),
  //     1,
  //     1,
  //     1,
  //   );
  // }

  // Future<Publisher> getPublisher(int id) async {
  //   final response = await http.get(
  //     Uri.parse('http://livraria--back.herokuapp.com/api/editora/$id'),
  //     headers: {'content-type': 'application/json'},
  //   );

  //   print(jsonDecode(response.body));

  //   if (response.statusCode == 200) {
  //     var publisherData = jsonDecode(response.body);
  //     return Publisher(
  //       publisherData['id'],
  //       publisherData['nome'],
  //       publisherData['cidade'],
  //     );
  //   }

  //   return Publisher(-100, '@anonimo', '@anonimo');
  // }

  Future<void> saveBookRental(Map<String, Object> data, Book book, User user) {
    final int bookRentalId = int.parse(data['id'].toString());

    bool hasId = bookRentalId > 0;

    final bookRental = BookRent(
      hasId ? bookRentalId : 0,
      user,
      book,
      data['rentalDate'].toString(),
      data['previsionDate'].toString(),
      'null',
    );

    // if (hasId) {
      // return updateBook(book);
    // } else {
      return addBookRental(bookRental);
    // }
  }

  Future<void> addBookRental(BookRent bookRental) async {
    DateTime rentalDateFormat = DateFormat('dd/MM/y').parse(bookRental.rentalDate);
    DateTime previsionDateFormat = DateFormat('dd/MM/y').parse(bookRental.previsionDate);

    final response = await http.post(
      Uri.parse('http://livraria--back.herokuapp.com/api/aluguel'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {
          "data_aluguel":  DateFormat('y-MM-dd').format(rentalDateFormat),
          "data_devolucao": "",
          "data_previsao": DateFormat('y-MM-dd').format(previsionDateFormat),
          "id": 0,
          "livro_id": {
            "autor": bookRental.book.author,
            "editora": {
              "cidade": bookRental.book.publisher.city,
              "id": bookRental.book.publisher.id,
              "nome": bookRental.book.publisher.name,
            },
            "id": bookRental.book.id,
            "lancamento": bookRental.book.releaseYear,
            "nome": bookRental.book.name,
            "quantidade": bookRental.book.quantity,
            "totalalugado": bookRental.book.totalRented,
          },
          "usuario_id": {
            "cidade": bookRental.user.city,
            "email": bookRental.user.email,
            "endereco": bookRental.user.address,
            "id": bookRental.user.id,
            "nome": bookRental.user.name
          }
        },
      ),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      //Pegando id do aluguel cadastrado
      final bookRentalId = jsonDecode(response.body)['id'];

      _booksRental.add(BookRent(
        bookRentalId,
        bookRental.user,
        bookRental.book,
        bookRental.rentalDate,
        bookRental.previsionDate,
        bookRental.devolutionDate,
      ));

      notifyListeners();
    } else if (response.statusCode == 400) {
      throw HttpException(jsonDecode(response.body)['error']);
    } else {
      throw const HttpException(
        'Ocorreu um erro ao tentar salvar o aluguel do livro.',
      );
    }
  }

  // Future<void> updateBook(Book book) async {
  //   //Pegando index do livro para poder substituir
  //   int index = _books.indexWhere((p) => p.id == book.id);

  //   if (index >= 0) {
  //     final response = await http.put(
  //       Uri.parse('http://livraria--back.herokuapp.com/api/livro'),
  //       headers: {'content-type': 'application/json'},
  //       body: jsonEncode(
  //         {
  //           "autor": book.author,
  //           "editora": {
  //             "cidade": book.publisher.city,
  //             "id": book.publisher.id,
  //             "nome": book.publisher.name
  //           },
  //           "id": book.id,
  //           "lancamento": book.releaseYear,
  //           "nome": book.name,
  //           "quantidade": book.quantity,
  //           "totalalugado": book.totalRented,
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       _books[index] = book;

  //       notifyListeners();
  //     } else if (response.statusCode == 400) {
  //       throw HttpException(jsonDecode(response.body)['error']);
  //     } else {
  //       throw const HttpException(
  //         'Ocorreu um erro ao tentar salvar o livro.',
  //       );
  //     }
  //   }
  // }

  // Future<void> removeBook(Book book) async {
  //   int index = _books.indexWhere((u) => u.id == book.id);

  //   if (index >= 0) {
  //     final response = await http.delete(
  //       Uri.parse('http://livraria--back.herokuapp.com/api/livro'),
  //       headers: {'content-type': 'application/json'},
  //       body: jsonEncode(
  //         {
  //           "autor": book.author,
  //           "editora": {
  //             "cidade": book.publisher.city,
  //             "id": book.publisher.id,
  //             "nome": book.publisher.name
  //           },
  //           "id": book.id,
  //           "lancamento": book.releaseYear,
  //           "nome": book.name,
  //           "quantidade": book.quantity,
  //           "totalalugado": book.totalRented,
  //         },
  //       ),
  //     );

  //     //print(jsonDecode(response.body));

  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       _books.remove(_books[index]);
  //       notifyListeners();
  //     } else if (response.statusCode == 400) {
  //       throw HttpException(jsonDecode(response.body)['error']);
  //     } else {
  //       throw const HttpException(
  //         'Ocorreu um erro ao tentar remover o livro.',
  //       );
  //     }
  //   } else {
  //     throw const HttpException(
  //       'Livro não existe.',
  //     );
  //   }
  // }
}
