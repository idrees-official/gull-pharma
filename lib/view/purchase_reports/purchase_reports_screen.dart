import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/purchase_controller.dart';
import '../../model/purchase_report_model.dart';

class PurchaseReportsScreen extends StatefulWidget {
  const PurchaseReportsScreen({super.key});

  @override
  State<PurchaseReportsScreen> createState() => _PurchaseReportsScreenState();
}

class _PurchaseReportsScreenState extends State<PurchaseReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
    final controller = context.read<PurchaseController>();
    switch (index) {
      case 0:
        controller.fetchDailyPurchase();
        break;
      case 1:
        controller.fetchWeeklyPurchase();
        break;
      case 2:
        controller.fetchMonthlyPurchase();
        break;
      case 3:
        controller.fetchYearlyPurchase();
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
              Tab(text: 'Daily'),
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
              DailyPurchaseTab(),
              WeeklyPurchaseTab(),
              MonthlyPurchaseTab(),
              YearlyPurchaseTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class DailyPurchaseTab extends StatefulWidget {
  const DailyPurchaseTab({super.key});

  @override
  State<DailyPurchaseTab> createState() => _DailyPurchaseTabState();
}

class _DailyPurchaseTabState extends State<DailyPurchaseTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseController>().fetchDailyPurchase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseController>(
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
                Text('Error loading daily purchase data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchDailyPurchase(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.dailyPurchaseResponse == null) {
          return const Center(child: Text('No daily purchase data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchDailyPurchase(),
          child: ListView.builder(
            itemCount: controller.dailyPurchaseResponse!.data.length,
            itemBuilder: (context, index) {
              final purchaseItem = controller.dailyPurchaseResponse!.data[index];
              return DailyPurchaseCard(purchaseItem: purchaseItem);
            },
          ),
        );
      },
    );
  }
}

class DailyPurchaseCard extends StatelessWidget {
  final DailyPurchaseItem purchaseItem;

  const DailyPurchaseCard({
    super.key,
    required this.purchaseItem,
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
                    purchaseItem.productName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${purchaseItem.totalCost}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Invoice: ${purchaseItem.invoiceNo}'),
            Text('Supplier: ${purchaseItem.supplierName}'),
            Text('Date: ${purchaseItem.invoiceDate}'),
            Text('Quantity: ${purchaseItem.purchaseQty}'),
            Text('Unit Price: \$${purchaseItem.purchaseUnitPrice}'),
            Text('Discount: \$${purchaseItem.discount}'),
            Text('Final Price: \$${purchaseItem.finalPurchaseUnitPrice}'),
            Text('Category: ${purchaseItem.category}'),
            Text('Strength: ${purchaseItem.strength} ${purchaseItem.strengthLevel}'),
            Text('Entered By: ${purchaseItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
}

class WeeklyPurchaseTab extends StatefulWidget {
  const WeeklyPurchaseTab({super.key});

  @override
  State<WeeklyPurchaseTab> createState() => _WeeklyPurchaseTabState();
}

class _WeeklyPurchaseTabState extends State<WeeklyPurchaseTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseController>().fetchWeeklyPurchase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseController>(
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
                Text('Error loading weekly purchase data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchWeeklyPurchase(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.weeklyPurchaseResponse == null) {
          return const Center(child: Text('No weekly purchase data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchWeeklyPurchase(),
          child: ListView.builder(
            itemCount: controller.weeklyPurchaseResponse!.data.length,
            itemBuilder: (context, index) {
              final purchaseItem = controller.weeklyPurchaseResponse!.data[index];
              return WeeklyPurchaseCard(purchaseItem: purchaseItem);
            },
          ),
        );
      },
    );
  }
}

class WeeklyPurchaseCard extends StatelessWidget {
  final WeeklyPurchaseItem purchaseItem;

  const WeeklyPurchaseCard({
    super.key,
    required this.purchaseItem,
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
                    purchaseItem.product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${purchaseItem.purchase.totalCost}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Supplier: ${purchaseItem.supplier.name}'),
            Text('Invoice: ${purchaseItem.invoice.no}'),
            Text('Date: ${purchaseItem.invoice.date}'),
            Text('Quantity: ${purchaseItem.purchase.quantity}'),
            Text('Unit Price: \$${purchaseItem.purchase.unitPrice}'),
            Text('Discount: \$${purchaseItem.purchase.discount}'),
            Text('Final Price: \$${purchaseItem.purchase.finalUnitPrice}'),
            Text('Entered By: ${purchaseItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
}

class MonthlyPurchaseTab extends StatefulWidget {
  const MonthlyPurchaseTab({super.key});

  @override
  State<MonthlyPurchaseTab> createState() => _MonthlyPurchaseTabState();
}

class _MonthlyPurchaseTabState extends State<MonthlyPurchaseTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseController>().fetchMonthlyPurchase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseController>(
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
                Text('Error loading monthly purchase data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchMonthlyPurchase(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.monthlyPurchaseResponse == null) {
          return const Center(child: Text('No monthly purchase data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchMonthlyPurchase(),
          child: ListView.builder(
            itemCount: controller.monthlyPurchaseResponse!.data.length,
            itemBuilder: (context, index) {
              final purchaseItem = controller.monthlyPurchaseResponse!.data[index];
              return MonthlyPurchaseCard(purchaseItem: purchaseItem);
            },
          ),
        );
      },
    );
  }
}

class MonthlyPurchaseCard extends StatelessWidget {
  final MonthlyPurchaseItem purchaseItem;

  const MonthlyPurchaseCard({
    super.key,
    required this.purchaseItem,
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
                    purchaseItem.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${purchaseItem.totalPurchases}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Month: ${purchaseItem.month}'),
            Text('Supplier: ${purchaseItem.supplier}'),
            Text('Date: ${purchaseItem.date}'),
            Text('Total Invoices: ${purchaseItem.totalInvoices}'),
            Text('Entered By: ${purchaseItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
}

class YearlyPurchaseTab extends StatefulWidget {
  const YearlyPurchaseTab({super.key});

  @override
  State<YearlyPurchaseTab> createState() => _YearlyPurchaseTabState();
}

class _YearlyPurchaseTabState extends State<YearlyPurchaseTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PurchaseController>().fetchYearlyPurchase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseController>(
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
                Text('Error loading yearly purchase data'),
                const SizedBox(height: 8),
                Text(controller.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchYearlyPurchase(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.yearlyPurchaseResponse == null) {
          return const Center(child: Text('No yearly purchase data available'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchYearlyPurchase(),
          child: ListView.builder(
            itemCount: controller.yearlyPurchaseResponse!.data.length,
            itemBuilder: (context, index) {
              final purchaseItem = controller.yearlyPurchaseResponse!.data[index];
              return YearlyPurchaseCard(purchaseItem: purchaseItem);
            },
          ),
        );
      },
    );
  }
}

class YearlyPurchaseCard extends StatelessWidget {
  final YearlyPurchaseItem purchaseItem;

  const YearlyPurchaseCard({
    super.key,
    required this.purchaseItem,
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
                    '${purchaseItem.supplier} - ${purchaseItem.month}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$${purchaseItem.totalNet}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Total Invoices: ${purchaseItem.totalInvoices}'),
            Text('Total Purchase: \$${purchaseItem.totalPurchase}'),
            Text('Total Discount: \$${purchaseItem.totalDiscount}'),
            Text('Total Net: \$${purchaseItem.totalNet}'),
            Text('Entered By: ${purchaseItem.enteredBy}'),
          ],
        ),
      ),
    );
  }
} 