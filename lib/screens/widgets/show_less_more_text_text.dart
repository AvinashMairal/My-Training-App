import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/app_constants.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  const DescriptionTextWidget({super.key, required this.text});

  @override
  State<DescriptionTextWidget> createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  int textLength = 200;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textLength) {
      firstHalf = widget.text.substring(0, textLength);
      secondHalf = widget.text.substring(textLength, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    print("calling more text build");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: RichText(
        text: TextSpan(
            text: '$firstHalf...',
            style: StyleUtils.normalTextStyle(),
            children: [
              TextSpan(
                text: "show more",
                style: StyleUtils.normalTextStyle(color: Colors.red),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _modalBottomSheetMenu();
                  },
              ),
            ]),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        // isDismissible: false,
        // enableDrag: false,
        context: context,
        isScrollControlled: true,
        //showDragHandle: true,
        clipBehavior: Clip.hardEdge,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Description",
                          style: StyleUtils.titleTextStyle(),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    )),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                          text: '$firstHalf $secondHalf ',
                          style: StyleUtils.normalTextStyle(),
                          children: [
                            TextSpan(
                              text: "show less",
                              style:
                                  StyleUtils.normalTextStyle(color: Colors.red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pop();
                                },
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
