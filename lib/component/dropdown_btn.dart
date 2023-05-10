import 'package:flutter/material.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn({
    required this.items,
    required this.hint,
    this.isEnabled = true,
    this.onItemSelected,
    bool showAddButton = false,
    super.key,
  });
  final List<String> items;
  final String hint;
  final void Function(String)? onItemSelected;
  final bool isEnabled;
  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  late String label;
  @override
  void initState() {
    super.initState();
    label = widget.hint;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 48),
      enabled: widget.isEnabled,
      initialValue: label,
      itemBuilder: (BuildContext context) {
        return widget.items
            .map((e) => PopupMenuItem<String>(
                  value: e,
                  child: Text(e),
                  onTap: () => setState(
                    () {
                      label = e;
                    },
                  ),
                ))
            .toList();
      },
      onSelected: widget.onItemSelected,
      child: Opacity(
        opacity: widget.isEnabled ? 1 : 0.5,
        child: Container(
          width: 240,
          height: 42,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(label)),
                Visibility(
                  visible: widget.isEnabled,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 19,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
