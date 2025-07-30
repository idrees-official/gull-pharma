# Flutter Admin Reports App - Development Rules

## Project Overview
This is a Flutter admin application that displays various business reports including purchase reports, sale reports, and stock information. All data will be fetched from APIs. No authentication is required.

## App Structure

### 1. Core Architecture
- **Architecture Pattern**: MVC (Model-View-Controller)
- **State Management**: Provider for state management
- **API Integration**: HTTP requests using Dio or http package
- **Navigation**: Standard Flutter navigation
- **UI Framework**: Material Design 3 with custom theming

### 2. Folder Structure (MVC Pattern)
```
lib/
├── main.dart
├── model/
│   ├── purchase_report_model.dart
│   ├── sale_report_model.dart
│   └── stock_model.dart
├── view/
│   ├── dashboard/
│   │   ├── dashboard_screen.dart
│   │   └── widgets/
│   ├── purchase_reports/
│   │   ├── purchase_reports_screen.dart
│   │   └── widgets/
│   ├── sale_reports/
│   │   ├── sale_reports_screen.dart
│   │   └── widgets/
│   └── stock_reports/
│       ├── stock_screen.dart
│       └── widgets/
├── controllers/
│   ├── dashboard_controller.dart
│   ├── purchase_controller.dart
│   ├── sale_controller.dart
│   └── stock_controller.dart
└── services/
    ├── api_service.dart
    └── http_service.dart
```

## Report Types

### 1. Purchase Reports
- **Daily Purchase Report**: Shows purchase data for the current day
- **Weekly Purchase Report**: Shows purchase data for the current week
- **Monthly Purchase Report**: Shows purchase data for the current month
- **Yearly Purchase Report**: Shows purchase data for the current year

### 2. Sale Reports
- **Daily Sale Report**: Shows sales data for the current day
- **Weekly Sale Report**: Shows sales data for the current week
- **Monthly Sale Report**: Shows sales data for the current month
- **Yearly Sale Report**: Shows sales data for the current year

### 3. Stock Reports
- **Available Stock**: Shows current inventory levels

## Data Models

### Stock Model
```dart
class StockResponse {
  final bool success;
  final String note;
  final int totalProducts;
  final List<StockItem> data;
  final String message;

  StockResponse({
    required this.success,
    required this.note,
    required this.totalProducts,
    required this.data,
    required this.message,
  });

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(
      success: json['success'],
      note: json['note'],
      totalProducts: json['total_products'],
      data: (json['data'] as List).map((item) => StockItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class StockItem {
  final Product product;
  final String category;
  final String strength;
  final String strengthLevel;
  final int availableQuantity;

  StockItem({
    required this.product,
    required this.category,
    required this.strength,
    required this.strengthLevel,
    required this.availableQuantity,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      product: Product.fromJson(json['Product']),
      category: json['Category'],
      strength: json['Strength'],
      strengthLevel: json['StrengthLevel'],
      availableQuantity: json['AvailableQuantity'],
    );
  }
}

class Product {
  final String id;
  final String name;

  Product({
    required this.id,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      name: json['Name'],
    );
  }
}
```

### Purchase Report Models

#### Daily Purchase Model
```dart
class DailyPurchaseResponse {
  final bool success;
  final List<DailyPurchaseItem> data;
  final String message;

  DailyPurchaseResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DailyPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return DailyPurchaseResponse(
      success: json['success'],
      data: (json['data'] as List).map((item) => DailyPurchaseItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class DailyPurchaseItem {
  final String invoiceDate;
  final String invoiceNo;
  final String supplierName;
  final String productId;
  final String productName;
  final String category;
  final String strength;
  final String strengthLevel;
  final String purchaseQty;
  final String purchaseUnitPrice;
  final String discount;
  final String finalPurchaseUnitPrice;
  final String totalCost;
  final String enteredBy;

  DailyPurchaseItem({
    required this.invoiceDate,
    required this.invoiceNo,
    required this.supplierName,
    required this.productId,
    required this.productName,
    required this.category,
    required this.strength,
    required this.strengthLevel,
    required this.purchaseQty,
    required this.purchaseUnitPrice,
    required this.discount,
    required this.finalPurchaseUnitPrice,
    required this.totalCost,
    required this.enteredBy,
  });

  factory DailyPurchaseItem.fromJson(Map<String, dynamic> json) {
    return DailyPurchaseItem(
      invoiceDate: json['InvoiceDate'],
      invoiceNo: json['InvoiceNo'],
      supplierName: json['SupplierName'],
      productId: json['Product_ID'],
      productName: json['ProductName'],
      category: json['Category'],
      strength: json['Strength'],
      strengthLevel: json['StrengthLevel'],
      purchaseQty: json['PurchaseQty'],
      purchaseUnitPrice: json['PurchaseUnitPrice'],
      discount: json['Discount'],
      finalPurchaseUnitPrice: json['FinalPurchaseUnitPrice'],
      totalCost: json['TotalCost'],
      enteredBy: json['EnteredBy'],
    );
  }
}
```

