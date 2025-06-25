import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_state_providers.dart';
import '../providers/persons_actions.dart';
import '../providers/persons_state_providers.dart';

class MedicosPage extends ConsumerStatefulWidget {
  const MedicosPage({super.key});

  @override
  ConsumerState<MedicosPage> createState() => _MedicosPageState();
}

class _MedicosPageState extends ConsumerState<MedicosPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isAuthenticated = ref.read(isAuthenticatedProvider);
      if (isAuthenticated) {
        ref.read(loadMedicosActionProvider)();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final medicos = ref.watch(medicosListProvider);
    final isLoading = ref.watch(medicosLoadingProvider);
    final error = ref.watch(medicosErrorProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Médicos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: isAuthenticated && !isLoading
                ? () => ref.read(loadMedicosActionProvider)()
                : null,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: !isAuthenticated
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Debes iniciar sesión para ver los médicos',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                if (error != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.red.shade100,
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(medicosErrorProvider.notifier).state =
                                null;
                          },
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                if (isLoading) const LinearProgressIndicator(),
                Expanded(
                  child: medicos.isEmpty && !isLoading
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medical_services_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No hay médicos registrados',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: medicos.length,
                          itemBuilder: (context, index) {
                            final medico = medicos[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green.shade100,
                                  child: Text(
                                    medico.primerNombre[0].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.green.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  medico.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  '${medico.tipoDocumento}: ${medico.numeroDocumento}',
                                ),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) async {
                                    switch (value) {
                                      case 'edit':
                                        context.pushNamed(
                                          'edit-medico',
                                          extra: {'person': medico},
                                        );
                                        break;
                                      case 'delete':
                                        final confirmed =
                                            await _showDeleteDialog(
                                              context,
                                              medico.fullName,
                                            );
                                        if (confirmed == true) {
                                          ref.read(deleteMedicoActionProvider)(
                                            medico.tipoDocumento,
                                            medico.numeroDocumento,
                                          );
                                        }
                                        break;
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          SizedBox(width: 8),
                                          Text('Editar'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text(
                                            'Eliminar',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: isAuthenticated
          ? FloatingActionButton(
              onPressed: () {
                context.pushNamed('create-medico');
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context, String name) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar a $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
