import 'package:coding_chal/constants/dimens.dart';
import 'package:coding_chal/stores/country/country_store.dart';
import 'package:coding_chal/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../constants/assets.dart';
import '../../constants/strings.dart';
import '../../widgets/progress_indicator_widget.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController _controller = TextEditingController();
  late CountryStore _countrytStore;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _countrytStore = Provider.of<CountryStore>(context);

    // check to see if already called api
    if (!_countrytStore.loading) {
      _countrytStore.getCountryList(searchKey: "Sathya");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("BuddyBet Coding Challege"),
    );
  }

  // body methods:
  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 24, horizontal: Dimens.horizontal_padding),
        child: Column(
          children: [
            TextFieldWidget(
                textController: _controller,
                errorText: '',
                icon: const IconData(0x41, fontFamily: 'Roboto'),
                onChanged: _callCountrySource),
            Expanded(
              child: Stack(
                children: <Widget>[
                  _handleErrorMessage(),
                  _buildMainContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _countrytStore.loading
            ? const CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return _countrytStore.countryList!.country != null &&
            _controller.text.isNotEmpty
        ? ListView.separated(
            itemCount: _countrytStore.countryList!.country!.length,
            separatorBuilder: (context, position) {
              return const Divider();
            },
            itemBuilder: (context, position) {
              return _buildListItem(position);
            },
          )
        : Center(child: Image.asset(Assets.noResultsFound));
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.map),
      title: Text(
        '${_countrytStore.countryList?.country?[position].countryId}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: Text(
        '${_countrytStore.countryList?.country?[position].probability}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_countrytStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_countrytStore.errorStore.errorMessage);
        }

        return const SizedBox.shrink();
      },
    );
  }

  _callCountrySource(dynamic key) {
    if (!_countrytStore.loading && _controller.text.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 1000),
          () => {_countrytStore.getCountryList(searchKey: key)});
    }
  }

  // General Methods:
  _showErrorMessage(String message) {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(Strings.noResultsFound)));
      }
    });

    return const SizedBox.shrink();
  }
}
