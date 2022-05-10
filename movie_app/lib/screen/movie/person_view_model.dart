import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/api/service_api.dart';
import 'package:movie_app/model/person.dart';

class PersonViewModel with ChangeNotifier {
  List<Person> _persons = [];
  List<Person> get persons => _persons;

  getTrendingPerson() async {
    final c = await ApiService.getTrendingPerson();
    _persons = c;
    print('Persons = ${_persons[3].profilePath}');
    notifyListeners();
  }
}