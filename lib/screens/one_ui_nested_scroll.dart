import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/widgets/models/note_card.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

class OneUiNested extends HookWidget {
  final Widget iconButton1;
  final Widget iconButton2;
  final Widget iconButton3;
  final Widget menuButton;
  final double expandedHeight;
  final double toolbarHeight;
  final Widget collapsedWidget;
  final Widget expandedWidget;
  final String bodyText;
  final Widget subBodyText;
  final Color backgroundColor;
  // final VoidCallback onMenuPressed;
  final VoidCallback onLongPressed;
  final List<NoteModel> notes; // Accepting notes list as parameter
  final Function(int) onNoteDeleted; // Accepting onNoteDeleted callback
  final Function(int, String, String, TextStyle) onUpdateNotes;
  final Function(NoteModel)? onTap;
  // Accepting onNoteDeleted callback

  OneUiNested(this.iconButton1, this.iconButton2,
      {super.key,
      required this.onUpdateNotes,
      required this.menuButton,
      required this.onLongPressed,
      required this.expandedHeight,
      required this.toolbarHeight,
      required this.expandedWidget,
      required this.collapsedWidget,
      required this.backgroundColor,
      // required this.onMenuPressed,
      required this.bodyText,
      required this.subBodyText,
      required this.notes, // Passing notes list
      required this.onNoteDeleted, // Passing onNoteDeleted callback
      required this.iconButton3,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final fadeInOpacity = useState(1.0); // Opacity for the expanded widget
    final fadeOutOpacity = useState(0.0); // Opacity for the collapsed widget
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.offset > 50) {
          fadeInOpacity.value = 0.0;
          fadeOutOpacity.value = 1.0;
        } else {
          fadeInOpacity.value = 1.0;
          fadeOutOpacity.value = 0.0;
        }
      });
      return () {};
    }, [scrollController]);

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: expandedHeight,
              pinned: true,
              toolbarHeight: toolbarHeight,
              backgroundColor: backgroundColor,
              automaticallyImplyLeading: false,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: fadeInOpacity.value,
                        duration: const Duration(seconds: 1),
                        child: Center(child: expandedWidget),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: notes.isEmpty
                            ? Row(
                                children: [
                                  menuButton,
                                  Expanded(
                                    child: AnimatedOpacity(
                                      opacity: fadeOutOpacity.value,
                                      duration: const Duration(seconds: 1),
                                      child: collapsedWidget,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.picture_as_pdf_outlined),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  menuButton,
                                  Expanded(
                                    child: AnimatedOpacity(
                                      opacity: fadeOutOpacity.value,
                                      duration: const Duration(seconds: 1),
                                      child: collapsedWidget,
                                    ),
                                  ),
                                  iconButton1,
                                  iconButton2,
                                  iconButton3,
                                ],
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: backgroundColor,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: notes.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 400),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bodyText,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[850]),
                                  ),
                                  const SizedBox(height: 10),
                                  subBodyText,
                                ],
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          itemCount: notes.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            return NoteCardWidget(
                              onTap: onTap,
                              onUpdateNote: onUpdateNotes,
                              note: notes[index],
                              index: index,
                              // onNoteDeleted: onNoteDeleted,
                              isIconVisible: () {
                                onLongPressed();
                              },
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
