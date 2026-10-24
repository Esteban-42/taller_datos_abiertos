import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/endpoints.dart';
import '../models/api_item.dart';
import '../services/api_colombia_service.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class ListadoView extends StatefulWidget {
  final String endpointKey;
  const ListadoView({super.key, required this.endpointKey});

  @override
  State<ListadoView> createState() => _ListadoViewState();
}

class _ListadoViewState extends State<ListadoView> {
  final _service = ApiColombiaService();
  late final EndpointConfig? _endpoint = findEndpoint(widget.endpointKey);
  Future<List<ApiItem>>? _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    if (_endpoint != null) _future = _service.fetchAll(_endpoint!);
  }

  @override
  Widget build(BuildContext context) {
    final e = _endpoint;
    if (e == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Endpoint no válido')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(e.title)),
      body: FutureBuilder<List<ApiItem>>(
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
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Sin resultados'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final it = items[i];
              return ListTile(
                leading: it.imageUrl != null
                    ? CircleAvatar(backgroundImage: NetworkImage(it.imageUrl!))
                    : CircleAvatar(child: Icon(e.icon)),
                title: Text(it.title),
                subtitle: it.subtitle != null ? Text(it.subtitle!) : null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed(
                  'detail',
                  pathParameters: {'endpoint': e.key, 'id': '${it.id}'},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
