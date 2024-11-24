import 'package:flutter/material.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/object.dart';
import 'package:gogreen_lite/customPackages/custom_toggle4.dart';
import 'package:provider/provider.dart';

import '../extrafunctions.dart';
import 'Widgets/subscription_box.dart';

class MySub extends StatelessWidget {
  const MySub({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final apiProvider = Provider.of<ApiProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFF6F6F6),
        shadowColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              mainProvider.pageType == 0 ? mainProvider.homepageIndex = 0 : mainProvider.pageType = 0;
              mainProvider.notify();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/left-broken.png', color: const Color(0xFF1D2730)),
            )),
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('My Subscriptions', style: TextStyle(color: Color(0xFF1D2730), fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500))]),
        actions: const [SizedBox(width: 60)],
      ),
      body: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshIndicator(
          onRefresh: () async {
            apiProvider.loadSubscription(0);
            apiProvider.subsctiptiontab = 0;
            apiProvider.notify();
          },
          child: Column(
            children: [
              Container(
                color: const Color(0xFFF6F6F6),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SubCustomToggle(
                  l1: 'All(${apiProvider.mysubscription.length})',
                  l2: 'Active(${checkAnyactivecount(apiProvider.mysubscription)})',
                  l3: 'Paused(${pausedCount(apiProvider.mysubscription)})',
                  l4: 'Cancelled(${checkcancelledcount(apiProvider.mysubscription)})',
                  f1: () {
                    apiProvider.subsctiptiontab = 0;
                    apiProvider.notify();
                  },
                  f2: () {
                    apiProvider.subsctiptiontab = 1;
                    apiProvider.notify();
                  },
                  f3: () {
                    apiProvider.subsctiptiontab = 2;
                    apiProvider.notify();
                  },
                  f4: () {
                    apiProvider.subsctiptiontab = 3;
                    apiProvider.notify();
                  },
                  selected: apiProvider.subsctiptiontab,
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFF6F6F6),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: filterSub(apiProvider.mysubscription, apiProvider.subsctiptiontab).isEmpty
                      ? ListView.builder(
                          itemCount: 1, // Specify the number of items in the ListView
                          itemBuilder: (context, index) {
                            return SizedBox(height: size.height * 0.8, child: const Center(child: Text('Nothing to display')));
                          },
                        )
                      : ListView(
                          children: [for (Subscription sub in filterSub(apiProvider.mysubscription, apiProvider.subsctiptiontab)) SubscriptionBox(subscription: sub), const SizedBox(height: 50)],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
