import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        top: false,
        bottom: !compact,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 16 : 24,
            vertical: compact ? 12 : 16,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.cornerRadius),
                ),
                child: const Icon(Icons.music_note_outlined),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '尚未播放音乐',
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '从音乐库选择一首歌曲',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!compact)
                const IconButton(
                  onPressed: null,
                  tooltip: '上一首',
                  icon: Icon(Icons.skip_previous_rounded),
                ),
              const IconButton(
                onPressed: null,
                tooltip: '选择歌曲后播放',
                icon: Icon(Icons.play_arrow_rounded, size: 32),
              ),
              const IconButton(
                onPressed: null,
                tooltip: '下一首',
                icon: Icon(Icons.skip_next_rounded),
              ),
              if (!compact) ...[
                const SizedBox(width: 32),
                Text('00:00 / 00:00', style: theme.textTheme.bodySmall),
                const SizedBox(width: 32),
                const Icon(Icons.volume_up_outlined, size: 20),
                const SizedBox(width: 8),
                const SizedBox(
                  width: 100,
                  child: Slider(value: 0.7, onChanged: null),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
