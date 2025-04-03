import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final RxInt selectedIndex;
  final Function(int) onTap;

  const NavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: selectedIndex.value == index ? Colors.blue : Colors.transparent,
                  width: 2.0,
                ),
              ),
            ),
            child: IconButton(
              icon: Icon(icon),
              color: selectedIndex.value == index ? Colors.blue : Colors.grey,
              onPressed: () => onTap(index),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex.value == index ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
