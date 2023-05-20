clear

n = 2;  // 与えられたデータ数（標本点の数）：n+1 個
 
x_data  = [ -2   2   4 ];  // [x1 x2 x3]
y_data  = [  8   4  14 ];  // [y1 y2 y3]

// 推定値の算出（ここから）///////////////////////////////////////////////////
x = -2:0.2:4;   // 推定値の x 座標

for num = 1:size(x,2)
  y(num) = 0;
  
  for i = 1:n+1
    z(i) = 1;
    
    for j = 1:n+1
      if i ~= j
        z(i) = z(i)*(x(num) - x_data(j))/(x_data(i) - x_data(j));
      end
    end
    
    y(num) = y(num) + y_data(i)*z(i);
  end

  printf("x = %f, y = %f\n",x(num),y(num));   // 推定値の表示
end
// 推定値の算出（ここまで）///////////////////////////////////////////////////  
  
// グラフの描画 ////////////////////////////////////////////////////////////
clf;                                      // グラフィックの消去
plot(x_data,y_data,'ro','linewidth',3,'markersize',12);
                  // 標本点の描画（色：赤，印：○，線の太さ：3，印の大きさ：12）
plot(x,y,'b','linewidth',3); 
                  // 推定値の描画（色：青，線の太さ：3）   
xgrid;                                    // グリッドラインの追加         
xlabel('x');                              // 横軸のラベル
ylabel('y');                              // 縦軸のラベル

graph = gca();                  // 軸のハンドル（個々を認識する番号）を取得
graph.font_style = 2;           // 目盛りのフォント（2: times）
graph.font_size  = 4;           // 目盛りのフォントサイズ（0〜6まで設定可能）
graph.x_label.font_style = 3;   // 横軸のラベルのフォント（3: times italic）
graph.x_label.font_size  = 5;   // 横軸のラベルのフォントサイズ（0〜6まで設定可能）
graph.y_label.font_style = 3;   // 縦軸のラベルのフォント（3: times italic）
graph.y_label.font_size  = 5;   // 縦軸のラベルのフォントサイズ（0〜6まで設定可能）
graph.data_bounds = [-3 0; 5 16];   // [xmin ymin; xmax ymax]
//////////////////////////////////////////////////////////////////////////
