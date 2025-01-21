import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tab/tab_bloc.dart';
import '../widgets/app_drawer.dart';
import 'chat_tab.dart';

class HeaderScreen extends StatelessWidget {
  const HeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBloc(),
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Outlake'),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/outlayshake-logo.png',
                fit: BoxFit.contain, // Your logo here
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50), // Adjust the height for the tab bar
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Check if the screen width is large enough
                  if (constraints.maxWidth > 600) {
                    // For large screens (e.g. tablets, laptops)
                    return const TabBar(
                      isScrollable: false, // Fixed tabs without scrolling
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.chat),
                              SizedBox(width: 8),
                              Text('Chat'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.group),
                              SizedBox(width: 8),
                              Text('Group Outlay'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.account_balance_wallet),
                              SizedBox(width: 8),
                              Text('Self Outlay'),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    // For small screens (e.g. phones)
                    return const TabBar(
                      isScrollable: true, // Scrollable tabs
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.chat),
                              SizedBox(width: 8),
                              Text('Chat'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.group),
                              SizedBox(width: 8),
                              Text('Group Outlay'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.account_balance_wallet),
                              SizedBox(width: 8),
                              Text('Self Outlay'),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          endDrawer: AppDrawer(),
          body: const TabBarView(
            children: [
              ChatTab(tabIndex: 0), // Pass the tabIndex to each tab
              ChatTab(tabIndex: 1),
              ChatTab(tabIndex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
