class BangUmiInfo{
  final String desc;
  final int id;
  final String cover;
  final int isNew;
  final String title;
  final String link;
  final int type;
  final int wid;

  const BangUmiInfo(
      {this.desc,
        this.id,
        this.cover,
        this.isNew,
        this.title,
        this.link,
        this.type ,
        this.wid,
      });

  BangUmiInfo.fromJson(Map jsonMap):
        desc=jsonMap['desc'],
        id=jsonMap['id'],
        cover=jsonMap['cover'],
        isNew=jsonMap['is_new'],
        title=jsonMap['title'],
        link=jsonMap['link'],
        type=jsonMap['type'],
        wid=jsonMap['wid']
  ;


}