// シンプソンの公式

clear

deff('[y] = f(x)'     ,'y  = x.^(-1)');  // y = f(x) の定義
deff('[S] = int_f(x)' ,'S  = log(x)');  // y = f(x) の積分の定義

a = 1;         // 積分区間の下限
b = 5;         // 積分区間の上限

printf("n = ?\n"); // 分割数の入力
n  = scanf("%d");   

m = n/2;

h  = (b - a)/n; // 分割幅
x = a:h:b;     // 分割データ（a から b まで等間隔 h のデータ）

for i=1:2*m+1
  y(i) = f(x(i));
end

// グラフの描画 ////////////////////////////////////////////////////////////
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
//graph.data_bounds = [0 -2; 7 10]; // [xmin ymin; xmax ymax]

// ラグランジュ補間による２次関数の描画 //////////////////////////////////////
for i = 1:m

  k0 = (2*i - 2) + 1;
  k1 = (2*i - 1) + 1;
  k2 = (2*i - 0) + 1;

  xs = x(k0):0.01:x(k2);
  ys = y(k0)*(xs - x(k1)).*(xs - x(k2))/((x(k0) - x(k1))*(x(k0) - x(k2))) ...
     + y(k1)*(xs - x(k0)).*(xs - x(k2))/((x(k1) - x(k0))*(x(k1) - x(k2))) ...
     + y(k2)*(xs - x(k0)).*(xs - x(k1))/((x(k2) - x(k0))*(x(k2) - x(k1)));

  if modulo(i,2) == 0
    plot(xs,ys,'r:')
  else
    plot(xs,ys,'r--')
  end
  plot([x(k0) x(k0)],[0 y(k0)],'r')
  plot([x(k1) x(k1)],[0 y(k1)],'g-.')
end

plot([x(k2) x(k2)],[0 y(k2)],'r')
plot([a b],[0 0],'r')

// シンプソンの公式による数値積分 ///////////////////////////////////////////
S_sim = 0;

for i=1:m
  k0 = (2*i - 2) + 1;
  k1 = (2*i - 1) + 1;
  k2 = (2*i - 0) + 1;
	
  S_sim = S_sim + (h/3)*(y(k0) + 4*y(k1) + y(k2));
end

// 解析解 ////////////////////////////////////////////////////////////////
S = int_f([b]) - int_f([a]);

// 結果の表示 ////////////////////////////////////////////////////////////
printf("\n")
printf("///////////////////////////\n")
printf("// numerical integration //\n");
printf("// (Simpson rule)        //\n")
printf("///////////////////////////\n\n")
printf("a = %f\n", a);
printf("b = %f\n", b);
printf("n = %d\n", n);
printf("h = %f\n\n", h);
printf("+++++ Simpson rule +++++++\n");
printf("S_sim = %9.7e\n", S_sim);
printf("+++++ exact solution +++++\n");
printf("S     = %9.7e\n", S);
