import 'package:flutter/foundation.dart';
import '../model/purchase_report_model.dart';
import '../services/api_service.dart';

class PurchaseController extends ChangeNotifier {
  DailyPurchaseResponse? _dailyPurchaseResponse;
  WeeklyPurchaseResponse? _weeklyPurchaseResponse;
  MonthlyPurchaseResponse? _monthlyPurchaseResponse;
  YearlyPurchaseResponse? _yearlyPurchaseResponse;
  bool _isLoading = false;
  String? _error;
  
  DailyPurchaseResponse? get dailyPurchaseResponse => _dailyPurchaseResponse;
  WeeklyPurchaseResponse? get weeklyPurchaseResponse => _weeklyPurchaseResponse;
  MonthlyPurchaseResponse? get monthlyPurchaseResponse => _monthlyPurchaseResponse;
  YearlyPurchaseResponse? get yearlyPurchaseResponse => _yearlyPurchaseResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchDailyPurchase() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getDailyPurchase();
      _dailyPurchaseResponse = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchWeeklyPurchase() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getWeeklyPurchase();
      _weeklyPurchaseResponse = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchMonthlyPurchase() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getMonthlyPurchase();
      _monthlyPurchaseResponse = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchYearlyPurchase() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await ApiService().getYearlyPurchase();
      _yearlyPurchaseResponse = response;
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
    fetchDailyPurchase();
  }
} 