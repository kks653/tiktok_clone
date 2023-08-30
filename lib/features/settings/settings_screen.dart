import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/video_config/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;

    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            AnimatedBuilder(
              animation: videoConfig,
              builder: (context, child) => SwitchListTile.adaptive(
                value: videoConfig.autoMute,
                onChanged: (value) {
                  videoConfig.toggleAutoMute();
                },
                title: const Text(
                  "Auto mute",
                ),
                subtitle: const Text(
                  "Videos will be muted by default.",
                ),
              ),
            ),
            SwitchListTile.adaptive(
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text(
                "Enable notifications",
              ),
              subtitle: const Text(
                "Enable notifications",
              ),
            ),
            CheckboxListTile(
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text("Enable notifications"),
              activeColor: Colors.black,
            ),
            ListTile(
              title: const Text(
                "Log out(iOS)",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Please don't goooo"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Log out(Android)",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(
                      FontAwesomeIcons.skull,
                    ),
                    title: const Text("Please don't goooo"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(
                          FontAwesomeIcons.car,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Log out(iOS/Bottom)",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDefaultAction: true,
                        child: const Text("No"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(
              applicationName: "TikTok Clone Practice",
              applicationVersion: "version 1.0.0",
            ),
          ],
        ));
  }
}
