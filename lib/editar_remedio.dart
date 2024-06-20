import 'package:flutter/material.dart';
import 'package:pillbox/helper/database_helper.dart';
import 'package:pillbox/principal.dart';

class EditarRemedio extends StatefulWidget {
  final int compartmentNumber;

  const EditarRemedio({super.key, required this.compartmentNumber});

  @override
  // ignore: library_private_types_in_public_api
  _EditarRemedioState createState() => _EditarRemedioState();
}

class _EditarRemedioState extends State<EditarRemedio> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  List<String> _selectedDays = [];
  TimeOfDay? _selectedTime;

  final List<String> _daysOfWeek = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo'
  ];

  @override
  void initState() {
    super.initState();
    _loadExistingRemedy();
  }

  void _loadExistingRemedy() async {
    final remedy = await DatabaseHelper().getRemedyByCompartment(widget.compartmentNumber);
    if (remedy['name'] != 'N/A') {
      _nameController.text = remedy['name'];
      _selectedDays = (remedy['days'] as String).split(', ');
      final timeParts = (remedy['time'] as String).split(':');
      _selectedTime = TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
      _timeController.text = _selectedTime!.format(context);
    }
  }

  void _saveRemedy() async {
    String days = _selectedDays.join(', ');
    String time = _selectedTime!.format(context);

    Map<String, dynamic> remedy = {
      'cartNumber': widget.compartmentNumber,
      'name': _nameController.text,
      'time': time,
      'days': days,
    };

    // Verifica se o remédio já existe para decidir se deve inserir ou atualizar
    final existingRemedy = await DatabaseHelper().getRemedyByCompartment(widget.compartmentNumber);
    if (existingRemedy['name'] == 'N/A') {
      await DatabaseHelper().insertRemedy(remedy);
    } else {
      await DatabaseHelper().updateRemedy(remedy);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PagPrincipal()),
    );
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime!.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 11, 11, 11),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: const Color.fromARGB(245, 255, 249, 226),
            borderRadius: BorderRadius.circular(150),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 250,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'NOME DO REMÉDIO:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nome do remédio',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'DIAS:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          value: _selectedDays.isNotEmpty ? _selectedDays.first : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: _daysOfWeek.map((String day) {
                            return DropdownMenuItem<String>(
                              value: day,
                              child: Text(day),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (!_selectedDays.contains(newValue)) {
                                _selectedDays.add(newValue!);
                              }
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              if (!_selectedDays.contains(value)) {
                                _selectedDays.add(value!);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  children: _selectedDays.map((day) {
                    return Chip(
                      label: Text(day),
                      onDeleted: () {
                        setState(() {
                          _selectedDays.remove(day);
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'HORÁRIO:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () => _selectTime(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _timeController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '00:00',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 80,
                  ),
                  onPressed: _saveRemedy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
