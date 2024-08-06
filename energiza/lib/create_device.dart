import 'package:flutter/material.dart';
import 'package:energiza/database_helper.dart' as database_helper;
import 'package:energiza/device.dart';

class CreateDeviceScreen extends StatefulWidget {
  final Device? device;

  const CreateDeviceScreen({super.key, this.device});

  @override
  _CreateDeviceScreenState createState() => _CreateDeviceScreenState();
}

class _CreateDeviceScreenState extends State<CreateDeviceScreen> {
  final _nameController = TextEditingController();
  double _energyStatus = 50.0; // Status de energia default
  String _selectedDevice = 'lamp'; // Dispositivo default

  @override
  void initState() {
    super.initState();
    if (widget.device != null) {
      _nameController.text = widget.device!.name;
      _energyStatus = widget.device!.status;
      _selectedDevice = _getDeviceTypeFromImage(widget.device!.image);
    }
  }

  String _getDeviceTypeFromImage(String image) {
    if (image.contains('pngwing_4.png')) return 'lamp';
    if (image.contains('solar_panel.png')) return 'solar';
    if (image.contains('pngwing_5.png')) return 'led';
    return 'lamp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device == null ? 'Adicionar Dispositivo' : 'Editar Dispositivo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          if (widget.device != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
 
                if (widget.device != null) {
                  await database_helper.DatabaseHelper.instance.deleteDevice(widget.device!.id!);
                  Navigator.pop(context);
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione o Tipo de Dispositivo:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedDevice,
              items: <String>['lamp', 'led', 'solar'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.capitalize()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDevice = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Nome do Dispositivo:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite o nome do dispositivo',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Status de Energia:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _energyStatus,
              min: 0,
              max: 100,
              divisions: 100,
              label: _energyStatus.round().toString() + '%',
              activeColor: Colors.green, // Cor pro Slider na hora de criar o dispositivo
              onChanged: (double value) {
                setState(() {
                  _energyStatus = value;
                });
              },
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text;
                  if (name.isEmpty) {
                    _showErrorDialog('Por favor, insira o nome do dispositivo.');
                    return;
                  }

                  final image = _getImageFromDeviceType(_selectedDevice);
                  final status = _energyStatus;
                  final isOn = false;

                  final device = Device(
                    id: widget.device?.id,
                    name: name,
                    image: image,
                    status: status, // Passa o status como double
                    isOn: isOn,
                  );

                  if (widget.device == null) {
                    await database_helper.DatabaseHelper.instance.insertDevice(device);
                  } else {
                    await database_helper.DatabaseHelper.instance.updateDevice(device);
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                ),
                child: Text(widget.device == null ? 'Adicionar' : 'Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageFromDeviceType(String deviceType) {
    switch (deviceType) {
      case 'lamp':
        return 'assets/pngwing_4.png';
      case 'solar':
        return 'assets/solar_panel.png';
      case 'led':
        return 'assets/pngwing_5.png';
      default:
        return 'assets/pngwing_4.png';
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

extension StringCapitalization on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
