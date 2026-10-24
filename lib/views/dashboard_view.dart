import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/endpoints.dart';
import '../widgets/endpoint_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Abiertos de Colombia')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: endpoints.length,
        itemBuilder: (_, i) {
          final e = endpoints[i];
          return EndpointCard(
            endpoint: e,
            onTap: () => context
                .pushNamed('list', pathParameters: {'endpoint': e.key}),
          );
        },
      ),
    );
  }
}
