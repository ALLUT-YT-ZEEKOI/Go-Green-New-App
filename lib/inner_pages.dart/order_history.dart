import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:provider/provider.dart';

import 'Widgets/orderbox.dart';
import 'Widgets/myordertab.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        apiProvider.updateorderPreload(true);
        if (apiProvider.ordertab == 0) {
          apiProvider.getorders(more: false, count: 0);
        } else if (apiProvider.ordertab == 1) {
          apiProvider.getorders(more: false, status: 'delivered', count: 0);
        } else if (apiProvider.ordertab == 2) {
          apiProvider.getorders(more: false, status: 'cancelled', count: 0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFF6F6F6),
          shadowColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  mainProvider.pageType = 0;
                  mainProvider.notify();
                },
                child: Image.asset('assets/icons/left-broken.png', width: 40, color: const Color(0xFF1D2730))),
          ),
          title: const Row(
              mainAxisAlignment: MainAxisAlignment.start, children: [Text('My Orders', style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))]),
          actions: const [SizedBox(width: 60)],
        ),
        body: Container(
          color: const Color(0xFFF6F6F6),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const MyOrderTab(),
              Expanded(
                child: apiProvider.orderPreload
                    ? const Center(child: CircularProgressIndicator())
                    : apiProvider.ordertab == 0
                        ? AllOrderList(apiProvider: apiProvider)
                        : apiProvider.ordertab == 1
                            ? AllDeliveredList(apiProvider: apiProvider)
                            : apiProvider.ordertab == 2
                                ? AllCancelledList(apiProvider: apiProvider)
                                : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllCancelledList extends StatelessWidget {
  const AllCancelledList({super.key, required this.apiProvider});
  final ApiProvider apiProvider;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return apiProvider.allCancelled.isEmpty
        ? ListView(
            children: [
              SizedBox(height: size.height * 0.6, child: const Center(child: Text('No Orders'))),
            ],
          )
        : ListView(
            children: [
              for (Order i in apiProvider.allCancelled) OrderBox(order: i),
              if (apiProvider.allCancelledcurrentpage < apiProvider.allCancelledfinalpage)
                apiProvider.moreOrderPreload
                    ? const Padding(padding: EdgeInsets.symmetric(vertical: 25), child: Center(child: LinearProgressIndicator(color: Colors.green, minHeight: 1)))
                    : InkWell(
                        onTap: () {
                          apiProvider.updateMoreOrderPreload(true);
                          apiProvider.getorders(more: true, status: 'cancelled', count: 0);
                        },
                        child: const Icon(Icons.keyboard_arrow_down_outlined, size: 35))
            ],
          );
  }
}

class AllDeliveredList extends StatelessWidget {
  const AllDeliveredList({super.key, required this.apiProvider});
  final ApiProvider apiProvider;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return apiProvider.allDeliverd.isEmpty
        ? ListView(children: [SizedBox(height: size.height * 0.6, child: const Center(child: Text('No Orders')))])
        : ListView(
            children: [
              for (Order i in apiProvider.allDeliverd) OrderBox(order: i),
              if (apiProvider.allDeliverdcurrentpage < apiProvider.allDeliverdfinalpage)
                apiProvider.moreOrderPreload
                    ? const Padding(padding: EdgeInsets.symmetric(vertical: 25), child: Center(child: LinearProgressIndicator(color: Colors.green, minHeight: 1)))
                    : InkWell(
                        onTap: () {
                          apiProvider.updateMoreOrderPreload(true);
                          apiProvider.getorders(more: true, status: 'deliverd', count: 0);
                        },
                        child: const Icon(Icons.keyboard_arrow_down_outlined, size: 35))
            ],
          );
  }
}

class AllOrderList extends StatelessWidget {
  const AllOrderList({super.key, required this.apiProvider});
  final ApiProvider apiProvider;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return apiProvider.allOrders.isEmpty
        ? ListView(
            children: [
              SizedBox(height: size.height * 0.6, child: const Center(child: Text('No Orders'))),
            ],
          )
        : ListView(
            children: [
              for (Order i in apiProvider.allOrders) OrderBox(order: i),
              if (apiProvider.allOrderscurrentpage < apiProvider.allordersfinalpage)
                apiProvider.moreOrderPreload
                    ? const Padding(padding: EdgeInsets.symmetric(vertical: 25), child: Center(child: LinearProgressIndicator(color: Colors.green, minHeight: 1)))
                    : InkWell(
                        onTap: () {
                          apiProvider.updateMoreOrderPreload(true);
                          apiProvider.getorders(more: true, count: 0);
                        },
                        child: const Icon(Icons.keyboard_arrow_down_outlined, size: 35))
            ],
          );
  }
}
