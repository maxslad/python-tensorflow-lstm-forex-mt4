//+------------------------------------------------------------------+
//|                                                  Test_IS_DST.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict





extern double lot_default = 0.01;
extern double sl_distance = 900;
extern double tp_distance = 900;
extern double tp_distance_update = 100;


datetime timeToClose = 60*60*24*5;


int old_day_candle = 0;


string comment = "";




//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   Print(" ------------------------- Init GOOOOO !");
   
   old_day_candle = iBars(Symbol(), PERIOD_D1);
   //old_day_candle = iBars(Symbol(), PERIOD_CURRENT);
   
   /*
   int f = FileOpen("pipe_send.txt", FILE_READ | FILE_WRITE | FILE_TXT, '\n');
   string data = FileReadString(f);
   Print(data);
   FileClose(f);
   */
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
   
   comment = "";
   comment += "\n                              Time " + TimeCurrent();
   
   datetime tc = TimeCurrent() + timeToClose;
   comment += "\n                              TC " + tc;
   int day_candle = iBars(Symbol(), PERIOD_D1);
   //int day_candle = iBars(Symbol(), PERIOD_CURRENT);
   
   
   comment += "\n                              old_day_candle " + old_day_candle;
   comment += "\n                              day_candle " + day_candle;
   comment += "\n                              SPREAD " + MarketInfo(Symbol(), MODE_SPREAD);
   
   /*
   Print("========================== old_day_candle " + old_day_candle);
   Print("========================== day_candle " + day_candle);
   */
   
   if(day_candle > old_day_candle){
      
      bool status_can_break = false;
      
      // status file
      while(true){
         
         int f = FileOpen("status.txt", FILE_READ | FILE_TXT);
         
         string data = FileReadString(f);
         FileClose(f);
         
         Print("***************** STATUS");
         Print(data);
         
         
         if(data == "0"){
            //Print("UPPPPPPPPPPPP");
            //double TP = Bid + NormalizeDouble(1500 * Point, Digits);
            //Print("--------------- TP " + TP);
            //Print("--------------- Bid " + Bid);
            //OrderSend(Symbol(), OP_BUY, 0.01, Ask, 3, 0, TP, "", 0, 0, clrGreen);
            Print("OK");
            int f = FileOpen("status.txt", FILE_WRITE | FILE_TXT);
            FileWrite(f, "1");
            FileClose(f);
            status_can_break = true;
         }
         else{
            Print("NOOOOOOOO!!!!!");
         }
         
         
         
         
         if(status_can_break){
            break;
         }
         
         
      }
      
      
      string data_set[1];
      int inp_width = 14;
      ArrayResize(data_set, inp_width);
      
      
      // pipe_send file
      while(true){
         
         
         Print("***************** PIPE SEND");
         int f = FileOpen("pipe_send.txt", FILE_WRITE | FILE_TXT, '\n');
         /*
         double time_step1 = High[5];
         double time_step2 = High[4];
         double time_step3 = High[3];
         double time_step4 = High[2];
         double time_step5 = High[1];
         */
         
         
         for(int i=0;i < inp_width;i++){
            
            /*
            double data_low = Low[i];
            double data_high = High[i];
            double data_open = Open[i];
            double data_close = Close[i];
            double data_ema200 = iMA(Symbol(), PERIOD_H4, 200, 0, MODE_EMA, PRICE_CLOSE, i);
            double data_ema100 = iMA(Symbol(), PERIOD_H4, 100, 0, MODE_EMA, PRICE_CLOSE, i);
            double data_ema50 = iMA(Symbol(), PERIOD_H4, 50, 0, MODE_EMA, PRICE_CLOSE, i);
            double data_rsi = iRSI(Symbol(), PERIOD_H4, 14, PRICE_CLOSE, i);
            double data_macd_main = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, i);
            double data_macd_signal = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, i);
            double bb_up = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, i);
            double bb_low = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, i);
            double sto_main = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, i);
            double sto_signal = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_SIGNAL, i);
            double ichimoku_tenkan_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_TENKANSEN, i);
            double ichimoku_kijun_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_KIJUNSEN, i);
            double ichimoku_senkou_span_a = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANA, i);
            double ichimoku_senkou_span_b = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANB, i);
            double adx_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, i);
            double adx_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, i);
            double adx_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, i);
            double adx50_main = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MAIN, i);
            double adx50_plusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_PLUSDI, i);
            double adx50_minusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MINUSDI, i);
            double adx100_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, i);
            double adx100_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, i);
            double adx100_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, i);
            double adx200_main = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MAIN, i);
            double adx200_plusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_PLUSDI, i);
            double adx200_minusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MINUSDI, i);
            */
            
            double data_low = Low[inp_width - i] - Low[inp_width - (i - 1)];
            double data_high = High[inp_width - i] - High[inp_width - (i - 1)];
            double data_open = Open[inp_width - i] - Open[inp_width - (i - 1)];
            double data_close = Close[inp_width - i] - Close[inp_width - (i - 1)];
            double data_ema200 = iMA(Symbol(), PERIOD_H4, 200, 0, MODE_EMA, PRICE_CLOSE, inp_width - i) - iMA(Symbol(), PERIOD_H4, 200, 0, MODE_EMA, PRICE_CLOSE, inp_width - (i - 1));
            double data_ema100 = iMA(Symbol(), PERIOD_H4, 100, 0, MODE_EMA, PRICE_CLOSE, inp_width - i) - iMA(Symbol(), PERIOD_H4, 100, 0, MODE_EMA, PRICE_CLOSE, inp_width - (i - 1));
            double data_ema50 = iMA(Symbol(), PERIOD_H4, 50, 0, MODE_EMA, PRICE_CLOSE, inp_width - i) - iMA(Symbol(), PERIOD_H4, 50, 0, MODE_EMA, PRICE_CLOSE, inp_width - (i - 1));
            double data_rsi = iRSI(Symbol(), PERIOD_H4, 14, PRICE_CLOSE, inp_width - i) - iRSI(Symbol(), PERIOD_H4, 14, PRICE_CLOSE, inp_width - (i - 1));
            double data_macd_main = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, inp_width - i) - iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, inp_width - (i - 1));
            double data_macd_signal = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, inp_width - i) - iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, inp_width - (i - 1));
            double bb_up = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, inp_width - i) - iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, inp_width - (i - 1));
            double bb_low = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, inp_width - i) - iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, inp_width - (i - 1));
            double sto_main = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, inp_width - i) - iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, inp_width - (i - 1));
            double sto_signal = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_SIGNAL, inp_width - i) - iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_SIGNAL, inp_width - (i - 1));
            double ichimoku_tenkan_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_TENKANSEN, inp_width - i) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_TENKANSEN, inp_width - (i - 1));
            double ichimoku_kijun_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_KIJUNSEN, inp_width - i) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_KIJUNSEN, inp_width - (i - 1));
            double ichimoku_senkou_span_a = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANA, inp_width - i) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANA, inp_width - (i - 1));
            double ichimoku_senkou_span_b = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANB, inp_width - i) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANB, inp_width - (i - 1));
            double adx_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, inp_width - i) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, inp_width - (i - 1));
            double adx_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, inp_width - (i - 1));
            double adx_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, inp_width - (i - 1));
            double adx50_main = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MAIN, inp_width - i) - iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MAIN, inp_width - (i - 1));
            double adx50_plusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_PLUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_PLUSDI, inp_width - (i - 1));
            double adx50_minusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MINUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MINUSDI, inp_width - (i - 1));
            double adx100_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, inp_width - i) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, inp_width - (i - 1));
            double adx100_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, inp_width - (i - 1));
            double adx100_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, inp_width - (i - 1));
            double adx200_main = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MAIN, inp_width - i) - iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MAIN, inp_width - (i - 1));
            double adx200_plusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_PLUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_PLUSDI, inp_width - (i - 1));
            double adx200_minusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MINUSDI, inp_width - i) - iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MINUSDI, inp_width - (i - 1));
            
            
            string data_concat = "";
            data_concat += data_low + ",";
            data_concat += data_high + ",";
            data_concat += data_open + ",";
            data_concat += data_close + ",";
            data_concat += data_ema200 + ",";
            data_concat += data_ema100 + ",";
            data_concat += data_ema50 + ",";
            data_concat += data_rsi + ",";
            data_concat += data_macd_main + ",";
            data_concat += data_macd_signal + ",";
            data_concat += bb_up + ",";
            data_concat += bb_low + ",";
            data_concat += sto_main + ",";
            data_concat += sto_signal + ",";
            data_concat += ichimoku_tenkan_sen + ",";
            data_concat += ichimoku_kijun_sen + ",";
            data_concat += ichimoku_senkou_span_a + ",";
            data_concat += ichimoku_senkou_span_b + ",";
            data_concat += adx50_main + ",";
            data_concat += adx50_plusdi + ",";
            data_concat += adx50_minusdi + ",";
            data_concat += adx100_main + ",";
            data_concat += adx100_plusdi + ",";
            data_concat += adx100_minusdi + ",";
            data_concat += adx200_main + ",";
            data_concat += adx200_plusdi + ",";
            data_concat += adx200_minusdi;
            
            data_set[i] = data_concat;
            
         }
         
         
         
         //string data_set;
         //data_set = time_step1 + "," + time_step2 + "," + time_step3 + "," + time_step4 + "," + time_step5;
         //FileWrite(f, data_set);
         FileWriteArray(f, data_set, 0, inp_width);
         
         FileClose(f);
         
         break;
         
         
      }
      
      
      // pipe_return file
      while(true){
         
         
         double lot = lot_default;
         
         // Lot by balance
         //lot = lotByBalance(lot_default);
         
         Print("***************** PIPE RETURN");
         int f = FileOpen("pipe_return.txt", FILE_READ | FILE_TXT, '\n');
         string data = FileReadString(f);
         Print(data);
         FileClose(f);
         if(data == "1"){
            Print("UPPPPPPPPPPPP");
            double TP = Bid + NormalizeDouble(tp_distance * Point, Digits);
            Print("--------------- TP " + TP);
            Print("--------------- Bid " + Bid);
            OrderSend(Symbol(), OP_BUY, lot, Ask, 3, 0, TP, "UP", 0, 0, clrGreen);
            break;
         }
         else if(data == "2"){
            Print("DOWNNNNNNNNNN");
            double TP = Ask - NormalizeDouble(tp_distance * Point, Digits);
            Print("--------------- TP " + TP);
            Print("--------------- Ask " + Ask);
            OrderSend(Symbol(), OP_SELL, lot, Bid, 3, 0, TP, "DOWN", 0, 0, clrRed);
            break;
         }
         else if(data == "3"){
            
            Print("UPPPPPPPPPPPP BOTH");
            double TP_UP = Bid + NormalizeDouble(tp_distance * Point, Digits);
            Print("--------------- TP_UP " + TP_UP);
            Print("--------------- Bid " + Bid);
            OrderSend(Symbol(), OP_BUY, lot, Ask, 3, 0, TP_UP, "BOTH UP", 0, 0, clrGreen);
            
            Print("DOWNNNNNNNNNN BOTH");
            double TP_DOWN = Ask - NormalizeDouble(tp_distance * Point, Digits);
            Print("--------------- TP_DOWN " + TP_DOWN);
            Print("--------------- Ask " + Ask);
            OrderSend(Symbol(), OP_SELL, lot, Bid, 3, 0, TP_DOWN, "BOTH DOWN", 0, 0, clrRed);
            break;
            
         }
         else if(data == "0"){
            Print("PASSSSSSSSSS");
            break;
         }
         
         
         
         
         
      }
      
      
      
      old_day_candle = day_candle;
      
      
   }
   
   //check_close_with_time();
   //check_set_stoploss();
   check_close_with_time_or_set_stoploss();
   
   
   
   
   
   Comment(comment);
   
   
  }
