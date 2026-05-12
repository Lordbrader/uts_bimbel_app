import 'package:flutter/material.dart';
import '../models/class_model.dart';
import '../screens/class_detail_screen.dart';

class ClassCard extends StatelessWidget {
  final BimbelClass classItem;
  const ClassCard({super.key, required this.classItem});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(classItem.image, width: 60, fit: BoxFit.cover)),
        title: Text(classItem.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Rp ${classItem.price}"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ClassDetailScreen(item: classItem))),
      ),
    );
  }
}