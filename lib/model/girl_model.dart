class GirlModel {
  final String id;
  final String desc;
  final List images;
  final String publishedAt;
  final String url;
  final String who;
  final int page;
  const GirlModel(
      {this.id, this.desc, this.images, this.publishedAt, this.url, this.who,this.page});

  GirlModel.fromJson(Map jsonMap,int page)
      : id = jsonMap['_id'],
        desc = jsonMap['desc'],
        images = jsonMap['images'],
        publishedAt = jsonMap['publishedAt'],
        url = jsonMap['url'],
        who = jsonMap['who'],
        page=page;

}

class GirlModelItem {
  int page = -1;
  String id;
  String desc;
  List images;
  String publishedAt;
  String url;
  String who;

  GirlModelItem newGirlMode(GirlModel gank) {
    GirlModelItem gankBean = new GirlModelItem();
    gankBean.id = gank.id;
    gankBean.desc = gank.desc;
    gankBean.publishedAt = gank.publishedAt;
    gankBean.url = gank.url;
    gankBean.who = gank.who;
    return gankBean;
  }

  List<GirlModelItem> newGankList(List<GirlModel> girlList) {
    if (null == girlList || girlList.length == 0) {
      return null;
    }
    List<GirlModelItem> itemList = new List<GirlModelItem>(girlList.length);
    for (int i = 0; i < girlList.length; i++) {
      itemList.add(newGirlMode(girlList[i]));
    }
    return itemList;
  }

  List<GirlModelItem> newGankListAndIndex(
      List<GirlModel> girlList, int pageIndex) {
    if (null == girlList || girlList.length == 0) {
      return null;
    }
    List<GirlModelItem> itemList = new List<GirlModelItem>(girlList.length);
    for (int i = 0; i < girlList.length; i++) {
      GirlModelItem item = newGirlMode(girlList[i]);
      item.page = pageIndex;
      itemList.add(item);
    }
    return itemList;
  }
}
