clear

n = 3;  // 与えられたデータ数（標本点の数）：n+1 個

x_data = [-3 -1   3   6]; // [x1 x2 x3 x4]
y_data = [-5 20 -15 -10]; // [y1 y2 y3 y4]

// ddy の算出（ここから）////////////////////////////////////////////////////
for i = 1:n
  h(i) = x_data(i+1) - x_data(i);
end

for i = 1:n-1
  for j = 1:n-1
    if i == j
      A(i,j) = 2*(h(i)+h(i+1));
    elseif i == j-1
      A(i,j) = h(i+1);
    elseif i == j+1
      A(i,j) = h(i);
    else
      A(i,j) = 0;
    end
  end
end

for i = 1:n-1
  z(i+1) = 6*((y_data(i+2) - y_data(i+1))/h(i+1) - (y_data(i+1) - y_data(i))/h(i));
end
b = z(2:n);

p = A\b;   // 連立１次方程式を解く
ddy = [ 0
        p
        0 ];
        
printf("\n")
for i=2:n
  printf("ddy%d = %f\n"  , i,   ddy(i));
end
printf("\n")
// ddy の算出（ここまで）////////////////////////////////////////////////////

// 推定値の算出（ここから）///////////////////////////////////////////////////
num = 0;
x = -3:0.25:6; // 推定値の x 座標

for num=1:size(x,2)
  // x(num) がどの区間にあるかを判別
  for k = 1:n
    if x(num) >= x_data(k) & x(num) <= x_data(k+1)
      i = k;
      break
    end
  end

  // 自然な３次のスプライン補間
  y(num) = (1/6)*(x_data(i+1) - x(num))^3/h(i)*ddy(i) ...
         + (1/6)*(x(num)   - x_data(i))^3/h(i)*ddy(i+1) ...
         + (1/h(i)*y_data(i)   - h(i)/6*ddy(i)  )*(x_data(i+1) - x(num)) ...
         + (1/h(i)*y_data(i+1) - h(i)/6*ddy(i+1))*(x(num)   - x_data(i));
         
  printf("x = %f, y = %f\n", x(num), y(num));   // 推定値の表示
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
graph.data_bounds = [-4 -25; 8 25];   // [xmin ymin; xmax ymax]
//////////////////////////////////////////////////////////////////////////
