clear

deff('[y] = f(x)'     ,'y  = x.*sin(x) + 6');  // y = f(x) の定義

a = 1;         // 積分区間の下限
b = 6;         // 積分区間の上限

printf("n = ?\n"); // 分割数の入力
n  = scanf("%d");       

h  = (b - a)/n; // 分割幅
x = a:h:b;      // 標本点（a から b まで等間隔 h のデータ）

x2 = a+h/2:h:b-h/2; // 中点

for i=1:n
    y2(i) = f(x2(i));
end

// 中点公式による数値積分 ///////////////////////////////////////////////////////////
S_mid = 0;   // 初期設定

for i=1:n
  S_mid = S_mid + h*y2(i);    // 中点公式による数値積分
end

// 厳密解 /////////////////////////////////////////////////////////////////////////
deff('[S] = int_f(x)' ,'S  = - x.*cos(x) + sin(x) + 6*x');  // y = f(x) の積分の定義

S = int_f([b]) - int_f([a]);

// 結果の表示 /////////////////////////////////////////////////////////////////////
printf("\n")
printf("a = %f\n", a);
printf("b = %f\n", b);
printf("n = %d\n", n);
printf("h = %f\n\n", h);
printf("+++++ midpoint rule ++++++\n");
printf("S_mid = %e\n", S_mid);
printf("+++++ exact solution +++++\n");
printf("S     = %e\n", S);

// グラフの描画 /////////////////////////////////////////////////////////////////////
clf;                            // グラフィックの消去
x_data = a:0.01:b;              // y = f(x) を描画するための x 座標
plot(x_data,f(x_data),'linewidth',3);     // y = f(x) の描画（線の太さ：3）
xgrid;                          // グリッドラインの追加
xlabel('x');                    // 横軸のラベル
ylabel('y');                    // 縦軸のラベル

graph = gca();                  // 軸のハンドル（個々を認識する番号）を取得
graph.font_style = 2;           // 目盛りのフォント（2: times）
graph.font_size  = 4;           // 目盛りのフォントサイズ（0〜6まで設定可能）
graph.x_label.font_style = 3;   // 横軸のラベルのフォント（3: times italic）
graph.x_label.font_size  = 5;   // 横軸のラベルのフォントサイズ（0〜6まで設定可能）
graph.y_label.font_style = 3;   // 縦軸のラベルのフォント（3: times italic）
graph.y_label.font_size  = 5;   // 縦軸のラベルのフォントサイズ（0〜6まで設定可能）
graph.data_bounds = [0 -2; 7 10]; // [xmin ymin; xmax ymax]

for i=1:n
  // 中点公式における長方形の描画
  plot([x(i) x(i) x(i+1) x(i+1)],[0 y2(i) y2(i) 0],'r')
  plot([x2(i) x2(i)],[0 y2(i)],'g--')
end
plot([a b],[0 0],'r');
