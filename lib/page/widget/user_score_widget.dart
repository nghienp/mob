import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserScoreWidget extends StatefulWidget {
  const UserScoreWidget({Key? key, required this.name, required this.score}) : super(key: key);
  final String name;
  final int score;

  @override
  State<UserScoreWidget> createState() => _UserScoreWidgetState();
}

class _UserScoreWidgetState extends State<UserScoreWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {},
      key: const Key('s'),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(widget.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: 16),
              Text(widget.score.toString(), style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              SizedBox(
                height: 50,
                width: 150,
                child: TextField(
                  controller: _controller,
                  enabled: true,
                  onChanged: (v) => setState(() {}),
                  keyboardType: const TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("^-?\\d*")),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            _controller.clear();
                          },
                          child: const Icon(Icons.close, size: 20))
                      // focusColor: AppColor.gray,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
