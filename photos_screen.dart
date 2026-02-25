import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../models/photo_dto.dart';
import '../state/app_scope.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  List<PhotoDto> _mockData() => [
        PhotoDto(
          id: '1',
          title: 'Mountains',
          imageUrl: 'https://picsum.photos/id/1018/600/400',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          price: 12.5,
        ),
        PhotoDto(
          id: '2',
          title: 'City',
          imageUrl: 'https://picsum.photos/id/1025/600/400',
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          price: 19.99,
        ),
        PhotoDto(
          id: '3',
          title: 'Sea',
          imageUrl: 'https://picsum.photos/id/1011/600/400',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          price: 7.0,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final localeCode = scope.locale.value.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(localeCode == 'ru' ? 'Фото' : 'Photos'),
        actions: [
          IconButton(
            onPressed: scope.locale.toggleRuEn,
            icon: const Icon(Icons.language),
            tooltip: 'ru/en',
          ),
          IconButton(
            onPressed: () => context.go('/settings?tab=security'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _mockData().length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _mockData()[index];

          final money = NumberFormat.simpleCurrency(locale: localeCode).format(item.price);
          final date = DateFormat.yMMMMd(localeCode).format(item.createdAt);

          return InkWell(
            onTap: () => context.go('/photo/${item.id}'),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(
                        height: 200,
                        child: Center(child: Icon(Icons.broken_image, size: 40)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 6),
                        Text('$date • $money'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
