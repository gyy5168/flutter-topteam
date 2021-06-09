pagination(pageIndex, pageSize, { sort, sortby }) {
  Map<String, dynamic> paging = {};
  paging['limit'] = pageSize;
  paging['offset'] = (pageIndex - 1) * pageSize;
  if (sort != null) {
    paging['orderby'] = sort;
  }
  if (sortby != null) {
    paging['direction'] = sortby;
  }
  return paging;
}
dateFormat(date, format) {
  var datetime = DateTime.parse(date);
  var month = datetime.month;
  var day = datetime.day;
  var hour = datetime.hour;
  var minute = datetime.minute;
  var second = datetime.second;
  var dateStr = format.replaceAll('yyyy', datetime.year.toString())
    .replaceAll('MM', month < 10 ? '0' + month.toString() : month.toString())
    .replaceAll('dd', day < 10 ? '0' + day.toString() : day.toString())
    .replaceAll('HH', hour < 10 ? '0' + hour.toString() : hour.toString())
    .replaceAll('mm', minute < 10 ? '0' + minute.toString() : minute.toString())
    .replaceAll('ss', second < 10 ? '0' + second.toString() : second.toString());
  dateStr = dateStr
    .replaceAll('M', datetime.month.toString())
    .replaceAll('d', datetime.day.toString())
    .replaceAll('H', datetime.hour.toString())
    .replaceAll('m', datetime.minute.toString())
    .replaceAll('s', datetime.second.toString());
  return dateStr;
}
class DataList {
  List list = [];
  int pageIndex;
  int pageSize;
  int pages = 1;
  int count;
  bool loading;
  get paging {
    return {
      'limit': this.pageSize,
      'offset': this.pageIndex > 0 ? (this.pageIndex - 1) * this.pageSize : 0
    };
  }

  
  DataList({this.pageSize = 20, this.pageIndex = 0, this.loading = false});
}
progressFormat (progress) {
  if (progress < 0) {
    progress = 0;
  }
  if (progress > 100) {
    progress = 100;
  }

  if (progress > 0 && progress < 1) {
    progress = 1;
  } else if (progress > 99 && progress < 100) {
    progress = 99;
  } else {
    progress = progress.round();
  }
  return progress;
}