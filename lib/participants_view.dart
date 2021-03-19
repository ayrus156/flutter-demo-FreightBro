import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'group_model.dart';
import 'package:grouped_list/grouped_list.dart';

///Class that display the participant page
class ParticipantListView extends StatefulWidget {
  final GroupModel groupModel;

  ParticipantListView({Key key, this.groupModel}) : super(key: key);
  @override
  ParticipantsGroupView createState() => ParticipantsGroupView();
}

class ParticipantsGroupView extends State<ParticipantListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            elevation: 0.0,
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),

              /// Adding the title
              child: ListTile(
                title: Text(
                  widget.groupModel.participants.length.toString() +
                      ' ' +
                      'Participants',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(widget.groupModel.team,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
            )),

        /// Using grouped listView to display the  sorted participants
        body: GroupedListView<dynamic, String>(
          elements: widget.groupModel.participants,
          groupBy: (element) => element.group,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1.first_name.compareTo(item2.first_name),
          order: GroupedListOrder.DESC,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),

              ///Display the groupBy text based on alphabetical order
              child: Text(
                value,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = Colors.yellow
                    ..strokeWidth = 10
                    ..style = PaintingStyle.stroke
                    ..strokeJoin = StrokeJoin.round,
                ),
              ),
            ),
          ),

          ///Adding the participant items in ListView
          itemBuilder: (c, element) {
            ///Implementing the swipe delete feature
            return Dismissible(
                key: Key(element.id),
                onDismissed: (direction) {
                  setState(() {
                    widget.groupModel.participants
                        .removeWhere((item) => item.id == element.id);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(element.first_name + " deleted")));
                },

                ///Adding card widget for participant
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0), //or 15.0
                          child: Container(
                            height: 45.0,
                            width: 40.0,
                            child: Image(
                              image: NetworkImage(element.avatar),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                            element.first_name + ' ' + element.last_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ],
                  )),
                ));
          },
        ));
  }
}
