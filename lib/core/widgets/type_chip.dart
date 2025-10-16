import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

enum TypeEnum { all, movie, tv }

class TypeChip extends StatelessWidget {
  TypeEnum type;
  String? label;
  bool? isSelected;
  VoidCallback onTap;
  TypeChip({
    super.key,
    this.type = TypeEnum.all,
    this.label = '',
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        margin: EdgeInsets.only(right: 8.0),
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: isSelected!
              ? AppColors.primaryBlue
              : AppColors.primaryBlue.withOpacity(0.1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            _getLabel(type),
            style: TextStyle(
              color: isSelected! ? Colors.white : AppColors.primaryBlue,
              fontWeight: isSelected! ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  String _getLabel(TypeEnum type) {
    switch (type) {
      case TypeEnum.all:
        return 'Semua';
      case TypeEnum.movie:
        return 'Film';
      case TypeEnum.tv:
        return 'Serial TV';
    }
  }
}
