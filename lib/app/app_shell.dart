import 'package:flutter/material.dart';

import '../features/playback/presentation/player_bar.dart';
import '../features/settings/presentation/settings_page.dart';
import '../shared/widgets/empty_state.dart';
import 'app_theme.dart';

enum AppSection {
  library('音乐库', Icons.library_music_outlined),
  favorites('收藏', Icons.favorite_border),
  playlists('歌单', Icons.queue_music_outlined),
  settings('设置', Icons.settings_outlined);

  const AppSection(this.label, this.icon);

  final String label;
  final IconData icon;
}

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppSection _section = AppSection.library;

  void _navigate(AppSection section) => setState(() => _section = section);

  void _toggleTheme() {
    final dark = Theme.of(context).brightness == Brightness.dark;
    widget.onThemeModeChanged(dark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppTheme.compactBreakpoint;

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Row(
              children: [
                if (!compact)
                  _Sidebar(
                    selected: _section,
                    onNavigate: _navigate,
                    onToggleTheme: _toggleTheme,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _Header(
                        section: _section,
                        compact: compact,
                        onToggleTheme: _toggleTheme,
                        onSources: () => _navigate(AppSection.settings),
                      ),
                      Expanded(child: _content()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PlayerBar(compact: compact),
              if (compact)
                NavigationBar(
                  selectedIndex: _section.index,
                  onDestinationSelected: (index) {
                    _navigate(AppSection.values[index]);
                  },
                  destinations: [
                    for (final section in AppSection.values)
                      NavigationDestination(
                        key: ValueKey('navigation-${section.name}'),
                        icon: Icon(section.icon),
                        label: section.label,
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _content() {
    return switch (_section) {
      AppSection.library => EmptyState(
        icon: Icons.library_music_outlined,
        title: '你的音乐库还没有歌曲',
        message: '连接 115 账号或添加本地音乐文件夹。',
        actionLabel: '管理音乐来源',
        onAction: () => _navigate(AppSection.settings),
      ),
      AppSection.favorites => EmptyState(
        icon: Icons.favorite_border,
        title: '还没有收藏的歌曲',
        message: '收藏喜欢的音乐，它们会出现在这里。',
        actionLabel: '查看音乐库',
        onAction: () => _navigate(AppSection.library),
      ),
      AppSection.playlists => EmptyState(
        icon: Icons.queue_music_outlined,
        title: '你的歌单会出现在这里',
        message: '用歌单整理不同场景下想听的音乐。',
        actionLabel: '查看音乐库',
        onAction: () => _navigate(AppSection.library),
      ),
      AppSection.settings => SettingsPage(
        themeMode: widget.themeMode,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
    };
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.section,
    required this.compact,
    required this.onToggleTheme,
    required this.onSources,
  });

  final AppSection section;
  final bool compact;
  final VoidCallback onToggleTheme;
  final VoidCallback onSources;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? 20 : 32,
        20,
        compact ? 12 : 32,
        16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              section.label,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (section == AppSection.library)
            TextButton.icon(
              key: const ValueKey('manage-sources'),
              onPressed: onSources,
              icon: const Icon(Icons.add, size: 20),
              label: const Text('音乐来源'),
            ),
          if (compact)
            IconButton(
              key: const ValueKey('theme-toggle'),
              onPressed: onToggleTheme,
              tooltip: '切换深浅主题',
              icon: const Icon(Icons.brightness_6_outlined),
            ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.selected,
    required this.onNavigate,
    required this.onToggleTheme,
  });

  final AppSection selected;
  final ValueChanged<AppSection> onNavigate;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.surface,
      child: SizedBox(
        width: 212,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/app_icon.png',
                    width: 36,
                    height: 36,
                    excludeFromSemantics: true,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '听泊 · Tuneberth',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12),
                child: Text(
                  '我的音乐',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              for (final section in AppSection.values)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Material(
                    color: selected == section
                        ? theme.colorScheme.surfaceContainerHighest
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppTheme.cornerRadius),
                    child: InkWell(
                      key: ValueKey('navigation-${section.name}'),
                      onTap: () => onNavigate(section),
                      borderRadius: BorderRadius.circular(
                        AppTheme.cornerRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(section.icon, size: 22),
                            const SizedBox(width: 12),
                            Text(section.label),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '未连接 115',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  IconButton(
                    key: const ValueKey('theme-toggle'),
                    onPressed: onToggleTheme,
                    tooltip: '切换深浅主题',
                    icon: const Icon(Icons.brightness_6_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
