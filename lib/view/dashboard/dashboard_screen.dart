import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/stock_controller.dart';
import '../../controllers/purchase_controller.dart';
import '../../controllers/sale_controller.dart';
import '../stock_reports/stock_screen.dart';
import '../purchase_reports/purchase_reports_screen.dart';
import '../sale_reports/sale_reports_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _screens = [
    // const DashboardHome(), // Commented out Dashboard tab
    const StockScreen(),
    const PurchaseReportsScreen(),
    const SaleReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => StockController()),
        ChangeNotifierProvider(create: (_) => PurchaseController()),
        ChangeNotifierProvider(create: (_) => SaleController()),
      ],
      child: Consumer<DashboardController>(
        builder: (context, dashboardController, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Gull Pharma Admin'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              elevation: 2,
            ),
            body: _screens[dashboardController.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: dashboardController.selectedIndex,
              onTap: dashboardController.setSelectedIndex,
              items: const [
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.dashboard),
                //   label: 'Dashboard',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory),
                  label: 'Stock',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Purchase',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.point_of_sale),
                  label: 'Sales',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder: (context, dashboardController, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Gull Pharma Admin',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildSummaryCard(
                      context,
                      'Total Products',
                      '${dashboardController.totalProducts}',
                      Icons.inventory,
                      Colors.blue,
                    ),
                    _buildSummaryCard(
                      context,
                      'Total Sales',
                      '\$${dashboardController.totalSales.toStringAsFixed(2)}',
                      Icons.point_of_sale,
                      Colors.green,
                    ),
                    _buildSummaryCard(
                      context,
                      'Total Purchases',
                      '\$${dashboardController.totalPurchases.toStringAsFixed(2)}',
                      Icons.shopping_cart,
                      Colors.orange,
                    ),
                    _buildSummaryCard(
                      context,
                      'Reports',
                      'View All',
                      Icons.assessment,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 