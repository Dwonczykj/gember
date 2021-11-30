// import 'package:flutter/material.dart';

// import 'consumer.dart';
// import 'green_project.dart';

// class ConsumerManager extends ChangeNotifier {
//   final _consumers = <Consumer>[];
//   int _selectedIndex = -1;
//   bool _createNewConsumer = false;

//   List<Consumer> get Consumers => List.unmodifiable(_consumers);
//   int get selectedIndex => _selectedIndex;
//   Consumer? get selectedGroceryConsumer =>
//       _selectedIndex != -1 ? _consumers[_selectedIndex] : null;
//   bool get isCreatingNewConsumer => _createNewConsumer;

//   void createNewConsumer() {
//     _createNewConsumer = true;
//     notifyListeners();
//   }

//   void deleteConsumer(int index) {
//     _consumers.removeAt(index);
//     notifyListeners();
//   }

//   void consumerTapped(int index) {
//     _selectedIndex = index;
//     _createNewConsumer = false;
//     notifyListeners();
//   }

//   void addConsumer(Consumer consumer) {
//     _consumers.add(consumer);
//     _createNewConsumer = false;
//     notifyListeners();
//   }

//   void addConsumerPriority(Consumer consumer, GreenProject project) {
//     var c = _consumers.singleWhere((element) => element == consumer);
//     c.priorities.add(project);
//   }

//   void deleteConsumerPriority(Consumer consumer, GreenProject project) {
//     var c = _consumers.singleWhere((element) => element == consumer);
//     c.priorities.removeWhere((element) => element.uid == project.uid);
//   }

//   void updateConsumer(Consumer consumer, int index) {
//     _consumers[index] = consumer;
//     _selectedIndex = -1;
//     _createNewConsumer = false;
//     notifyListeners();
//   }

//   void tapOnOwnProfile(bool bool) {
//     //TODO: Update this class to not be a Consumer creater but rather an personal profile manager. So addConsumer does not exist., _isCreatingConsumer does not exist.
//   }
// }