//+------------------------------------------------------------------+






void check_close_with_time(){
   
   for(int i = 0;i < OrdersTotal();i++){
      if(OrderSelect(i, SELECT_BY_POS)){
         if(OrderSymbol() != Symbol()){
            continue;
         }
         
         datetime timeClose = OrderOpenTime() + timeToClose;
         
         
         if(TimeCurrent() >= timeClose){
            
            if(OrderType() == OP_BUY){
               OrderClose(OrderTicket(), OrderLots(), Bid, 3, clrGreen);
            }
            else if(OrderType() == OP_SELL){
               OrderClose(OrderTicket(), OrderLots(), Ask, 3, clrRed);
            }
            
         }
         
      } // end if
   } // end for
   
}

void check_set_stoploss(){
   
   for(int i = 0;i < OrdersTotal();i++){
      if(OrderSelect(i, SELECT_BY_POS)){
         if(OrderSymbol() != Symbol()){
            continue;
         }
         
         datetime timeClose = OrderOpenTime() + timeToClose;
         
         
         if(TimeCurrent() >= timeClose){
            
            if(OrderType() == OP_BUY){
               //OrderClose(OrderTicket(), OrderLots(), Bid, 3, clrGreen);
               double stoploss = OrderOpenPrice() - NormalizeDouble(tp_distance * Point, Digits);
               OrderModify(OrderTicket(), OrderOpenPrice(), stoploss, OrderTakeProfit(), 0, clrLime);
            }
            else if(OrderType() == OP_SELL){
               //OrderClose(OrderTicket(), OrderLots(), Ask, 3, clrRed);
               double stoploss = OrderOpenPrice() + NormalizeDouble(tp_distance * Point, Digits);
               OrderModify(OrderTicket(), OrderOpenPrice(), stoploss, OrderTakeProfit(), 0, clrPink);
            }
            
         }
         
      } // end if
   } // end for
   
}

