import 'package:livraria_wda/models/book.dart';
import 'package:livraria_wda/models/user.dart';

class BookRent {
  int? _id;
  User? _user;
  Book? _book;
  String? _rentalDate;
  String? _previsionDate;
  String _devolutionDate = '';

  BookRent({
    required id,
    required user,
    required book,
    required rentalDate,
    required previsionDate,
    devolutionDate,
  });

  int get id {
    return _id!;
  }

  User get user {
    return _user!;
  }

  Book get book {
    return _book!;
  }

  String get rentalDate {
    return _rentalDate!;
  }

  String get previsionDate {
    return _previsionDate!;
  }

  String get devolutionDate {
    return _devolutionDate;
  }
}
