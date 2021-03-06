import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/current-list/index.dart';
import '../components/input/index.dart';
import '../components/list/index.dart';
import '../models/index.dart';
import '../pages/index.dart';
import 'index.dart';

class ListItemHome extends StatelessWidget {
  final int index;
  final ListData listData;

  const ListItemHome({
    Key key,
    this.index,
    this.listData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    var _listController = Momentum.controller<ListController>(context);
    var _currentListController = Momentum.controller<CurrentListController>(context);
    var _inputController = Momentum.controller<InputController>(context);
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
        IconData icon;
        Color color;
        var checkState = _listController.getCheckState(index);
        if (checkState == true) {
          icon = Icons.check_circle;
          color = theme.listTileIconColor.primary;
        }
        if (checkState == false) {
          icon = Icons.crop_square;
          color = theme.listTileIconColor.normal;
        }
        if (checkState == null) {
          icon = Icons.remove_circle;
          color = theme.primary;
        }
        return Card(
          margin: EdgeInsets.only(top: sy(8)),
          color: theme.listTileCardBackground,
          child: InkWell(
            onTap: () {
              _currentListController.reset(clearHistory: true);
              _listController.view(index);
              Router.goto(context, ViewList);
            },
            child: ListTile(
              contentPadding: EdgeInsets.all(sy(4)).copyWith(left: sy(8)),
              leading: Icon(
                icon,
                color: color,
                size: sy(16),
              ),
              title: BetterText(
                listData.listName,
                style: TextStyle(
                  fontSize: sy(11),
                  color: theme.listTileFontColor.primary,
                ),
                maxLines: 2,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      size: sy(18),
                      color: theme.listTileIconColor.normal,
                    ),
                    onPressed: () {
                      _inputController.reset(clearHistory: true);
                      _listController.createCopy(index);
                      Router.goto(context, AddNewList);
                    },
                    tooltip: 'Create Copy',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
