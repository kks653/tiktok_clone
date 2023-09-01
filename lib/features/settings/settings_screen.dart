import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  {ref.read(playbackConfigProvider.notifier).setMuted(value)},
              title: const Text("Mute video"),
              subtitle: const Text(
                "Videos will be muted by default.",
              ),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) => {
                ref.read(playbackConfigProvider.notifier).setAutoplay(value)
              },
              title: const Text(
                "Autoplay",
              ),
              subtitle: const Text(
                "Videos will start playing automatically.",
              ),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: const Text(
                "Enable notifications",
              ),
              subtitle: const Text(
                "Enable notifications",
              ),
            ),
            CheckboxListTile(
              value: false,
              onChanged: (value) {},
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
