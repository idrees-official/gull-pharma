import 'package:flutter/foundation.dart';

class DashboardController extends ChangeNotifier {
  int _selectedIndex = 0; // Now starts with Stock (index 0) instead of Dashboard
  
  int get selectedIndex => _selectedIndex;
  
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Dashboard summary data
  int _totalProducts = 0;
  double _totalSales = 0.0;
  double _totalPurchases = 0.0;
  
  int get totalProducts => _totalProducts;
  double get totalSales => _totalSales;
  double get totalPurchases => _totalPurchases;
  
  void updateSummaryData({
    int? totalProducts,
    double? totalSales,
    double? totalPurchases,
  }) {
    if (totalProducts != null) _totalProducts = totalProducts;
    if (totalSales != null) _totalSales = totalSales;
    if (totalPurchases != null) _totalPurchases = totalPurchases;
    notifyListeners();
  }
} 