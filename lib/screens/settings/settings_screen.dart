import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;
  bool cameraGuide = true;
  bool vibration = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          const Text(
            "General",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: SwitchListTile(
              value: notifications,
              title: const Text("Notifications"),
              subtitle: const Text(
                "Receive posture reminders",
              ),
              onChanged: (v) {
                setState(() {
                  notifications = v;
                });
              },
            ),
          ),

          Card(
            child: SwitchListTile(
              value: vibration,
              title: const Text("Vibration"),
              subtitle: const Text(
                "Vibrate on posture alerts",
              ),
              onChanged: (v) {
                setState(() {
                  vibration = v;
                });
              },
            ),
          ),

          Card(
            child: SwitchListTile(
              value: cameraGuide,
              title: const Text("Camera Guide"),
              subtitle: const Text(
                "Show body alignment overlay",
              ),
              onChanged: (v) {
                setState(() {
                  cameraGuide = v;
                });
              },
            ),
          ),

          Card(
            child: SwitchListTile(
              value: darkMode,
              title: const Text("Dark Mode"),
              subtitle: const Text(
                "Enable dark theme",
              ),
              onChanged: (v) {
                setState(() {
                  darkMode = v;
                });
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "About",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Card(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("Version"),
              trailing: Text("1.0.0"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Clear History"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Clear History"),
                    content: const Text(
                      "Delete all saved posture reports?"
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "History cleared",
                              ),
                            ),
                          );
                        },
                        child: const Text("Delete"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}