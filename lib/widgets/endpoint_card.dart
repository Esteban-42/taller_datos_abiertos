import 'package:flutter/material.dart';
import '../config/endpoints.dart';

class EndpointCard extends StatelessWidget {
  final EndpointConfig endpoint;
  final VoidCallback onTap;

  const EndpointCard({super.key, required this.endpoint, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(endpoint.icon, size: 48),
              const SizedBox(height: 8),
              Text(endpoint.title,
                  style: textTheme.titleMedium, textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(endpoint.description,
                  style: textTheme.bodySmall, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
