import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/sale_controller.dart';
import '../../model/sale_report_model.dart';

class SaleReportsScreen extends StatefulWidget {
  const SaleReportsScreen({super.key});

  @override
  State<SaleReportsScreen> createState() => _SaleReportsScreenState();
}

class _SaleReportsScreenState extends State<SaleReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _loadDataForTab(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadDataForTab(int index) {
    final controller = context.read<SaleController>();
    switch (index) {
      case 0:
        controller.fetchWeeklySale();
        break;
      case 1:
        controller.fetchMonthlySale();
        break;
      case 2:
        controller.fetchYearlySale();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
            unselectedLabelColor: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
            tabs: const [
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
              Tab(text: 'Yearly'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              WeeklySaleTab(),
              MonthlySaleTab(),
              YearlySaleTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class WeeklySaleTab extends StatefulWidget {
  const WeeklySaleTab({super.key});

  @override
  State<WeeklySaleTab> createState() => _WeeklySaleTabState();
}

class _WeeklySaleTabState extends State<WeeklySaleTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SaleController>().fetchWeeklySale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading weekly sale data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchWeeklySale(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.weeklySaleResponse == null) {
          return const Center(child: Text('No weekly sale data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchWeeklySale(),
          child: ListView.builder(
            itemCount: controller.weeklySaleResponse!.data.length,
            itemBuilder: (context, index) {
              final saleItem = controller.weeklySaleResponse!.data[index];
              return WeeklySaleCard(saleItem: saleItem);
            },
          ),
        );
      },
    );
  }
}

class WeeklySaleCard extends StatelessWidget {
  final WeeklySaleItem saleItem;

  const WeeklySaleCard({
    super.key,
    required this.saleItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    saleItem.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${saleItem.totalSales.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Customer: ${saleItem.customer}'),
            Text('Invoice No: ${saleItem.invoiceNo}'),
            Text('Invoice Date: ${saleItem.invoiceDate}'),
            Text('Entered By: ${saleItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
}

class MonthlySaleTab extends StatefulWidget {
  const MonthlySaleTab({super.key});

  @override
  State<MonthlySaleTab> createState() => _MonthlySaleTabState();
}

class _MonthlySaleTabState extends State<MonthlySaleTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SaleController>().fetchMonthlySale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading monthly sale data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchMonthlySale(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.monthlySaleResponse == null) {
          return const Center(child: Text('No monthly sale data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchMonthlySale(),
          child: ListView.builder(
            itemCount: controller.monthlySaleResponse!.data.length,
            itemBuilder: (context, index) {
              final saleItem = controller.monthlySaleResponse!.data[index];
              return MonthlySaleCard(saleItem: saleItem);
            },
          ),
        );
      },
    );
  }
}

class MonthlySaleCard extends StatelessWidget {
  final MonthlySaleItem saleItem;

  const MonthlySaleCard({
    super.key,
    required this.saleItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    saleItem.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${saleItem.totalSales.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Month: ${saleItem.month}'),
            Text('Customer: ${saleItem.customer}'),
            Text('Date: ${saleItem.date}'),
            Text('Total Invoices: ${saleItem.totalInvoices}'),
            Text('Entered By: ${saleItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
}

class YearlySaleTab extends StatefulWidget {
  const YearlySaleTab({super.key});

  @override
  State<YearlySaleTab> createState() => _YearlySaleTabState();
}

class _YearlySaleTabState extends State<YearlySaleTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SaleController>().fetchYearlySale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading yearly sale data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchYearlySale(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.yearlySaleResponse == null) {
          return const Center(child: Text('No yearly sale data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchYearlySale(),
          child: ListView.builder(
            itemCount: controller.yearlySaleResponse!.data.length,
            itemBuilder: (context, index) {
              final saleItem = controller.yearlySaleResponse!.data[index];
              return YearlySaleCard(saleItem: saleItem);
            },
          ),
        );
      },
    );
  }
}

class YearlySaleCard extends StatelessWidget {
  final YearlySaleItem saleItem;

  const YearlySaleCard({
    super.key,
    required this.saleItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${saleItem.customer} - ${saleItem.month}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${saleItem.totalNet.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Total Invoices: ${saleItem.totalInvoices}'),
            Text('Total Sales: \$${saleItem.totalSales.toStringAsFixed(2)}'),
            Text('Total Discount: \$${saleItem.totalDiscount.toStringAsFixed(2)}'),
            Text('Total Net: \$${saleItem.totalNet.toStringAsFixed(2)}'),
            Text('Entered By: ${saleItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
} 