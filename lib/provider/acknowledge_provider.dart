



// import 'package:flutter/material.dart';

// import '../networks/api_acess.dart';

// class AcknowledgeProvider extends ChangeNotifier {
//   AcknowledgeProvider() {
//     fetchAKnowledgenment();
//   }
//   // Initilaxation
//   bool _isLoading = true;
//   String? _data;
//   String? _errorMessage;

//   // Getter Method
//   String? get data => _data;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;

//   Future<void> fetchAKnowledgenment() async {
//     try {
//       final response = await inspectionAcknowledgeRxObj
//           .inspectionAcknowledgeRx();
//       if (response.data != null) {
//         _data = response.data ?? "";
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
