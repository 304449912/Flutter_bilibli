class RecommendInfo {
  final String type;
  final HeadBean head;
  final List<BodyBean> body;
  const RecommendInfo({this.type, this.body, this.head});

  RecommendInfo.fromJson(Map jsonMap):
        type=jsonMap['type'],
        body=jsonMap['body'].map<BodyBean>((item) => BodyBean.fromJson(item)).toList(),
        head = HeadBean.fromJson(jsonMap['head']);


}

class BodyBean {
  final String title;
  final String style;
  final String cover;
  final String param;
  final String goto;
  final int width;
  final int height;
  final String play;
  final String danmaku;
  final String up;
  final String upFace;
  final int online;
  final String desc1;

  const BodyBean(
      {this.title,
      this.style,
      this.cover,
      this.param,
      this.goto,
      this.width,
      this.height,
      this.play,
      this.danmaku,
      this.up,
      this.upFace,
      this.online,
      this.desc1});


  BodyBean.fromJson(Map jsonMap):
        title=jsonMap['title'],
        style=jsonMap['style'],
        cover=jsonMap['cover'],
        param=jsonMap['param'],
        goto=jsonMap['goto'],
        width=jsonMap['width'],
        height=jsonMap['height'],
        play=jsonMap['play'],
        danmaku=jsonMap['danmaku'],
        up=jsonMap['up'],
        upFace=jsonMap['upFace'],
        online=jsonMap['online'],
        desc1 = jsonMap['desc1'];
}

class HeadBean {
  final String param;
  final String goto;
  final String style;
  final String title;
  final int count;

  const HeadBean({this.goto, this.param, this.style, this.title, this.count});

  HeadBean.fromJson(Map jsonMap):
        title=jsonMap['title'],
        style=jsonMap['style'],
        param=jsonMap['param'],
        goto=jsonMap['goto'],
        count=jsonMap['count'];
}
