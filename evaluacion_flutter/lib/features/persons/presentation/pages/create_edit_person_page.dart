import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/person.dart';
import '../providers/persons_actions.dart';
import '../providers/persons_state_providers.dart';

class CreateEditPersonPage extends ConsumerStatefulWidget {
  const CreateEditPersonPage({
    super.key,
    required this.personType,
    required this.isEditing,
    this.person,
  });

  final PersonType personType;
  final bool isEditing;
  final Person? person;

  @override
  ConsumerState<CreateEditPersonPage> createState() =>
      _CreateEditPersonPageState();
}

class _CreateEditPersonPageState extends ConsumerState<CreateEditPersonPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _tipoDocumentoController;
  late final TextEditingController _numeroDocumentoController;
  late final TextEditingController _primerNombreController;
  late final TextEditingController _segundoNombreController;
  late final TextEditingController _primerApellidoController;
  late final TextEditingController _segundoApellidoController;
  late final TextEditingController _fechaExpedicionController;

  // Document types
  final List<String> _documentTypes = ['CC', 'CE', 'TI', 'PP'];
  String? _selectedDocumentType;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _tipoDocumentoController = TextEditingController();
    _numeroDocumentoController = TextEditingController();
    _primerNombreController = TextEditingController();
    _segundoNombreController = TextEditingController();
    _primerApellidoController = TextEditingController();
    _segundoApellidoController = TextEditingController();
    _fechaExpedicionController = TextEditingController();

    // If editing, populate fields
    if (widget.isEditing && widget.person != null) {
      final person = widget.person!;
      _selectedDocumentType = person.tipoDocumento;
      _tipoDocumentoController.text = person.tipoDocumento;
      _numeroDocumentoController.text = person.numeroDocumento;
      _primerNombreController.text = person.primerNombre;
      _segundoNombreController.text = person.segundoNombre ?? '';
      _primerApellidoController.text = person.primerApellido ?? '';
      _segundoApellidoController.text = person.segundoApellido ?? '';

      if (person.fechaExpedicionDocumento != null) {
        _selectedDate = person.fechaExpedicionDocumento;
        _fechaExpedicionController.text =
            '${_selectedDate!.day.toString().padLeft(2, '0')}/'
            '${_selectedDate!.month.toString().padLeft(2, '0')}/'
            '${_selectedDate!.year}';
      }
    }
  }

  @override
  void dispose() {
    _tipoDocumentoController.dispose();
    _numeroDocumentoController.dispose();
    _primerNombreController.dispose();
    _segundoNombreController.dispose();
    _primerApellidoController.dispose();
    _segundoApellidoController.dispose();
    _fechaExpedicionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fechaExpedicionController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final person = Person(
      tipoDocumento: _selectedDocumentType!,
      numeroDocumento: _numeroDocumentoController.text.trim(),
      primerNombre: _primerNombreController.text.trim(),
      segundoNombre: _segundoNombreController.text.trim().isEmpty
          ? null
          : _segundoNombreController.text.trim(),
      primerApellido: _primerApellidoController.text.trim().isEmpty
          ? null
          : _primerApellidoController.text.trim(),
      segundoApellido: _segundoApellidoController.text.trim().isEmpty
          ? null
          : _segundoApellidoController.text.trim(),
      fechaExpedicionDocumento: _selectedDate,
    );

    bool success = false;

    if (widget.personType == PersonType.paciente) {
      if (widget.isEditing) {
        success = await ref.read(updatePacienteActionProvider)(person);
      } else {
        success = await ref.read(createPacienteActionProvider)(person);
      }
    } else {
      if (widget.isEditing) {
        success = await ref.read(updateMedicoActionProvider)(person);
      } else {
        success = await ref.read(createMedicoActionProvider)(person);
      }
    }

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? '${widget.personType.name.capitalize()} actualizado correctamente'
                : '${widget.personType.name.capitalize()} creado correctamente',
          ),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isFormLoadingProvider);
    final error = ref.watch(formErrorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing
              ? 'Editar ${widget.personType.name.capitalize()}'
              : 'Crear ${widget.personType.name.capitalize()}',
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            if (error != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
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
                      onPressed: () =>
                          ref.read(formErrorProvider.notifier).state = null,
                      icon: const Icon(Icons.close, color: Colors.red),
                    ),
                  ],
                ),
              ),

            // Document Type
            DropdownButtonFormField<String>(
              value: _selectedDocumentType,
              decoration: const InputDecoration(
                labelText: 'Tipo de Documento *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              items: _documentTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        _selectedDocumentType = value;
                        _tipoDocumentoController.text = value ?? '';
                      });
                    },
              validator: (value) =>
                  value == null ? 'Seleccione un tipo de documento' : null,
            ),
            const SizedBox(height: 16),

            // Document Number
            TextFormField(
              controller: _numeroDocumentoController,
              decoration: const InputDecoration(
                labelText: 'Número de Documento *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el número de documento';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // First Name
            TextFormField(
              controller: _primerNombreController,
              decoration: const InputDecoration(
                labelText: 'Primer Nombre *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el primer nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Second Name
            TextFormField(
              controller: _segundoNombreController,
              decoration: const InputDecoration(
                labelText: 'Segundo Nombre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // First Last Name
            TextFormField(
              controller: _primerApellidoController,
              decoration: InputDecoration(
                labelText: widget.personType == PersonType.medico
                    ? 'Primer Apellido *'
                    : 'Primer Apellido',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.family_restroom),
              ),
              enabled: !isLoading,
              validator: widget.personType == PersonType.medico
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el primer apellido (requerido para médicos)';
                      }
                      return null;
                    }
                  : null,
            ),
            const SizedBox(height: 16),

            // Second Last Name
            TextFormField(
              controller: _segundoApellidoController,
              decoration: const InputDecoration(
                labelText: 'Segundo Apellido',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.family_restroom_outlined),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // Expedition Date
            TextFormField(
              controller: _fechaExpedicionController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Expedición',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              readOnly: true,
              enabled: !isLoading,
              onTap: _selectDate,
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.personType == PersonType.paciente
                      ? Colors.blue
                      : Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        widget.isEditing ? 'Actualizar' : 'Crear',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
