import 'package:flutter/material.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({Key? key, required this.title, this.onTap, this.onDismissed}) : super(key: key);
  final String title;
  final void Function()? onTap;
  final DismissDirectionCallback? onDismissed;

  @override
  _ScoreCardState createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: widget.onDismissed,
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: widget.onTap,
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
