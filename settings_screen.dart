import 'package:flutter/material.dart';

import '../state/app_scope.dart';

class SettingsScreen extends StatefulWidget {
  final String tab;
  const SettingsScreen({super.key, required this.tab});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = TextEditingController(text: 'demo_token_123');
  String? _saved;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final scope = AppScope.of(context);
    final token = await scope.tokenStorage.readToken();
    setState(() => _saved = token);
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings (${widget.tab})')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Token (demo)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await scope.tokenStorage.saveToken(_controller.text.trim());
                    await _load();
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () async {
                    await scope.tokenStorage.clearToken();
                    await _load();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Saved token: ${_saved ?? "(empty)"}'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
