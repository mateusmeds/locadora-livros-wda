class User {
  int? _id;
  String? _name;
  String? _email;
  String? _address;
  String? _city;

  User(this._id, this._name, this._email, this._address, this._city);

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  String get email {
    return _email!;
  }

  String get address {
    return _address!;
  }

  String get city {
    return _city!;
  }
}
