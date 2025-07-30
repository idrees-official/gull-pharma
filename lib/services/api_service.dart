import 'package:dio/dio.dart';
import '../model/stock_model.dart';
import '../model/purchase_report_model.dart';
import '../model/sale_report_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/pharma/public/api';
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors for logging and error handling
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // Stock API
  Future<StockResponse> getAvailableStock() async {
    try {
      final response = await _dio.get('/stock-levels');
      return StockResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch stock data: $e');
    }
  }

  // Purchase APIs
  Future<DailyPurchaseResponse> getDailyPurchase() async {
    try {
      final response = await _dio.get('/daily-purchases');
      return DailyPurchaseResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch daily purchase data: $e');
    }
  }

  Future<WeeklyPurchaseResponse> getWeeklyPurchase() async {
    try {
      final response = await _dio.get('/weekly-purchases');
      return WeeklyPurchaseResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch weekly purchase data: $e');
    }
  }

  Future<MonthlyPurchaseResponse> getMonthlyPurchase() async {
    try {
      final response = await _dio.get('/current-month-purchases');
      return MonthlyPurchaseResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch monthly purchase data: $e');
    }
  }

  Future<YearlyPurchaseResponse> getYearlyPurchase() async {
    try {
      final response = await _dio.get('/yearly-purchases-by-supplier');
      return YearlyPurchaseResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch yearly purchase data: $e');
    }
  }

  // Sale APIs
  Future<WeeklySaleResponse> getWeeklySale() async {
    try {
      final response = await _dio.get('/recent-sales');
      return WeeklySaleResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch weekly sale data: $e');
    }
  }

  Future<MonthlySaleResponse> getMonthlySale() async {
    try {
      final response = await _dio.get('/current-month-sales');
      return MonthlySaleResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch monthly sale data: $e');
    }
  }

  Future<YearlySaleResponse> getYearlySale() async {
    try {
      final response = await _dio.get('/yearly-sales-by-customer');
      return YearlySaleResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch yearly sale data: $e');
    }
  }

  // Daily Sale API (to be implemented when available)
  Future<dynamic> getDailySale() async {
    try {
      final response = await _dio.get('/today-purchases');
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch daily sale data: $e');
    }
  }

  // Error handling helper
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error';
        return 'HTTP $statusCode: $message';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return 'An unexpected error occurred: ${e.message}';
    }
  }
} 