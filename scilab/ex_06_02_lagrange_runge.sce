// ラグランジュの補間法

clear

printf("\n")
printf("////////////////////////////\n")
printf("// Lagrange interpolation //\n")
printf("////////////////////////////\n\n")

k = 8;  // 与えられたデータ数

deff('[y] = f(x)', 'y = 1/(1 + x^2)');

 
x_data  = linspace(-5,5,k);

for  i=1:k
  y_data(i)  = f(x_data(i));
end

// 推定値の x 座標
kk = 200;  // 推定したいデータ数
x = linspace(x_data(1),x_data(k),kk); 

// 推定値の算出（ここから）
for num = 1:kk
  xx = x(num);
  yy = 0;
  
  for i = 1:k
    z(i) = 1;
    
    for j = 1:k
      if i ~= j
        z(i) = z(i)*(xx - x_data(j))/(x_data(i) - x_data(j));
      end
    end
    
    yy = yy + y_data(i)*z(i);
  end

  printf("x = %f, y = %f\n",xx,yy); // 推定値の表示
  y(num) = yy;
end
// 推定値の算出（ここまで）  
  
// グラフの描画 ////////////////////////////////////////////////////////////
clf;                                      // グラフィックの消去
subplot(1.5,1,1)
plot(x_data,y_data,'ko','linewidth',3,'markersize',12);
                  // データの描画（色：赤，印：○，線の太さ：3，印の大きさ：12）
plot(x,y,'k','linewidth',3);
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
//////////////////////////////////////////////////////////////////////////

x_real = linspace(-6,6,200);
for i=1:200
  y_real(i)  = f(x_real(i));
end
plot(x_real,y_real,'k--','linewidth',3);
graph.data_bounds = [-6 -1.5; 6 1.5];   // [xmin ymin; xmax ymax]