#### Weekly Purchase Model
```dart
class WeeklyPurchaseResponse {
  final bool success;
  final String fromDate;
  final String toDate;
  final int totalRecords;
  final List<WeeklyPurchaseItem> data;
  final String message;

  WeeklyPurchaseResponse({
    required this.success,
    required this.fromDate,
    required this.toDate,
    required this.totalRecords,
    required this.data,
    required this.message,
  });

  factory WeeklyPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyPurchaseResponse(
      success: json['success'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      totalRecords: json['total_records'],
      data: (json['data'] as List).map((item) => WeeklyPurchaseItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class WeeklyPurchaseItem {
  final Supplier supplier;
  final Invoice invoice;
  final Product product;
  final Purchase purchase;
  final String enteredBy;

  WeeklyPurchaseItem({
    required this.supplier,
    required this.invoice,
    required this.product,
    required this.purchase,
    required this.enteredBy,
  });

  factory WeeklyPurchaseItem.fromJson(Map<String, dynamic> json) {
    return WeeklyPurchaseItem(
      supplier: Supplier.fromJson(json['Supplier']),
      invoice: Invoice.fromJson(json['Invoice']),
      product: Product.fromJson(json['Product']),
      purchase: Purchase.fromJson(json['Purchase']),
      enteredBy: json['EnteredBy'],
    );
  }
}

class Supplier {
  final String id;
  final String name;

  Supplier({
    required this.id,
    required this.name,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['ID'],
      name: json['Name'],
    );
  }
}

class Invoice {
  final String no;
  final String date;

  Invoice({
    required this.no,
    required this.date,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      no: json['No'],
      date: json['Date'],
    );
  }
}

class Purchase {
  final int quantity;
  final int unitPrice;
  final int discount;
  final int finalUnitPrice;
  final int totalCost;

  Purchase({
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.finalUnitPrice,
    required this.totalCost,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      quantity: json['Quantity'],
      unitPrice: json['UnitPrice'],
      discount: json['Discount'],
      finalUnitPrice: json['FinalUnitPrice'],
      totalCost: json['TotalCost'],
    );
  }
}
```

#### Monthly Purchase Model
```dart
class MonthlyPurchaseResponse {
  final bool success;
  final String month;
  final List<MonthlyPurchaseItem> data;
  final int totalRecords;
  final String message;

  MonthlyPurchaseResponse({
    required this.success,
    required this.month,
    required this.data,
    required this.totalRecords,
    required this.message,
  });

  factory MonthlyPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyPurchaseResponse(
      success: json['success'],
      month: json['month'],
      data: (json['data'] as List).map((item) => MonthlyPurchaseItem.fromJson(item)).toList(),
      totalRecords: json['total_records'],
      message: json['message'],
    );
  }
}

class MonthlyPurchaseItem {
  final String month;
  final String supplier;
  final String date;
  final String title;
  final int totalInvoices;
  final int totalPurchases;
  final String enteredBy;

  MonthlyPurchaseItem({
    required this.month,
    required this.supplier,
    required this.date,
    required this.title,
    required this.totalInvoices,
    required this.totalPurchases,
    required this.enteredBy,
  });

  factory MonthlyPurchaseItem.fromJson(Map<String, dynamic> json) {
    return MonthlyPurchaseItem(
      month: json['Month'],
      supplier: json['Supplier'],
      date: json['Date'],
      title: json['Title'],
      totalInvoices: json['Total Invoices'],
      totalPurchases: json['Total Purchases'],
      enteredBy: json['Entered By'],
    );
  }
}
```

