import 'package:Klasspadel/Page/EditVideo/PageView/editVideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class EditButtonExpand extends StatefulWidget {
  final ValueChanged<PainterController> onChanged;
  final ValueChanged<bool> onDelete;
  final ValueChanged<bool> onUndo;
  final ValueChanged<bool> onZoom;
  final ValueChanged<bool> onPreview;
  final ValueChanged<bool> onList;
  final ValueChanged<bool> onPublish;
  const EditButtonExpand(
      {Key? key,
      required this.onChanged,
      required this.onDelete,
      required this.onUndo,
      required this.onZoom,
      required this.onPreview,
      required this.onList,
      required this.onPublish})
      : super(key: key);

  static PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  @override
  State<EditButtonExpand> createState() => _EditButtonExpandState();
}

class _EditButtonExpandState extends State<EditButtonExpand>
    with SingleTickerProviderStateMixin {
  late PainterController controller = EditButtonExpand.newController();
  bool isEdit = false;
  bool isExpanded = false;
  bool isZoomActived = false;
  bool isListActived = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Asegúrate de cancelar el temporizador al eliminar el widget.
    super.dispose();
    controller.dispose();
  }

  void expandedController() {
    if (isExpanded) {
      isExpanded = false;
    } else {
      isExpanded = true;
    }

    setState(() {});
  }

  void editBtn() {
    if (isEdit) {
      isEdit = false;
    } else {
      isEdit = true;
    }
    widget.onChanged(controller);
    setState(() {});
  }

  void previewBtn() {
    widget.onPreview(true);
    setState(() {});
  }

  void showList() {
    if (isListActived) {
      isListActived = false;
    } else {
      isListActived = true;
    }
    widget.onList(true);
  }

  void publish() {
    widget.onPublish(true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(70),
            border: Border.all(color: const Color.fromRGBO(219, 177, 42, 1)),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          width: 55, // Anima el ancho
          height: isExpanded ? 450.0 : 50.0, // Anima el alto
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: isExpanded
                              ? const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                          tooltip: 'Expanded',
                          onPressed: expandedController),
                      Visibility(
                        visible: isExpanded,
                        child: Column(
                          children: [
                            DrawBar(controller, isEdit, (bool value) {
                              editBtn();
                            }),
                            IconButton(
                                icon: const Icon(
                                  Icons.undo,
                                  color: Colors.black,
                                ),
                                tooltip: 'Atras',
                                onPressed: () async {
                                  widget.onUndo(true);
                                }),
                            IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                tooltip: 'Borrar todo',
                                onPressed: () {
                                  controller.clear();
                                }),
                            IconButton(
                              icon: const Icon(
                                Icons.preview,
                                color: Colors.black,
                              ),
                              tooltip: 'Vista previa',
                              onPressed: previewBtn,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.zoom_in,
                                color: !isZoomActived
                                    ? Colors.amber
                                    : Colors.black,
                              ),
                              tooltip: 'Zoom',
                              onPressed: () {
                                if (isZoomActived) {
                                  isZoomActived = false;
                                } else {
                                  isZoomActived = true;
                                }
                                widget.onZoom(isZoomActived);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.list,
                                color:
                                    isListActived ? Colors.amber : Colors.black,
                              ),
                              tooltip: 'Lista',
                              onPressed: showList,
                            ),
                            Container(
                              height: 1,
                              child: Container(
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 9,
                              child: Container(
                                height: 1,
                                color: Colors.transparent,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.publish,
                                color: Colors.black,
                              ),
                              tooltip: 'Publicar',
                              onPressed: publish,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
