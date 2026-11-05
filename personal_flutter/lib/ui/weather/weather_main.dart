import 'package:flutter/material.dart';

/// A simple reusable widget.
///
/// Insert it inside another view:
/// ```dart
/// body: const DraftPage(title: 'Hello', message: 'My custom widget'),
/// ```
///
/// Or push it as a new screen:
/// ```dart
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (_) => const DraftPage()),
// );
/// ```
class DraftPage extends StatelessWidget {
  const DraftPage({
    super.key,
    this.title = 'Draft',
    this.message = 'This is a draft page.',
    this.onPressed,
  });

  final String title;
  final String message;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: Theme.of(context).textTheme.titleMedium),
              if (onPressed != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Press me'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
