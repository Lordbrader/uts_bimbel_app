import 'package:flutter/material.dart';
import '../models/class_model.dart';

class ClassDetailScreen extends StatelessWidget {
  final BimbelClass item;
  const ClassDetailScreen({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(item.image, height: 250, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Oleh: ${item.teacher}", style: const TextStyle(color: Colors.grey)),
                const Divider(height: 40),
                Text("Jadwal: ${item.schedule}", style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(item.description),
              ]),
            )
          ],
        ),
      ),
    );
  }
}