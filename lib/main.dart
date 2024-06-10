import 'package:flutter/material.dart';
import 'package:item_tracker/common/custom_theme.dart';
import 'package:item_tracker/home_screen.dart';
import 'package:item_tracker/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Item Tracker',
        debugShowCheckedModeBanner: false,
        theme: BlackTheme.theme,
        home: HomeScreen(),
      ),
    ),
  );
}
