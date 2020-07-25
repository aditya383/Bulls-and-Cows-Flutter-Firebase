import 'dart:math';

Random random = new Random();
class CreateRandomNum {
  int p = random.nextInt(10);
  int q = random.nextInt(10);
  int r = random.nextInt(10);
  int s = random.nextInt(10);

  List<int> randomNum(){
    while(q==p){
      q = random.nextInt(10);
    }
    while(r==q||r==p){
      r = random.nextInt(10);
    }
    while(s==r||s==q||s==p){
      s = random.nextInt(10);
    }

    List<int> randomNum = [p,q,r,s];
    return randomNum;

  }
}

class CheckNumber{
  int checkNum;
  List<int> randomNum;
  int cows=0;
  int bulls=0;
  CheckNumber(int checkNum, List<int> randomNum){
    this.checkNum = checkNum;
    this.randomNum = randomNum;
  }
  List<int> bullsAndCows(){

    int d=checkNum%10;
    int c=((checkNum%100) - d)~/10;
    int b=((checkNum%1000)-(checkNum%100))~/100;
    int a=(checkNum-(checkNum%1000))~/1000;
    if(a==b||a==c||a==d||b==c||b==d||c==d)
    {
      return null;
    }
    else if(checkNum<9999 && checkNum>123)
    {
      if(a==randomNum[0])
      {
        bulls++;
      }
      else if(a==randomNum[1]||a==randomNum[2]||a==randomNum[3])
      {
        cows++;
      }
      if(b==randomNum[1])
      {
        bulls++;
      }
      else if(b==randomNum[0]||b==randomNum[2]||b==randomNum[3])
      {
        cows++;
      }
      if(c==randomNum[2])
      {
        bulls++;
      }
      else if(c==randomNum[0]||c==randomNum[1]||c==randomNum[3])
      {
        cows++;
      }
      if(d==randomNum[3])
      {
        bulls++;
      }
      else if(d==randomNum[0]||d==randomNum[1]||d==randomNum[2])
      {
        cows++;
      }

      if(bulls==4)
      {
        if(checkNum<1000)
        {
          print('congrats you won the game and the number is 0$checkNum');
          List<int> display = [checkNum,bulls,cows];
          return display;

        }
        else
        {
          print('congrats you won the game and the number is $checkNum');
          List<int> display = [checkNum,bulls,cows];
          return display;
        }
      }
      else
      {
        if(checkNum<1000)
        {
          List<int> display = [checkNum,bulls,cows];
          return display;
        }
        else
        {
          List<int> display = [checkNum,bulls,cows];
          return display;
        }
      }
    }
    else
    {
      print("Enter a valid number");
    }

    return null;

  }

}
