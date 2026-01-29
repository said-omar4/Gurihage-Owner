// lib/shared/widgets/custom_appbar.dart

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/theme/app_theme.dart';

// AppBar for screens with back navigation
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? titleColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
    this.backgroundColor,
    this.titleColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: Icon(
                Iconsax.arrow_left_2,
                size: 24,
                color: titleColor ?? theme.appBarTheme.foregroundColor,
              ),
              splashRadius: 20,
            )
          : null,
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: titleColor ?? theme.appBarTheme.foregroundColor,
          fontSize: 18,
        ),
      ),
      actions: actions,
      automaticallyImplyLeading: false,
    );
  }
}

// Alternative: Container-based AppBar (more customization)
class CustomHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? trailing;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomHeader({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.trailing,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerTheme.color ?? Colors.transparent,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: Icon(
                Iconsax.arrow_left_2,
                size: 24,
                color: textColor ?? theme.appBarTheme.foregroundColor,
              ),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor ?? theme.appBarTheme.foregroundColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          if (trailing != null)
            trailing!
          else if (showBackButton)
            const SizedBox(width: 48), // For centering when there's back button
        ],
      ),
    );
  }
}

// Usage Examples:
/*
// Example 1: Basic usage
Scaffold(
  appBar: CustomAppBar(
    title: 'Privacy Policy',
    showBackButton: true,
  ),
  body: PrivacyPolicyScreen(),
)

// Example 2: With actions
Scaffold(
  appBar: CustomAppBar(
    title: 'Settings',
    showBackButton: true,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Iconsax.search_normal),
      ),
    ],
  ),
  body: SettingsScreen(),
)

// Example 3: Container-based header
Scaffold(
  body: Column(
    children: [
      CustomHeader(
        title: 'Contact Us',
        showBackButton: true,
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.more),
        ),
      ),
      Expanded(
        child: ContactUsScreen(),
      ),
    ],
  ),
)
*/
