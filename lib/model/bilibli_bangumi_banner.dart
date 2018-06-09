
class BangUmiRecommend{
  final List<BangUmiHead> head;
  final Previous previous;
  final List<BangUmiBean> serializing;
  BangUmiRecommend.fromJson(Map jsonMap):
        head=jsonMap['ad']['head'].map<BangUmiHead>((item) => BangUmiHead.fromJson(item)).toList(),
        previous=Previous.fromJson(jsonMap['previous']),
        serializing=jsonMap['serializing'].map<BangUmiBean>((item) => BangUmiBean.fromJson(item)).toList()
  ;
}
class Previous{

  final int season;
  final int year;
  final List<BangUmiBean> list;
  const Previous(
      {this.season,this.year,this.list
      });

  Previous.fromJson(Map jsonMap):
        season=jsonMap['season'],
        year=jsonMap['year'],
        list=jsonMap['list'].map<BangUmiBean>((item) => BangUmiBean.fromJson(item)).toList()
  ;
}

class BangUmiBean {
  final String title;
  final String badge;
  final String cover;
  final String favourites;
  final int isFinish;
  final int lastTime;
  final String newestEpIndex;
  final int pubTime;
  final int seasonId;
  final int seasonStatus;
  final int watchingCount;

  const BangUmiBean(
      {this.title,
      this.badge,
      this.cover,
      this.favourites,
      this.isFinish,
      this.lastTime,
      this.newestEpIndex,
        this.pubTime,
        this.seasonId,
        this.seasonStatus,
        this.watchingCount,
    });

  BangUmiBean.fromJson(Map jsonMap):
        title=jsonMap['title'],
        badge=jsonMap['badge'],
        cover=jsonMap['cover'],
        favourites=jsonMap['favourites'],
        isFinish=jsonMap['is_finish'],
        lastTime=jsonMap['last_time'],
        newestEpIndex=jsonMap['newest_ep_index'],
        pubTime=jsonMap['pub_time'],
        seasonId=jsonMap['season_id'],
        seasonStatus=jsonMap['season_status'],
        watchingCount=jsonMap['watching_count']
       ;
}

class BangUmiHead {
  final String img;
  final String link;
  final String pub_time;
  final String title;

  const BangUmiHead({this.link, this.img, this.pub_time, this.title});

  BangUmiHead.fromJson(Map jsonMap):
        title=jsonMap['title'],
        pub_time=jsonMap['pub_time'],
        img=jsonMap['img'],
        link=jsonMap['link'] ;
}