#### Yearly Purchase Model
```dart
class YearlyPurchaseResponse {
  final bool success;
  final int year;
  final List<YearlyPurchaseItem> data;
  final int totalRecords;
  final String message;

  YearlyPurchaseResponse({
    required this.success,
    required this.year,
    required this.data,
    required this.totalRecords,
    required this.message,
  });

  factory YearlyPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return YearlyPurchaseResponse(
      success: json['success'],
      year: json['year'],
      data: (json['data'] as List).map((item) => YearlyPurchaseItem.fromJson(item)).toList(),
      totalRecords: json['total_records'],
      message: json['message'],
    );
  }
}

class YearlyPurchaseItem {
  final String supplier;
  final String month;
  final int totalInvoices;
  final int totalPurchase;
  final int totalDiscount;
  final int totalNet;
  final String enteredBy;

  YearlyPurchaseItem({
    required this.supplier,
    required this.month,
    required this.totalInvoices,
    required this.totalPurchase,
    required this.totalDiscount,
    required this.totalNet,
    required this.enteredBy,
  });

  factory YearlyPurchaseItem.fromJson(Map<String, dynamic> json) {
    return YearlyPurchaseItem(
      supplier: json['Supplier'],
      month: json['Month'],
      totalInvoices: json['Total Invoices'],
      totalPurchase: json['Total Purchase'],
      totalDiscount: json['Total Discount'],
      totalNet: json['Total Net'],
      enteredBy: json['Entered By'],
    );
  }
}
```

### Sale Report Models

#### Weekly Sale Model
```dart
class WeeklySaleResponse {
  final bool success;
  final String fromDate;
  final String toDate;
  final List<WeeklySaleItem> data;
  final String message;

  WeeklySaleResponse({
    required this.success,
    required this.fromDate,
    required this.toDate,
    required this.data,
    required this.message,
  });

  factory WeeklySaleResponse.fromJson(Map<String, dynamic> json) {
    return WeeklySaleResponse(
      success: json['success'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      data: (json['data'] as List).map((item) => WeeklySaleItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class WeeklySaleItem {
  final String customer;
  final String invoiceNo;
  final String invoiceDate;
  final String title;
  final double totalSales;
  final String enteredBy;

  WeeklySaleItem({
    required this.customer,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.title,
    required this.totalSales,
    required this.enteredBy,
  });

  factory WeeklySaleItem.fromJson(Map<String, dynamic> json) {
    return WeeklySaleItem(
      customer: json['Customer'],
      invoiceNo: json['Invoice No'],
      invoiceDate: json['Invoice Date'],
      title: json['Title'],
      totalSales: json['Total Sales'].toDouble(),
      enteredBy: json['Entered By'],
    );
  }
}
```

#### Monthly Sale Model
```dart
class MonthlySaleResponse {
  final bool success;
  final String month;
  final List<MonthlySaleItem> data;
  final String message;

  MonthlySaleResponse({
    required this.success,
    required this.month,
    required this.data,
    required this.message,
  });

  factory MonthlySaleResponse.fromJson(Map<String, dynamic> json) {
    return MonthlySaleResponse(
      success: json['success'],
      month: json['month'],
      data: (json['data'] as List).map((item) => MonthlySaleItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class MonthlySaleItem {
  final String month;
  final String customer;
  final String date;
  final String title;
  final int totalInvoices;
  final double totalSales;
  final String enteredBy;

  MonthlySaleItem({
    required this.month,
    required this.customer,
    required this.date,
    required this.title,
    required this.totalInvoices,
    required this.totalSales,
    required this.enteredBy,
  });

  factory MonthlySaleItem.fromJson(Map<String, dynamic> json) {
    return MonthlySaleItem(
      month: json['Month'],
      customer: json['Customer'],
      date: json['Date'],
      title: json['Title'],
      totalInvoices: json['Total Invoices'],
      totalSales: json['Total Sales'].toDouble(),
      enteredBy: json['Entered By'],
    );
  }
}
```

#### Yearly Sale Model
```dart
class YearlySaleResponse {
  final bool success;
  final int year;
  final List<YearlySaleItem> data;
  final String message;

  YearlySaleResponse({
    required this.success,
    required this.year,
    required this.data,
    required this.message,
  });

  factory YearlySaleResponse.fromJson(Map<String, dynamic> json) {
    return YearlySaleResponse(
      success: json['success'],
      year: json['year'],
      data: (json['data'] as List).map((item) => YearlySaleItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

class YearlySaleItem {
  final String customer;
  final String month;
  final int totalInvoices;
  final double totalSales;
  final double totalDiscount;
  final double totalNet;
  final String enteredBy;

  YearlySaleItem({
    required this.customer,
    required this.month,
    required this.totalInvoices,
    required this.totalSales,
    required this.totalDiscount,
    required this.totalNet,
    required this.enteredBy,
  });

  factory YearlySaleItem.fromJson(Map<String, dynamic> json) {
    return YearlySaleItem(
      customer: json['Customer'],
      month: json['Month'],
      totalInvoices: json['Total Invoices'],
      totalSales: json['Total Sales'].toDouble(),
      totalDiscount: json['Total Discount'].toDouble(),
      totalNet: json['Total Net'].toDouble(),
      enteredBy: json['Entered By'],
    );
  }
}
```