void check_close_with_time_or_set_stoploss(){
   
   for(int i = 0;i < OrdersTotal();i++){
      if(OrderSelect(i, SELECT_BY_POS)){
         if(OrderSymbol() != Symbol()){
            continue;
         }
         
         datetime timeClose = OrderOpenTime() + timeToClose;
         
         
         if(TimeCurrent() >= timeClose){
            
            if(OrderType() == OP_BUY){
               
               if(Bid >= OrderOpenPrice() && OrderLots() == 0){
                  OrderClose(OrderTicket(), OrderLots(), Bid, 3, clrGreen);
               }
               else{
                  double spread = MarketInfo(Symbol(), MODE_SPREAD);
                  double stoploss = OrderOpenPrice() - NormalizeDouble((sl_distance - spread) * Point, Digits);
                  double takeprofit = OrderOpenPrice() + NormalizeDouble((tp_distance_update - spread) * Point, Digits);
                  Print("TP = " + takeprofit + " OrderOpenPrice = " + OrderOpenPrice());
                  OrderModify(OrderTicket(), OrderOpenPrice(), stoploss, takeprofit, 0, clrLime);
               }
            }
            else if(OrderType() == OP_SELL){
               
               if(Ask <= OrderOpenPrice() && OrderLots() == 0){
                  OrderClose(OrderTicket(), OrderLots(), Ask, 3, clrRed);
               }
               else{
                  double spread = MarketInfo(Symbol(), MODE_SPREAD);
                  double stoploss = OrderOpenPrice() + NormalizeDouble((sl_distance + spread) * Point, Digits);
                  double takeprofit = OrderOpenPrice() - NormalizeDouble((tp_distance_update + spread) * Point, Digits);
                  OrderModify(OrderTicket(), OrderOpenPrice(), stoploss, takeprofit, 0, clrPink);
               }
            }
            
         }
         
      } // end if
   } // end for
   
}






double lotByBalance(double _lot){
   double XLotByBalance = 10000;
   double lotX = AccountBalance() / XLotByBalance;
   double lot_new = NormalizeDouble(_lot * lotX, 2);
   //Print("____________________________ _lot " + _lot);
   //Print("____________________________ lotX " + lotX);
   //Print("____________________________ lot_new " + lot_new);
   return lot_new;
}