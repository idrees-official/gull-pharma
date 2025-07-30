// Weekly Sale Model
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

// Monthly Sale Model
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

// Yearly Sale Model
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