## MVC Architecture Guidelines

### 1. Model Layer
```dart
// Example: stock_model.dart
class StockResponse {
  final bool success;
  final String note;
  final int totalProducts;
  final List<StockItem> data;
  final String message;

  StockResponse({
    required this.success,
    required this.note,
    required this.totalProducts,
    required this.data,
    required this.message,
  });

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(
      success: json['success'],
      note: json['note'],
      totalProducts: json['total_products'],
      data: (json['data'] as List).map((item) => StockItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}

// Example: daily_purchase_model.dart
class DailyPurchaseResponse {
  final bool success;
  final List<DailyPurchaseItem> data;
  final String message;

  DailyPurchaseResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DailyPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return DailyPurchaseResponse(
      success: json['success'],
      data: (json['data'] as List).map((item) => DailyPurchaseItem.fromJson(item)).toList(),
      message: json['message'],
    );
  }
}
```

### 2. Controller Layer (with Provider)
```dart
// Example: stock_controller.dart
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
}

// Example: purchase_controller.dart
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
}

// Example: sale_controller.dart
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
}
```

### 3. View Layer
```dart
// Example: stock_screen.dart
class StockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockController(),
      child: Consumer<StockController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (controller.error != null) {
            return Center(child: Text(controller.error!));
          }
          
          if (controller.stockResponse == null) {
            return Center(child: Text('No stock data available'));
          }
          
          return ListView.builder(
            itemCount: controller.stockResponse!.data.length,
            itemBuilder: (context, index) {
              final stockItem = controller.stockResponse!.data[index];
              return StockItemCard(stockItem: stockItem);
            },
          );
        },
      ),
    );
  }
}

// Example: daily_purchase_screen.dart
class DailyPurchaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PurchaseController(),
      child: Consumer<PurchaseController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (controller.error != null) {
            return Center(child: Text(controller.error!));
          }
          
          if (controller.dailyPurchaseResponse == null) {
            return Center(child: Text('No daily purchase data available'));
          }
          
          return ListView.builder(
            itemCount: controller.dailyPurchaseResponse!.data.length,
            itemBuilder: (context, index) {
              final purchaseItem = controller.dailyPurchaseResponse!.data[index];
              return DailyPurchaseCard(purchaseItem: purchaseItem);
            },
          );
        },
      ),
    );
  }
}

// Example: weekly_sale_screen.dart
class WeeklySaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaleController(),
      child: Consumer<SaleController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (controller.error != null) {
            return Center(child: Text(controller.error!));
          }
          
          if (controller.weeklySaleResponse == null) {
            return Center(child: Text('No weekly sale data available'));
          }
          
          return ListView.builder(
            itemCount: controller.weeklySaleResponse!.data.length,
            itemBuilder: (context, index) {
              final saleItem = controller.weeklySaleResponse!.data[index];
              return WeeklySaleCard(saleItem: saleItem);
            },
          );
        },
      ),
    );
  }
}
```

## API Integration Guidelines

### 1. API Service Structure
```dart
class ApiService {
  static const String baseUrl = 'YOUR_API_BASE_URL';
  
  // Stock API
  Future<StockResponse> getAvailableStock() async {
    // Implementation with Dio or http
  }
  
  // Purchase APIs
  Future<DailyPurchaseResponse> getDailyPurchase() async {
    // Implementation with Dio or http
  }
  
  Future<WeeklyPurchaseResponse> getWeeklyPurchase() async {
    // Implementation with Dio or http
  }
  
  Future<MonthlyPurchaseResponse> getMonthlyPurchase() async {
    // Implementation with Dio or http
  }
  
  Future<YearlyPurchaseResponse> getYearlyPurchase() async {
    // Implementation with Dio or http
  }
  
  // Sale APIs
  Future<WeeklySaleResponse> getWeeklySale() async {
    // Implementation with Dio or http
  }
  
  Future<MonthlySaleResponse> getMonthlySale() async {
    // Implementation with Dio or http
  }
  
  Future<YearlySaleResponse> getYearlySale() async {
    // Implementation with Dio or http
  }
  
  // Daily Sale API (to be implemented when available)
  Future<dynamic> getDailySale() async {
    // Implementation with Dio or http
  }
}
```

