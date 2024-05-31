import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glyph/components/pressable.dart';
import 'package:glyph/components/svg_icon.dart';
import 'package:glyph/themes/colors.dart';

class Heading extends StatelessWidget implements PreferredSizeWidget {
  const Heading({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor = BrandColors.gray_0,
    this.fallbackSystemUiOverlayStyle,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? fallbackSystemUiOverlayStyle;

  static const _preferredSize = Size.fromHeight(54);

  @override
  Widget build(BuildContext context) {
    final backgroundColorLuminance = backgroundColor?.computeLuminance();
    final baseSystemUiOverlayStyle = backgroundColorLuminance != null
        ? backgroundColorLuminance > 0.179
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light
        : fallbackSystemUiOverlayStyle ?? SystemUiOverlayStyle.dark;

    return AnnotatedRegion(
      value: baseSystemUiOverlayStyle.copyWith(
        statusBarColor: backgroundColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: SafeArea(
          child: Container(
            constraints: BoxConstraints.tight(_preferredSize),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NavigationToolbar(
              leading: leading ??
                  AutoLeadingButton(
                    builder: (context, leadingType, action) {
                      if (leadingType == LeadingType.noLeading) {
                        return const SizedBox.shrink();
                      }

                      return Pressable(
                        child: SvgIcon(
                          switch (leadingType) {
                            LeadingType.back => 'chevron-left',
                            LeadingType.close => 'x',
                            _ => throw UnimplementedError(),
                          },
                          color: BrandColors.gray_600,
                          size: 24,
                        ),
                        onPressed: () => action?.call(),
                      );
                    },
                  ),
              middle: title,
              trailing: actions == null
                  ? null
                  : Row(mainAxisSize: MainAxisSize.min, children: actions!),
            ),
          ),
        ),
      ),
    );
  }

  @override
  final preferredSize = _preferredSize;

  static PreferredSizeWidget animated({
    required AnimationController animation,
    required Heading Function(BuildContext context) builder,
  }) {
    return PreferredSize(
      preferredSize: _preferredSize,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => builder(context),
      ),
    );
  }
}