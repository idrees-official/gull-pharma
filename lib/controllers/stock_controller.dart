import 'package:flutter/foundation.dart';
import '../model/stock_model.dart';
import '../services/api_service.dart';

class StockController extends ChangeNotifier {
  StockResponse? _stockResponse;
  bool _isLoading = false;
  String? _error;
  
  StockResponse? get stockResponse => _stockResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchStockData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getAvailableStock();
      _stockResponse = response;
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
    fetchStockData();
  }
} 