import 'package:flutter/material.dart';
import 'package:hi_base/util/color.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_base/util/toast.dart';
import 'package:hi_base/util/hi_state.dart';

//M为dao返回的数据模型,L为列表数据模型,T为具体的widget
abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;

  ScrollController scrollController = ScrollController();

  get contentChild;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      print("滚动的距离:$dis");
      //当列表高度不满屏幕的时候，不加载更多数据
      if (dis < 300 &&
          !loading &&
          scrollController.position.maxScrollExtent != 0) {
        print('加载更多数据');
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: primary,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: contentChild,
      ),
      onRefresh: loadData,
    );
  }

  //获取对应页码的数据
  Future<M> getData(int pageIndex);

  //从MO中解析出list的数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (loading) {
      print("上次加载还没有完成");
      return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      showWarnToast(e.message);
    } on HiNETError catch (e) {
      loading = false;
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
