import 'package:go_router/go_router.dart';
import '../views/dashboard_view.dart';
import '../views/detalle_view.dart';
import '../views/listado_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
      routes: [
        GoRoute(
          path: 'list/:endpoint',
          name: 'list',
          builder: (context, state) => ListadoView(
            endpointKey: state.pathParameters['endpoint']!,
          ),
          routes: [
            GoRoute(
              path: 'detail/:id',
              name: 'detail',
              builder: (context, state) => DetalleView(
                endpointKey: state.pathParameters['endpoint']!,
                id: int.tryParse(state.pathParameters['id']!) ?? 0,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
