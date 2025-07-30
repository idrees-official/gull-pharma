import 'package:flutter/foundation.dart';
import '../model/sale_report_model.dart';
import '../services/api_service.dart';

class SaleController extends ChangeNotifier {
  WeeklySaleResponse? _weeklySaleResponse;
  MonthlySaleResponse? _monthlySaleResponse;
  YearlySaleResponse? _yearlySaleResponse;
  bool _isLoading = false;
  String? _error;
  
  WeeklySaleResponse? get weeklySaleResponse => _weeklySaleResponse;
  MonthlySaleResponse? get monthlySaleResponse => _monthlySaleResponse;
  YearlySaleResponse? get yearlySaleResponse => _yearlySaleResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchWeeklySale() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getWeeklySale();
      _weeklySaleResponse = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchMonthlySale() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getMonthlySale();
      _monthlySaleResponse = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchYearlySale() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getYearlySale();
      _yearlySaleResponse = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void refresh() {
    fetchWeeklySale();
  }
} 