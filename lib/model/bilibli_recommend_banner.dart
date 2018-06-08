
class RecommendBanner{
  final String title;
  final String value;
  final String image;
  final int type;
  final int weight;
  final String remark;
  final String hash;
  const RecommendBanner(
      this.type,this.title,this.value,this.hash,this.image,this.remark,this.weight
      );
  RecommendBanner.fromJson(Map jsonMap):
        title=jsonMap['title'],
        value=jsonMap['value'],
        image=jsonMap['image'],
        type=jsonMap['type'],
        weight=jsonMap['weight'],
        remark=jsonMap['remark'],
        hash=jsonMap['hash']
         ;

}