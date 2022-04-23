import 'package:flutter/material.dart';

class CommonStream<T> extends StatelessWidget {
  final Widget Function(T data) data;
  final Stream<T> stream;

  const CommonStream({Key? key, required this.data, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.data == null) {
          return const Center(child: Text('No data'));
        }
        return data(snapshot.data!);
      },
    );
  }
}
