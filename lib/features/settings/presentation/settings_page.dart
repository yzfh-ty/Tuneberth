import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle('音乐来源'),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.cloud_outlined),
                title: Text('115 网盘'),
                subtitle: Text('尚未连接账号'),
                trailing: OutlinedButton(onPressed: null, child: Text('连接账号')),
              ),
              const SizedBox(height: 8),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.folder_outlined),
                title: Text('本地文件夹'),
                subtitle: Text('尚未添加音乐文件夹'),
                trailing: OutlinedButton(onPressed: null, child: Text('添加文件夹')),
              ),
              const SizedBox(height: 32),
              _SectionTitle('外观'),
              const SizedBox(height: 16),
              SizedBox(
                width: 360,
                child: DropdownButtonFormField<ThemeMode>(
                  key: ValueKey('theme-mode-${themeMode.name}'),
                  initialValue: themeMode,
                  decoration: const InputDecoration(labelText: '界面主题'),
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('跟随系统'),
                    ),
                    DropdownMenuItem(value: ThemeMode.light, child: Text('浅色')),
                    DropdownMenuItem(value: ThemeMode.dark, child: Text('深色')),
                  ],
                  onChanged: (mode) {
                    if (mode != null) onThemeModeChanged(mode);
                  },
                ),
              ),
              const SizedBox(height: 32),
              _SectionTitle('关于'),
              const SizedBox(height: 16),
              Text('听泊 · Tuneberth', style: theme.textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(
                '让网盘音乐与本地收藏相聚。',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
