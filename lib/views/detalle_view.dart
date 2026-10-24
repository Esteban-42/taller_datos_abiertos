import 'package:flutter/material.dart';
import '../config/endpoints.dart';
import '../models/api_item.dart';
import '../services/api_colombia_service.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class DetalleView extends StatefulWidget {
  final String endpointKey;
  final int id;
  const DetalleView({super.key, required this.endpointKey, required this.id});

  @override
  State<DetalleView> createState() => _DetalleViewState();
}

class _DetalleViewState extends State<DetalleView> {
  final _service = ApiColombiaService();
  Future<ApiItem>? _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final e = findEndpoint(widget.endpointKey);
    if (e != null) _future = _service.fetchById(e, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_future == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: Text('Endpoint no válido')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: FutureBuilder<ApiItem>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          }
          if (snap.hasError) {
            return ErrorView(
              message: snap.error.toString(),
              onRetry: () => setState(_load),
            );
          }
          final it = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (it.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    it.imageUrl!,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 80),
                  ),
                ),
              const SizedBox(height: 16),
              Text(it.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              if (it.description != null) Text(it.description!),
              const Divider(height: 32),
              ...it.details.entries.map(
                (d) => ListTile(
                  dense: true,
                  title: Text(d.key),
                  subtitle: Text(d.value),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
