# Gull Pharma Admin

A Flutter admin application for managing pharmaceutical business reports including purchase reports, sale reports, and stock information.

## Features

### 📊 Reports Dashboard
- **Stock Reports**: View available inventory with product details
- **Purchase Reports**: 
  - Daily Purchase Reports
  - Weekly Purchase Reports  
  - Monthly Purchase Reports
  - Yearly Purchase Reports
- **Sale Reports**:
  - Weekly Sale Reports
  - Monthly Sale Reports
  - Yearly Sale Reports

### 🏗️ Architecture
- **MVC Pattern**: Model-View-Controller architecture
- **State Management**: Provider for reactive state management
- **API Integration**: Dio for HTTP requests with proper error handling
- **Material Design 3**: Modern UI with Material Design 3 components

## Project Structure

```
lib/
├── main.dart
├── model/
│   ├── stock_model.dart
│   ├── purchase_report_model.dart
│   └── sale_report_model.dart
├── view/
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   ├── stock_reports/
│   │   └── stock_screen.dart
│   ├── purchase_reports/
│   │   └── purchase_reports_screen.dart
│   └── sale_reports/
│       └── sale_reports_screen.dart
├── controllers/
│   ├── dashboard_controller.dart
│   ├── stock_controller.dart
│   ├── purchase_controller.dart
│   └── sale_controller.dart
└── services/
    ├── api_service.dart
    └── http_service.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd gull_pharma
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Base URL**
   - Open `lib/services/api_service.dart`
   - Replace `YOUR_API_BASE_URL` with your actual API base URL

4. **Run the application**
   ```bash
   flutter run
   ```

## API Configuration

The application expects the following API endpoints:

### Stock API
- `GET /api/stock/available` - Get available stock

### Purchase APIs
- `GET /api/purchase/daily` - Daily purchase reports
- `GET /api/purchase/weekly` - Weekly purchase reports
- `GET /api/purchase/monthly` - Monthly purchase reports
- `GET /api/purchase/yearly` - Yearly purchase reports

### Sale APIs
- `GET /api/sale/weekly` - Weekly sale reports
- `GET /api/sale/monthly` - Monthly sale reports
- `GET /api/sale/yearly` - Yearly sale reports

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0          # State management
  dio: ^5.0.0               # HTTP client
  fl_chart: ^0.62.0         # Charts
  intl: ^0.18.0             # Date/Time formatting
  flutter_svg: ^2.0.0       # SVG support
  cached_network_image: ^3.2.0  # Image caching
  shared_preferences: ^2.0.0 # Local storage
  pdf: ^3.8.0               # PDF generation
  excel: ^2.0.0             # Excel export
```

## Features

### 📱 User Interface
- **Bottom Navigation**: Easy navigation between different report sections
- **Tabbed Reports**: Organized tabs for different time periods
- **Pull-to-Refresh**: Refresh data by pulling down
- **Error Handling**: User-friendly error messages with retry options
- **Loading States**: Progress indicators during data fetching

### 🔄 State Management
- **Provider Pattern**: Reactive state management
- **Loading States**: Proper loading indicators
- **Error Handling**: Comprehensive error handling
- **Data Caching**: Efficient data management

### 🌐 API Integration
- **Dio HTTP Client**: Robust HTTP requests
- **Error Handling**: Network error handling
- **Timeout Management**: Request timeout handling
- **Logging**: Request/response logging for debugging

## Usage

1. **Dashboard**: View summary cards with key metrics
2. **Stock**: Browse available inventory with product details
3. **Purchase Reports**: Navigate through different purchase report periods
4. **Sale Reports**: View sales data across different time periods

## Development

### Adding New Reports
1. Create model classes in `lib/model/`
2. Add API methods in `lib/services/api_service.dart`
3. Create controller in `lib/controllers/`
4. Build UI components in `lib/view/`

### Code Style
- Follow Dart naming conventions
- Use meaningful variable and function names
- Add proper documentation for public APIs
- Implement proper error handling

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please contact the development team.
