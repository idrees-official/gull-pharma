import 'stock_model.dart';

// Daily Purchase Model
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

// Weekly Purchase Model
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

// Monthly Purchase Model
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

// Yearly Purchase Model
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