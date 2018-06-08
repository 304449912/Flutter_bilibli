
import 'package:flutter/material.dart';
import 'package:gedu_bilibli/main.dart';

class BottomTabPageSelector extends StatelessWidget {
  const BottomTabPageSelector({
    Key key,
    this.controller,
    this.color,
    this.choices,
    this.selectedColor, this.tabIndex,
    this.listener
  }) :   super(key: key);

  final TabController controller;
  final Color color;
  final Color selectedColor;
  final int tabIndex;
  final List<Choice> choices;
  final ValueChanged<int> listener;

  ///计算颜色值
  Color getBackground(int tabIndex, TabController tabController, ColorTween selectedColorTween,ColorTween previousColorTween,){
    Color background;
    if (tabController.indexIsChanging) {
      final double t = 1.0 - _indexChangeProgress(tabController);
      if (tabController.index == tabIndex)
        background = selectedColorTween.lerp(t);
      else if (tabController.previousIndex == tabIndex)
        background = previousColorTween.lerp(t);
      else
        background = selectedColorTween.begin;
    } else {
      final double offset = tabController.offset;
      if (tabController.index == tabIndex) {
        background = selectedColorTween.lerp(1.0 - offset.abs());
      } else if (tabController.index == tabIndex - 1 && offset > 0.0) {
        background = selectedColorTween.lerp(offset);
      } else if (tabController.index == tabIndex + 1 && offset < 0.0) {
        background = selectedColorTween.lerp(-offset);
      } else {
        background = selectedColorTween.begin;
      }
    }
    return background;
  }

  @override
  Widget build(BuildContext context) {
    final Color fixColor = color ?? Colors.grey;
    final Color fixSelectedColor = selectedColor ?? Colors.green;
    final ColorTween selectedColorTween = new ColorTween(begin: fixColor, end: fixSelectedColor);
    final ColorTween previousColorTween = new ColorTween(begin: fixSelectedColor, end: fixColor);
    final TabController tabController = controller ?? DefaultTabController.of(context);
    final Animation<double> animation = new CurvedAnimation(
      parent: tabController.animation,
      curve: Curves.fastOutSlowIn,

    );
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Container(
            height: 46.0,
            child: new Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children:  new List<Widget>.generate(choices.length, (int tabIndex) {
                return  new FlatButton(
                  onPressed: (){controller.animateTo(tabIndex);listener(tabIndex);},
                  child: new Column(
                    children: [
                      new Icon(choices[tabIndex].icon,
                          color:
                          getBackground(tabIndex,controller,selectedColorTween,previousColorTween)),
                      new Text(
                        choices[tabIndex].title,
                        style: new TextStyle(
                            color:getBackground(tabIndex,controller,selectedColorTween,previousColorTween) ),
                      ),
                    ],
                  ),
                );
              }).toList(),),);
        }
    );
  }
}

double _indexChangeProgress(TabController controller) {
  final double controllerValue = controller.animation.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();
  if (!controller.indexIsChanging)
    return (currentIndex - controllerValue).abs().clamp(0.0, 1.0);

  return (controllerValue - currentIndex).abs() / (currentIndex - previousIndex).abs();
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}
