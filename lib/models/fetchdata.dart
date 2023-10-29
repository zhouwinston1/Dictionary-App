import 'package:firebase_database/firebase_database.dart';
import '../main.dart';

final database = FirebaseDatabase.instance.reference();

void fetchDataFromDatabase(Map<String, dynamic> myMap,
    List<String> readDataToList, int whereToReceiveData) {
  if (whereToReceiveData++ == 1) {
    print(1);
    for (var value in myInitMap.values) {
      print('running');
      if (!readDataToList.contains(value)) {
        print(value + 'init');
        readDataToList.add(value);
        if (!myMap.containsValue(value)) {
          myMap[value] = value;
        }
      }
    }
  } else {
    print(2);
    for (var value in myMap.values) {
      if (!readDataToList.contains(value)) {
        readDataToList.add(value);
        print(value);
      }
    }
  }
  print(readDataToList);
}
