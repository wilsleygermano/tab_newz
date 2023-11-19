import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tab_newz/constants/app_assets.dart';
import 'package:tab_newz/theme/app_colors.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.asset,
    required this.label,
    required this.color,
    this.height,
    this.width,
  });

  final String asset;
  final String label;
  final Color? color;
  final double? height;
  final double? width;

  const IconBadge.coin({
    super.key,
    this.asset = AppAssets.coins,
    required this.label,
    this.color,
    this.height = 15,
    this.width = 15,
  });

  const IconBadge.user({
    super.key,
    this.asset = AppAssets.user,
    required this.label,
    this.color,
    this.height,
    this.width,
  });

  const IconBadge.comments({
    super.key,
    this.asset = AppAssets.comments,
    required this.label,
    this.color,
    this.height,
    this.width,
  });

  const IconBadge.clock({
    super.key,
    this.asset = AppAssets.clock,
    required this.label,
    this.color,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          asset,
          fit: BoxFit.contain,
          height: height ?? 12,
          width: width ?? 12,
          colorFilter: ColorFilter.mode(
              color ?? Theme.of(context).colorScheme.onBackground,
              BlendMode.srcIn),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
