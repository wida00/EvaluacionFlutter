import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_state_providers.dart';
import '../../features/persons/domain/entities/person.dart';
import '../../features/persons/presentation/pages/create_edit_person_page.dart';
import '../../features/persons/presentation/pages/home_page.dart';
import '../../features/persons/presentation/pages/medicos_page.dart';
import '../../features/persons/presentation/pages/pacientes_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String pacientes = '/pacientes';
  static const String medicos = '/medicos';
  static const String createPaciente = '/pacientes/create';
  static const String editPaciente = '/pacientes/edit';
  static const String createMedico = '/medicos/create';
  static const String editMedico = '/medicos/edit';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final isOnSplash = state.matchedLocation == AppRoutes.splash;
      final isOnLogin = state.matchedLocation == AppRoutes.login;

      if (isOnSplash) return null;

      if (!isAuthenticated && !isOnLogin) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isOnLogin) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.pacientes,
        name: 'pacientes',
        builder: (context, state) => const PacientesPage(),
        routes: [
          GoRoute(
            path: '/create',
            name: 'create-paciente',
            builder: (context, state) => const CreateEditPersonPage(
              personType: PersonType.paciente,
              isEditing: false,
            ),
          ),
          GoRoute(
            path: '/edit',
            name: 'edit-paciente',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return CreateEditPersonPage(
                personType: PersonType.paciente,
                isEditing: true,
                person: extra?['person'],
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.medicos,
        name: 'medicos',
        builder: (context, state) => const MedicosPage(),
        routes: [
          GoRoute(
            path: '/create',
            name: 'create-medico',
            builder: (context, state) => const CreateEditPersonPage(
              personType: PersonType.medico,
              isEditing: false,
            ),
          ),
          GoRoute(
            path: '/edit',
            name: 'edit-medico',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return CreateEditPersonPage(
                personType: PersonType.medico,
                isEditing: true,
                person: extra?['person'],
              );
            },
          ),
        ],
      ),
    ],
  );
});