## UI/UX Guidelines

### 1. Dashboard
- Clean, modern Material Design 3 interface
- Card-based layout for different report sections
- Quick access buttons for different time periods
- Summary cards showing key metrics

### 2. Report Screens
- **Filter Options**: Date range picker, period selector
- **Data Visualization**: Charts and graphs using fl_chart or syncfusion_flutter_charts
- **Export Options**: PDF/Excel export functionality
- **Search & Sort**: Advanced filtering capabilities

### 3. Common Components
- **Loading Widgets**: Skeleton screens and progress indicators
- **Error Handling**: User-friendly error messages
- **Empty States**: Appropriate empty state designs
- **Refresh**: Pull-to-refresh functionality

## State Management

### 1. Report States
```dart
enum ReportStatus { initial, loading, success, error }

class ReportState<T> {
  final ReportStatus status;
  final List<T> data;
  final String? error;
  final DateTime? lastUpdated;
}
```

### 2. Date Range Management
- Implement date range picker for custom periods
- Predefined periods (Today, This Week, This Month, This Year)
- Remember user's last selected period

## Performance Guidelines

### 1. Data Loading
- Implement pagination for large datasets
- Use lazy loading for charts and graphs
- Cache frequently accessed data

### 2. Memory Management
- Dispose controllers properly
- Use const constructors where possible
- Implement proper widget lifecycle management

## Error Handling

### 1. API Errors
- Network connectivity issues
- Server errors (500, 404, etc.)
- Authentication/Authorization errors
- Rate limiting

### 2. User Feedback
- Toast messages for quick feedback
- SnackBar for important notifications
- Dialog boxes for critical errors

## Testing Guidelines

### 1. Unit Tests
- Test all data models
- Test API service methods
- Test business logic

### 2. Widget Tests
- Test all report screens
- Test navigation flows
- Test user interactions

### 3. Integration Tests
- Test complete user journeys
- Test API integration
- Test error scenarios

## Code Quality Standards

### 1. Naming Conventions
- Use descriptive names for variables and functions
- Follow Dart naming conventions
- Use meaningful class and file names

### 2. Documentation
- Document all public APIs
- Add comments for complex business logic
- Maintain README with setup instructions

### 3. Code Organization
- Keep files under 300 lines
- Use proper separation of concerns
- Follow SOLID principles

## Security Considerations

### 1. API Security
- Use HTTPS for all API calls
- Handle sensitive data securely
- Implement proper error handling for API failures

### 2. Data Protection
- Don't store sensitive data in plain text
- Implement proper data validation
- Use secure storage for any cached data

## Dependencies to Add

```yaml
dependencies:
  flutter:
    sdk: flutter
  # State Management
  provider: ^6.0.0
  # HTTP Client
  dio: ^5.0.0
  # Charts
  fl_chart: ^0.62.0
  # Date/Time
  intl: ^0.18.0
  # UI Components
  flutter_svg: ^2.0.0
  cached_network_image: ^3.2.0
  # Utils
  shared_preferences: ^2.0.0
  # PDF Generation
  pdf: ^3.8.0
  # Excel Export
  excel: ^2.0.0
```

## Development Workflow

### 1. Feature Development (MVC Pattern)
1. Create data models in `model/` folder based on API response
2. Implement API service methods in `services/` folder
3. Create controllers in `controllers/` folder with Provider
4. Build UI components in `view/` folder
5. Connect controllers to views using Provider
6. Implement error handling and loading states
7. Add tests for models, controllers, and views

### 2. Code Review Checklist
- [ ] Follows naming conventions
- [ ] Proper error handling
- [ ] Includes tests
- [ ] No hardcoded values
- [ ] Proper documentation
- [ ] Performance considerations

## Notes for API Integration
- When API documentation is provided, update models in `model/` folder accordingly
- Implement proper error handling for each API endpoint in controllers
- Add loading states for all API calls using Provider
- Consider implementing offline support if needed
- Add retry mechanisms for failed API calls
- Use proper JSON serialization/deserialization in models

## Future Enhancements
- Real-time data updates
- Push notifications for important events
- Advanced analytics and insights
- Multi-language support
- Dark mode support
- Offline mode with data synchronization 