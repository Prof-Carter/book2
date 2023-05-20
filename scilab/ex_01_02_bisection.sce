clear;

deff('[y] = f(x)' ,'y  = x.^2 - 1 - sin(x)');  // y = f(x) の定義

// グラフの描画 ////////////////////////////////////////////////////////////
x_data = -4:0.01:4;                       // -4 から 4 まで0.01 刻みのデータ
clf;                                      // グラフィックの消去
plot(x_data,f(x_data),'linewidth',3);     // y = f(x) の描画（線の太さ：3）
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
graph.data_bounds = [-4 -2; 4 10]; // [xmin ymin; xmax ymax]
//////////////////////////////////////////////////////////////////////////

printf("\n")
printf("Input a and b (a < b and f(a)*f(b) < 0).\n")
printf("a = ?\n"); a = scanf("%f")     // ステップ 1
printf("b = ?\n"); b = scanf("%f")

c = (a + b)/2;  // ステップ 2
e = 1e-5;       // εの設定

k = 1;

if a > b
  flag = 1;
elseif f(a)*f(b) > 0
  flag = 2;
else
  flag = 0;
end
  
while flag == 0 & b - a > e  // ステップ 3 の収束条件
  printf("k = %3d, a = %f, b = %f, c = %f, b - a = %f\n", k, a, b, c, b-a); 
  
  if f(a)*f(c) < 0  // ステップ 4
    b = c;
  else // f(a)*f(c) > 0
    a = c;
  end
  
  k = k + 1;
  c = (a + b)/2;    // ステップ 2
end

if flag == 0
  printf("k = %3d, a = %f, b = %f, c = %f, b - a = %f\n\n", k, a, b, c, b-a); 
  printf("solution: x = %f\n",c); 
elseif flag == 1
  printf("a > b !!\n");   
elseif flag == 2
  printf("f(a)*f(b) > 0 !!\n");   
end
