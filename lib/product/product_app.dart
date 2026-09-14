import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens.dart';
import 'velmora_store.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VelmoraStore(),
      child: MaterialApp(
        title: 'Velmora',
        home: const VelmoraHome(),
      ),
    );
  }
}
