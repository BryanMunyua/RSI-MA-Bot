#include <Trade/Trade.mqh>

CTrade trade;

int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

  }

void OnTick()
  {

      //create a string for the signal
      string signal = "";
      
      //Create an array for the price data
      double myRSIArray[];
      
      // define the properties for the RSI
      int myRSIDefinition = iRSI(_Symbol,_Period,14,PRICE_CLOSE);
      
      //Sort the price data from the current candle downwards
      ArraySetAsSeries(myRSIArray, true);
      
      //Defined EA, from current candle, for 3 candles, save in array
      CopyBuffer(myRSIDefinition,0,0,3,myRSIArray);
      
      //Calculate the current RSI value
      double myRSIValue = NormalizeDouble(myRSIArray[0],2);
      
      int highestCandlePrice = iHighest(_Symbol,_Period,MODE_HIGH,100,0);
      
      int lowestCandlePrice = iLowest(_Symbol,_Period,MODE_LOW,100,0);
      
      double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_LAST);
      
      double myMovingAverageArray[];
      
      int movingAverageDefinition = iMA(_Symbol,_Period,200,0,MODE_SMA,PRICE_CLOSE);
      
      ArraySetAsSeries(myMovingAverageArray, true);
      
      CopyBuffer(movingAverageDefinition,0,0,3,myMovingAverageArray);
      
      
      
      
      if (myRSIValue>=70 && currentPrice < myMovingAverageArray[1]){
          
          int totalOrders = PositionsTotal();
          
          
          if(totalOrders == 0){
      
             double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
             double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
             double sl = ask + 70* SymbolInfoDouble(_Symbol,SYMBOL_POINT);
             double tp = ask - 205* SymbolInfoDouble(_Symbol,SYMBOL_POINT);
             trade.Sell(0.01,_Symbol,ask,0,tp,"Sell order placed");
             
             }
      }
   
      if (myRSIValue<=30 && currentPrice > myMovingAverageArray[1]){
         
         int totalOrders = PositionsTotal();
         
         
         if(totalOrders == 0){
            double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
            double sl = bid - 70* SymbolInfoDouble(_Symbol,SYMBOL_POINT);
            double tp = bid + 205* SymbolInfoDouble(_Symbol,SYMBOL_POINT);
            trade.Buy(0.01,_Symbol,bid,0,tp,"Buy order placed");
         }
      }
      
      
   
  }

