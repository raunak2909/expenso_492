void main(){

  int no1 = 5;
  String no2 = "5";
  int no3 = 7;


  if(no1.runtimeType == no2.runtimeType){
    print("Same");
  } else {
    print("${no1.runtimeType} and ${no2.runtimeType}");
    print("not same");
  }
}