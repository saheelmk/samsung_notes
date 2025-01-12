import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/widgets/color_palate.dart';
import 'package:samsung_note/widgets/dropdownwidget.dart';

class CreateNotes extends HookWidget {
  final Color backgroundColor;
  final Color appbarThings;
  final Function(String, String, TextStyle) onAddNote;

  CreateNotes({
    super.key,
    required this.backgroundColor,
    required this.appbarThings,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final bodyController = useTextEditingController();
    final undoStack = useState<List<Map<String, dynamic>>>([]);
    final redoStack = useState<List<Map<String, dynamic>>>([]);
    final showTextOptions = useState(false);
    final showFontColorPicker = useState(false);
    final showFontBgColorPicker = useState(false);
    final currentTextStyle = useState(const TextStyle(fontSize: 20));
    final textAlign = useState(TextAlign.left);
    final currentFontColor = useState(Colors.black);

    void _saveStateToUndoStack() {
      undoStack.value = [
        ...undoStack.value,
        {
          'title': titleController.text,
          'body': bodyController.text,
          'textStyle': currentTextStyle.value,
          'textAlign': textAlign.value,
        }
      ];
      redoStack.value = [];
    }

    void _restoreState(Map<String, dynamic> state) {
      titleController.text = state['title'];
      bodyController.text = state['body'];
      currentTextStyle.value = state['textStyle'];
      textAlign.value = state['textAlign'];
    }

    void _undo() {
      if (undoStack.value.isNotEmpty) {
        redoStack.value = [
          ...redoStack.value,
          {
            'title': titleController.text,
            'body': bodyController.text,
            'textStyle': currentTextStyle.value,
            'textAlign': textAlign.value,
          }
        ];
        final previousState = undoStack.value.last;
        undoStack.value =
            undoStack.value.sublist(0, undoStack.value.length - 1);
        _restoreState(previousState);
      }
    }

    void _redo() {
      if (redoStack.value.isNotEmpty) {
        undoStack.value = [
          ...undoStack.value,
          {
            'title': titleController.text,
            'body': bodyController.text,
            'textStyle': currentTextStyle.value,
            'textAlign': textAlign.value,
          }
        ];
        final nextState = redoStack.value.last;
        redoStack.value =
            redoStack.value.sublist(0, redoStack.value.length - 1);
        _restoreState(nextState);
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 18, color: appbarThings),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onAddNote(
                titleController.text,
                bodyController.text,
                currentTextStyle.value,
              );
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appbarThings,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_book_outlined, size: 18),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, size: 18),
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: double.infinity,
              color: backgroundColor,
              child: TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                style: currentTextStyle.value,
                textAlign: textAlign.value,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          if (showTextOptions.value)
            _buildTextOptions(
                context, currentTextStyle, textAlign, showTextOptions),
          if (showFontColorPicker.value)
            _buildFontColorPicker(context, currentFontColor, currentTextStyle,
                showFontColorPicker),
          if (showFontBgColorPicker.value)
            _buildFontBgColorPicker(context, currentFontColor, currentTextStyle,
                showFontBgColorPicker),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(
        context,
        showTextOptions,
        showFontColorPicker,
        showFontBgColorPicker,
        currentTextStyle,
        textAlign,
        undoStack,
        redoStack,
        _saveStateToUndoStack,
        _undo,
        _redo,
      ),
    );
  }

  Widget _buildTextOptions(
      BuildContext context,
      ValueNotifier<TextStyle> currentTextStyle,
      ValueNotifier<TextAlign> textAlign,
      ValueNotifier<bool> showTextOptions) {
    return Positioned(
      bottom: 5,
      left: 20,
      right: 20,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[350]!, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Text options",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => showTextOptions.value = false,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption(Icons.format_align_left, () {
                  textAlign.value = TextAlign.left;
                }),
                _buildOption(Icons.format_align_center, () {
                  textAlign.value = TextAlign.center;
                }),
                _buildOption(Icons.format_align_right, () {
                  textAlign.value = TextAlign.right;
                }),
                _buildOption(Icons.format_bold, () {
                  currentTextStyle.value = currentTextStyle.value.copyWith(
                    fontWeight:
                        currentTextStyle.value.fontWeight == FontWeight.bold
                            ? FontWeight.normal
                            : FontWeight.bold,
                  );
                }),
                _buildOption(Icons.format_italic, () {
                  currentTextStyle.value = currentTextStyle.value.copyWith(
                    fontStyle:
                        currentTextStyle.value.fontStyle == FontStyle.italic
                            ? FontStyle.normal
                            : FontStyle.italic,
                  );
                }),
                _buildOption(Icons.format_underline, () {
                  currentTextStyle.value = currentTextStyle.value.copyWith(
                    decoration: currentTextStyle.value.decoration ==
                            TextDecoration.underline
                        ? TextDecoration.none
                        : TextDecoration.underline,
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontColorPicker(
      BuildContext context,
      ValueNotifier<Color> currentFontColor,
      ValueNotifier<TextStyle> currentTextStyle,
      ValueNotifier<bool> showFontColorPicker) {
    return Positioned(
      bottom: 5,
      left: 20,
      right: 20,
      child: FontColorSelector(
        onColorSelected: (color) {
          currentFontColor.value = color;
          currentTextStyle.value =
              currentTextStyle.value.copyWith(color: color);
        },
        showFonColorpalte: showFontColorPicker.value,
        onclose: () {
          showFontColorPicker.value = false;
        },
      ),
    );
  }

  Widget _buildFontBgColorPicker(
      BuildContext context,
      ValueNotifier<Color> currentFontColor,
      ValueNotifier<TextStyle> currentTextStyle,
      ValueNotifier<bool> showFontBgColorPicker) {
    return Positioned(
      bottom: 5,
      left: 20,
      right: 20,
      child: FontColorSelector(
        onColorSelected: (color) {
          currentFontColor.value = color;
          currentTextStyle.value =
              currentTextStyle.value.copyWith(backgroundColor: color);
        },
        showFonColorpalte: showFontBgColorPicker.value,
        onclose: () {
          showFontBgColorPicker.value = false;
        },
      ),
    );
  }

  Widget _buildBottomAppBar(
    BuildContext context,
    ValueNotifier<bool> showTextOptions,
    ValueNotifier<bool> showFontColorPicker,
    ValueNotifier<bool> showFontBgColorPicker,
    ValueNotifier<TextStyle> currentTextStyle,
    ValueNotifier<TextAlign> textAlign,
    ValueNotifier<List<Map<String, dynamic>>> undoStack,
    ValueNotifier<List<Map<String, dynamic>>> redoStack,
    VoidCallback saveState,
    VoidCallback undo,
    VoidCallback redo,
  ) {
    return BottomAppBar(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_box_outlined,
                size: 18,
              )),
          IconButton(
            icon: const Icon(
              Icons.text_fields,
              size: 18,
            ),
            onPressed: () => showTextOptions.value = !showTextOptions.value,
          ),
          IconButton(
            icon: const Icon(Icons.format_color_text, size: 18),
            onPressed: () =>
                showFontColorPicker.value = !showFontColorPicker.value,
          ),
          IconButton(
            icon: const Icon(
              Icons.format_color_fill,
              size: 18,
            ),
            onPressed: () =>
                showFontBgColorPicker.value = !showFontBgColorPicker.value,
          ),
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, size: 18, color: appbarThings),
            items: SizeDropdownItems.getItems(),
            onChanged: (value) {
              if (value != null) {
                currentTextStyle.value =
                    currentTextStyle.value.copyWith(fontSize: value.toDouble());
              }
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.undo,
              size: 18,
            ),
            onPressed: undo,
          ),
          IconButton(
            icon: const Icon(
              Icons.redo,
              size: 18,
            ),
            onPressed: redo,
          ),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
