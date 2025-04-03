import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAvatar;
  final VoidCallback? onAvatarTap;

  const CustomAppBar({
    Key? key,
    this.showAvatar = true,
    this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: showAvatar
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: onAvatarTap ?? () => print('Avatar tapped!'),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar/profile.png'),
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
