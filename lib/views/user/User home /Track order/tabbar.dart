import 'package:flutter/material.dart';

import '../bottomnavigation.dart';
import 'pending.dart';
import 'rejected.dart';
import 'success.dart';

class View extends StatefulWidget {
  View({
    Key? key,
  }) : super(key: key);

  @override
  State<View> createState() => _HisabState();
}

class _HisabState extends State<View> with SingleTickerProviderStateMixin {
  late TabController _tabController1;
  @override
  void initState() {
    // initialise your tab controller here

    super.initState();
    _tabController1 = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Bottomsheet()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'View order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: TabBar(
                  controller: _tabController1,
                  unselectedLabelColor: Color(0xff9890B8),
                  labelColor: Color(0xff28476E),
                  // labelPadding: EdgeInsets.symmetric(horizontal: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  tabs: <Widget>[
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pending ',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Rejected',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Received',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController1,
                  children: [
                    Pendingorders(),
                    Rejectedorders(),
                    Successgorders()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
