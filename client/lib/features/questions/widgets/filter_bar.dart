import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FilterBar extends ConsumerWidget {
  final List<String>options;
  final String selected;
  final void Function(String) onSelected;
  final String label;
  const FilterBar({super.key, required this.options, required this.selected, required this.onSelected, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$label: '),
          const SizedBox(width: 10),
          Expanded(
            child: Wrap(
              children: options.map((value){
                final isSelected = selected == value;
                return ChoiceChip(
                  label: Text(
                    value,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Pallete.primaryColor,
                    ),
                  )
                  , selected: isSelected,
                  selectedColor: Pallete.primaryColor,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(100)),
                  showCheckmark: false,
                  onSelected: (_){
                    onSelected(value);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


