import 'package:flutter/material.dart';
import 'package:tubebazaar/Pages/Contracts/pending.dart';

import 'approved.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Applications"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Pending"),
            Tab(text: "Approved"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Pending(),
          Approved(),
        ],
      ),
    );
  }
}

// Placeholder for Pending Jobs



// Placeholder for Approved Jobs
