import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/photo_dto.dart';
import '../state/app_scope.dart';

class PhotoDetailsScreen extends StatelessWidget {
  final String id;
  const PhotoDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final localeCode = scope.locale.value.languageCode;

    // Демонстрация JSON (как будто пришло с бэка)
    final json = {
      "id": id,
      "title": "Details for #$id",
      "imageUrl": "https://picsum.photos/id/1020/800/500",
      "createdAt": DateTime.now().toIso8601String(),
      "price": 25.0
    };

    final dto = PhotoDto.fromJson(json);
    final backToJson = dto.toJson(); // <- fromJson/toJson работают

    final money = NumberFormat.simpleCurrency(locale: localeCode).format(dto.price);
    final date = DateFormat.yMMMMd(localeCode).format(dto.createdAt);

    return Scaffold(
      appBar: AppBar(title: Text(dto.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${dto.id}'),
            const SizedBox(height: 8),
            Text('$date • $money'),
            const SizedBox(height: 16),
            Text('toJson():'),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(backToJson.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
