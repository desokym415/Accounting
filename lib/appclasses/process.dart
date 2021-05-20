class Process{
  int processid;
  String fromOne, toAnother, date,description;
  int money;
  Process({this.processid,this.fromOne, this.toAnother, this.money,this.date, this.description});


  Map<String, dynamic> toMap() {
    return {
      'processid': processid,
      'fromone': fromOne,
      'toanother': toAnother,
      'money': money,
      'date': date,
      'description': description,
    };
  }
  Process.fromMap(Map<String , dynamic> map){
    this.processid = map['processid'] ;
    this.fromOne = map['fromone'] ;
    this.toAnother = map['toanother']  ;
    this.money  = map['money']   ;
    this.date = map['date'];
    this.description = map['description'] ;
  }
  @override
  String toString() {
    return 'Process{processid: $processid, fromone: $fromOne, toanother: $toAnother, money: $money,date: $date description: $description}';
  }
}