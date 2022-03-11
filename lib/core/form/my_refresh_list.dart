import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/constants/entity_factory.dart';
import 'state_layout.dart';

class DeerListView extends StatefulWidget {
  const DeerListView(
      {Key? key,
      required this.data,
      required this.itemBuilder,
      required this.onRefresh,
      this.loadMore,
      this.scrollController,
      this.physics,
      this.hasMore: false,
      this.noMore: true,
      this.stateType: StateType.empty,
      this.pageSize: 1})
      : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback? loadMore;
  final List data;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final bool hasMore;
  final bool noMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;

  /// The number of one page, the default is 10
  final int pageSize;

  @override
  _DeerListViewState createState() => _DeerListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DeerListViewState extends State<DeerListView> {
  /// Whether data is being loaded
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: widget.data.isEmpty
              ? StateLayout(type: widget.stateType)
              : ListView.builder(
                  itemCount: widget.data.length + 1,
                  controller: widget.scrollController,
                  physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return index < widget.data.length
                        ? widget.itemBuilder(context, index)
                        : (widget.noMore)
                            ? _buildMoreWidget()
                            : Gaps.empty;
                  })),
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
          Text(
              widget.hasMore
                  ? 'Loading...'
                  : (widget.data.length < widget.pageSize ? '' : ''),
              style: AppStyles.customFontCalibri(context)),
        ],
      ),
    );
  }
}
