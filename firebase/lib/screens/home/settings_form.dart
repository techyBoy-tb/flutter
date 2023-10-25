import 'package:firebase/models/CustomUser.dart';
import 'package:firebase/services/databaseService.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          nameController.text =
              _currentName ?? userData?.name ?? 'New coffee user';

          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Update your preferences here.',
                    style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                // TextFormField(
                //   initialValue: _currentName ?? userData?.name,
                //   decoration: textInputDecoration,
                //   validator: (val) =>
                //       val!.isEmpty ? 'Please enter a name' : null,
                //   onChanged: (val) => setState(() => _currentName = val),
                // ),
                MaterialTextField(
                  hint: 'Name',
                  controller: nameController,
                  onChanged: (newVal) => setState(() => _currentName = newVal),
                  prefixIcon: const Icon(Icons.person),
                  validator: (currentVal) =>
                      currentVal!.isEmpty ? 'Name cannot be empty' : null,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((s) {
                      return DropdownMenuItem(
                          value: s, child: Text('$s sugar'));
                    }).toList(),
                    onChanged: (newVal) {
                      _currentSugars = newVal;
                    }),
                const SizedBox(height: 20),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value:
                      (_currentStrength ?? userData?.strength ?? 0).toDouble(),
                  activeColor: Colors
                      .brown[_currentStrength ?? userData?.strength ?? 100],
                  inactiveColor: Colors.brown[100],
                  onChanged: (newVal) =>
                      setState(() => _currentStrength = newVal.round()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.brown)),
                  child: const Text('Update',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          (_currentSugars ?? userData?.sugars) ?? '0',
                          nameController.text,
                          (_currentStrength ?? userData?.strength) ?? 100);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          );
        }
        return const Loading();
      },
    );
  }
}
