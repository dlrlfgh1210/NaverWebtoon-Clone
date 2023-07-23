import 'package:flutter/material.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  String selectedText = '인기순';
  List<String> pickedText = ['인기순', '여성 인기순', '남성 인기순', '조회순', '업데이트순', '별점순'];

  void changeText() {
    setState(() {
      selectedText = pickedText[0];
    });
  }

  void changeText1() {
    setState(() {
      selectedText = pickedText[1];
    });
  }

  void changeText2() {
    setState(() {
      selectedText = pickedText[2];
    });
  }

  void changeText3() {
    setState(() {
      selectedText = pickedText[3];
    });
  }

  void changeText4() {
    setState(() {
      selectedText = pickedText[4];
    });
  }

  void changeText5() {
    setState(() {
      selectedText = pickedText[5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          selectedText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            changeText();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '인기순',
                            style: TextStyle(
                              color: selectedText == pickedText[0]
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            changeText1();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '여성 인기순',
                            style: TextStyle(
                              color: selectedText == pickedText[1]
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            changeText2();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '남성 인기순',
                            style: TextStyle(
                              color: selectedText == pickedText[2]
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            changeText3();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '조회순',
                            style: TextStyle(
                              color: selectedText == pickedText[3]
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            changeText4();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '업데이트순',
                            style: TextStyle(
                              color: selectedText == pickedText[4]
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            changeText5();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '별점순',
                            style: TextStyle(
                              color: selectedText == pickedText[5]
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel_outlined,
                              color: Colors.grey, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.arrow_downward, color: Colors.black,),)
      ],
    );
  }
}
