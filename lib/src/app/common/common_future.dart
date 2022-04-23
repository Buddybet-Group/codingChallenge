import 'package:flutter/material.dart';

class CommonFuture<T> extends StatelessWidget {
  final Widget Function(T data) data;
  final Future<T> future;

  const CommonFuture(
      {Key? key,
      required this.future,
      // this.initialData,
      required this.data})
      : super(key: key);
  // final T initialData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      // initialData: initialData,
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data == null) {
            return const Center(child: Text('No data'));
          }
          return data(snapshot.data!);
        } else {
          return Center(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  )));
        }
      },
    );
  }
}
