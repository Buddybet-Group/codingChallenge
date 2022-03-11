import '../../core/constants/entity_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state_layout.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({
    Key? key,
    required this.data,
    required this.child,
    required this.onRefresh,
    this.loadMore,
    this.hasMore: false,
    this.stateType: StateType.empty,
  }) : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback? loadMore;
  final data;
  final bool hasMore;
  final IndexedWidgetBuilder child;
  final StateType stateType;

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DetailedViewState extends State<DetailedView> {
  /// Whether data is being loaded
  bool _isLoading = false;
  bool _isList = false;

  @override
  Widget build(BuildContext context) {
    _isList = (widget.data is List) ? true : false;

    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: ((_isList == true)
                  ? widget.data.isEmpty
                  : widget.stateType != StateType.Success)
              ? StateLayout(type: widget.stateType)
              : widget.stateType == StateType.Success
                  ? widget.child(context, 0)
                  : _buildMoreWidget()),
    );
  }

  Future _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore!();
    _isLoading = false;
  }

  Widget _buildMoreWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
              offstage: !widget.hasMore,
              child: const CupertinoActivityIndicator()),
          Offstage(offstage: !widget.hasMore, child: Gaps.hGap(5)),

          /// When there is only one page, the FooterView is not displayed.
        ],
      ),
    );
  }
}
