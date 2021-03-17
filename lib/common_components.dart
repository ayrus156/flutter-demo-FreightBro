import 'package:flutter/material.dart';

import 'cell.dart';
import 'group_model.dart';

class CommonComp{
  static Container homeGrid(
      AsyncSnapshot<List<GroupModel>> snapshot, Function gridClicked) {
    return Container(
      color: Colors.white70,
      child: GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 15.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Cell(snapshot.data[index]),
            onTap: () => gridClicked(context, snapshot.data[index]),
          );
        },
      ),
    );
  }
}