import 'package:flutter/material.dart';

import '../features/job_details/data/rx_get_report/model/job_report_response.dart';
import '../features/job_details/data/rx_get_summary/model/summary_response.dart';
import '../networks/api_acess.dart';




class JobDetailsProvider extends ChangeNotifier {
  /// -------- Summary --------
  Data? _data;
  bool _isLoading = false;
  String? _error;

  Data? get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// -------- Report --------
  ReportData? _reportData;
  bool _isReportLoading = false;
  String? _reportError;

  ReportData? get reportData => _reportData;
  bool get isReportLoading => _isReportLoading;
  String? get reportError => _reportError;

  /// -------- Fetch Summary --------
  Future<void> fetchJobSummarry({required String id}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await summaryRxObj.summaryRx(id: id);
      _data = response.data;

      if (_data == null) {
        _error = "No data found";
      } else {
        ///  MAIN LOGIC
        if (_data!.hasReport == true && _data!.reportId != null) {
          await fetchReport(id: _data!.reportId!);
        } else {
          _reportData = null; // clear old data
        }
      }
    } catch (e) {
      _error = "Something went wrong";
    }

    _isLoading = false;
    notifyListeners();
  }

  /// -------- Fetch Report --------
  Future<void> fetchReport({required String id}) async {
    _isReportLoading = true;
    _reportError = null;
    notifyListeners();

    try {
      final response = await jobReportRxObj.jobReportRx(id: id);
      _reportData = response.data;

      if (_reportData == null) {
        _reportError = "No report data found";
      }
    } catch (e) {
      _reportError = "Failed to load report";
    }

    _isReportLoading = false;
    notifyListeners();
  }
}


// class JobDetailsProvider extends ChangeNotifier {
//   Data? _data;
//   bool _isLoading = false;
//   String? _error;

//   Data? get data => _data;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchJobSummarry({required String id}) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final response = await summaryRxObj.summaryRx(id: id);
//       _data = response.data;

//       if (_data == null) {
//         _error = "No data found";
//       }
//     } catch (e) {
//       _error = "Something went wrong";
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   /// Photos || Report || Email Log Api Resposne

//   ReportData? _reportData;
//   bool _isLoading2 = false;
//   String? _error2;

//   ReportData? get reportData => _reportData;
//   bool get isLoading2 => _isLoading2;
//   String? get error2 => _error2;

//   Future<void> fetchReport({required String id}) async {
//     _isLoading2 = true;
//     _error2 = null;
//     notifyListeners();

//     try {
//       final response = await jobReportRxObj.jobReportRx(id: id);
//       _reportData = response.data;

//       if (_reportData == null) {
//         _error2 = "No data found";
//       }
//     } catch (e) {
//       _error2 = "Something went wrong";
//     }

//     _isLoading2 = false;
//     notifyListeners();
//   }
// }
