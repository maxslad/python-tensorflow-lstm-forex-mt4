//+------------------------------------------------------------------+
//|                                     get_data_time_series_LIM.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict










//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   
   string feature = "ALL_LIMS_DST_S2020";
   string file_name = "data_time_series_" + feature + "_th";
   int day_predict = 6*5; // 6 = 1d (4h * 6), 5 = 5d, day_predict = 30
   
   //datetime time_first_candle_select = D'2017.07.03 03:00';
   datetime time_first_candle_select = D'2020.12.31 19:00';
   int first_candle_select = iBarShift(Symbol(), PERIOD_CURRENT, time_first_candle_select);
   
   //datetime time_first_stop_candle_select = D'2020.12.31 19:00';
   datetime time_first_stop_candle_select = D'2021.12.31 19:00';
   int first_candle_stop_select = iBarShift(Symbol(), PERIOD_CURRENT, time_first_stop_candle_select);
   
   double threshold = 1000;
   double threshold_norm = NormalizeDouble(threshold * Point, Digits);
   file_name += threshold;
   
   string data_set[1];
   ArrayResize(data_set, (first_candle_select - first_candle_stop_select) + 10);
   data_set[0] = "time";
   data_set[0] += ",candle_number";
   data_set[0] += ",low";
   data_set[0] += ",high";
   data_set[0] += ",open";
   data_set[0] += ",close";
   data_set[0] += ",ema200";
   data_set[0] += ",ema100";
   data_set[0] += ",ema50";
   data_set[0] += ",rsi";
   data_set[0] += ",macd_main";
   data_set[0] += ",macd_signal";
   data_set[0] += ",bb_up";
   data_set[0] += ",bb_low";
   data_set[0] += ",sto_main";
   data_set[0] += ",sto_signal";
   data_set[0] += ",ichimoku_tenkan_sen";
   data_set[0] += ",ichimoku_kijun_sen";
   data_set[0] += ",ichimoku_senkou_span_a";
   data_set[0] += ",ichimoku_senkou_span_b";
   data_set[0] += ",adx50_main";
   data_set[0] += ",adx50_plusdi";
   data_set[0] += ",adx50_minusdi";
   data_set[0] += ",adx100_main";
   data_set[0] += ",adx100_plusdi";
   data_set[0] += ",adx100_minusdi";
   data_set[0] += ",adx200_main";
   data_set[0] += ",adx200_plusdi";
   data_set[0] += ",adx200_minusdi";
   
   data_set[0] += ",label";
   data_set[0] += ",log";
   
   
   Print("first_candle_select " + first_candle_select);
   Print("first_candle_stop_select " + first_candle_stop_select);
   Print("---- " + (first_candle_select - first_candle_stop_select));
   
   
   int counter = 1;
   for(int i=0; i < (first_candle_select - first_candle_stop_select);i++){
      
      if(i + day_predict >= (first_candle_select - first_candle_stop_select)){
         break;
      }
      
      //Print(" > " + i);
      /*
      double data_low = Low[first_candle_select - (i)];
      double data_high = High[first_candle_select - (i)];
      double data_open = Open[first_candle_select - (i)];
      double data_close = Close[first_candle_select - (i)];
      double data_ema200 = iMA(Symbol(), PERIOD_H4, 200, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i)));
      double data_ema100 = iMA(Symbol(), PERIOD_H4, 100, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i)));
      double data_ema50 = iMA(Symbol(), PERIOD_H4, 50, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i)));
      double data_rsi = iRSI(Symbol(), PERIOD_H4, 14, PRICE_CLOSE, (first_candle_select - (i)));
      double data_macd_main = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i)));
      double data_macd_signal = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, (first_candle_select - (i)));
      double bb_up = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, (first_candle_select - (i)));
      double bb_low = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, (first_candle_select - (i)));
      double sto_main = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, (first_candle_select - (i)));
      double sto_signal = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_SIGNAL, (first_candle_select - (i)));
      double ichimoku_tenkan_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_TENKANSEN, (first_candle_select - (i)));
      double ichimoku_kijun_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_KIJUNSEN, (first_candle_select - (i)));
      double ichimoku_senkou_span_a = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANA, (first_candle_select - (i)));
      double ichimoku_senkou_span_b = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANB, (first_candle_select - (i)));
      double adx_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i)));
      double adx_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i)));
      double adx_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i)));
      double adx50_main = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i)));
      double adx50_plusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i)));
      double adx50_minusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i)));
      double adx100_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i)));
      double adx100_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i)));
      double adx100_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i)));
      double adx200_main = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i)));
      double adx200_plusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i)));
      double adx200_minusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i)));
      */
      
      double data_low = Low[first_candle_select - (i)] - Low[first_candle_select - (i - 1)];
      double data_high = High[first_candle_select - (i)] - High[first_candle_select - (i - 1)];
      double data_open = Open[first_candle_select - (i)] - Open[first_candle_select - (i - 1)];
      double data_close = Close[first_candle_select - (i)] - Close[first_candle_select - (i - 1)];
      double data_ema200 = iMA(Symbol(), PERIOD_H4, 200, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i))) - iMA(Symbol(), PERIOD_H4, 200, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i - 1)));
      double data_ema100 = iMA(Symbol(), PERIOD_H4, 100, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i))) - iMA(Symbol(), PERIOD_H4, 100, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i - 1)));
      double data_ema50 = iMA(Symbol(), PERIOD_H4, 50, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i))) - iMA(Symbol(), PERIOD_H4, 50, 0, MODE_EMA, PRICE_CLOSE, (first_candle_select - (i - 1)));
      double data_rsi = iRSI(Symbol(), PERIOD_H4, 14, PRICE_CLOSE, (first_candle_select - (i))) - iRSI(Symbol(), PERIOD_H4, 14, PRICE_CLOSE, (first_candle_select - (i - 1)));
      double data_macd_main = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i))) - iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i - 1)));
      double data_macd_signal = iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, (first_candle_select - (i))) - iMACD(Symbol(), PERIOD_H4, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, (first_candle_select - (i - 1)));
      double bb_up = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, (first_candle_select - (i))) - iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_UPPER, (first_candle_select - (i - 1)));
      double bb_low = iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, (first_candle_select - (i))) - iBands(Symbol(), PERIOD_H4, 20, 2, 0, PRICE_CLOSE, MODE_LOWER, (first_candle_select - (i - 1)));
      double sto_main = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, (first_candle_select - (i))) - iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_MAIN, (first_candle_select - (i - 1)));
      double sto_signal = iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_SIGNAL, (first_candle_select - (i))) - iStochastic(Symbol(), PERIOD_H4, 5, 3, 3, MODE_SMA, 0, MODE_SIGNAL, (first_candle_select - (i - 1)));
      double ichimoku_tenkan_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_TENKANSEN, (first_candle_select - (i))) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_TENKANSEN, (first_candle_select - (i - 1)));
      double ichimoku_kijun_sen = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_KIJUNSEN, (first_candle_select - (i))) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_KIJUNSEN, (first_candle_select - (i - 1)));
      double ichimoku_senkou_span_a = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANA, (first_candle_select - (i))) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANA, (first_candle_select - (i - 1)));
      double ichimoku_senkou_span_b = iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANB, (first_candle_select - (i))) - iIchimoku(Symbol(), PERIOD_H4, 9, 26, 52, MODE_SENKOUSPANB, (first_candle_select - (i - 1)));
      double adx_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i - 1)));
      double adx_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i - 1)));
      double adx_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i - 1)));
      double adx50_main = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i - 1)));
      double adx50_plusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i - 1)));
      double adx50_minusdi = iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 50, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i - 1)));
      double adx100_main = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i - 1)));
      double adx100_plusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i - 1)));
      double adx100_minusdi = iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 100, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i - 1)));
      double adx200_main = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MAIN, (first_candle_select - (i - 1)));
      double adx200_plusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_PLUSDI, (first_candle_select - (i - 1)));
      double adx200_minusdi = iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i))) - iADX(Symbol(), PERIOD_H4, 200, PRICE_CLOSE, MODE_MINUSDI, (first_candle_select - (i - 1)));
      
      
      string data_concat = "";
      data_concat += Time[first_candle_select - i] + ",";
      data_concat += (first_candle_select - i) + ",";
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
      data_concat += adx200_minusdi + ",";
      
      
      
      
      
      
      double y = 0;
      
      double trend_up_val = 0;
      
      
      bool up = false;
      bool down = false;
      
      string log_up = "false";
      string log_down = "false";
      
      string log_up_file = "0";
      string log_down_file = "0";
      
      //for(int j=0; j < day_predict; j
      for(int j=1; j <= day_predict; j++){
         
         //int time_fur = first_candle_select - (i + 1 + j);
         int time_fur = first_candle_select - (i + j);
         
         //Print(time_fur);
         
         if(High[time_fur] >= Close[first_candle_select - i] + threshold_norm){
            up = true;
            log_up_file = DoubleToStr(High[time_fur], Digits);
            Print(High[time_fur] + " >= " + ( Close[first_candle_select - i] + threshold_norm) + " | BAR:" + (first_candle_select - i) + " | BAR FUR:" + time_fur + " | " + "Predict Bar> " + (first_candle_select - i));
         }
         
         if(Low[time_fur] <= Close[first_candle_select - i] - threshold_norm){
            down = true;
            log_down_file = DoubleToStr(Low[time_fur], Digits);
            Print(Low[time_fur] + " <= " + ( Close[first_candle_select - i] - threshold_norm) + " | BAR:" + (first_candle_select - i) + " | BAR FUR:" + time_fur + " | " + "Predict Bar> " + (first_candle_select - i));
         }
         
      }
      
      if(up){
         y = 1;
         log_up = "true";
      }
      
      if(down){
         y = 2;
         log_down = "true";
      }
      
      if(up && down){
         y = 3;
      }
      
      double THS_UP = Close[first_candle_select - i] + threshold_norm;
      double THS_DOWN = Close[first_candle_select - i] - threshold_norm;
      
      
      data_concat += y + ",";
      data_concat += "CLOSE:" + Close[first_candle_select - i] + "|UP:" + log_up_file + "|DOWN:" + log_down_file + "|THS:" + threshold_norm + "=U" + THS_UP + ":D" + THS_DOWN + "|BAR:" + (first_candle_select - i);
      
      
      /*
      string temp = "";
      temp += low_concat + ";";
      temp += high_concat + ";";
      temp += ema200_concat + ";";
      temp += ema100_concat + ";";
      temp += ema50_concat + ";";
      temp += y + ";";
      temp += "CLOSE:" + Close[first_candle_select - (i+4)] + "|UP:" + log_up_file + "|DOWN:" + log_down_file + "|THS:" + threshold_norm + "=D" + THS_UP + ":U" + THS_DOWN + "|BAR:" + (first_candle_select - (i+4));
      */
      
      string temp_log = data_concat +  " = " + (first_candle_select - i) + " | UP> " + log_up + " DOWN> " + log_down + " | Candle Predict> " + (first_candle_select - i) + " | i> " + i + " | " + (first_candle_select - (i + 4 + day_predict));
      
      
      //Print("*********** " + (first_candle_select - i));
      Print("*********** " + temp_log);
      data_set[counter] = data_concat;
      
      counter += 1;
      
      
   }
   
   
   Print(threshold_norm);
   
   
   Print("data_set " + ArraySize(data_set));
   
   file_name += ".txt";
   int f = FileOpen(file_name, FILE_WRITE | FILE_TXT, '\n');
   if(f != INVALID_HANDLE){
      Print("--------------------- OKK");
   }
   else{
      Print("--------------------- NOOOO");
   }
   //FileWrite(f, "MAX", 10);
   
   string arr[4] = {"11", "22", "33", "44", "55"};
   FileWriteArray(f, data_set, 0, first_candle_select);
   FileClose(f);
   
   
   
   
   
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
   
  }
//+------------------------------------------------------------------+
