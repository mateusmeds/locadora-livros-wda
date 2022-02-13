import 'package:livraria_wda/models/publisher.dart';

class Book {
  int _id;
  String _name;
  String _author;
  Publisher _publisher;
  int _releaseYear;
  int _quantity;
  int _totalRented;

  Book(
    this._id,
    this._author,
    this._name,
    this._publisher,
    this._quantity,
    this._releaseYear,
    this._totalRented,
  );

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get author {
    return _author;
  }

  Publisher get publisher {
    return _publisher;
  }

  int get releaseYear {
    return _releaseYear;
  }

  int get quantity {
    return _quantity;
  }

  int get totalRented {
    return _totalRented;
  }
}
