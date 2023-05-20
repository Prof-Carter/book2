clear

k = 5;  // 与えられたデータ数
n = 1;  // n次関数で近似

x_data = [ -3.1   -1.8   -0.2    0.8    2.4 ];
y_data = [ -3.7   -1.6    1.7    3.5    5.6 ];

// 行列 X'*X，X'*y の生成（ここから）/////////////////////////////////////////
XX = zeros(n+1,n+1);  // X'*X の初期化
Xy = zeros(n+1,1);    // X'*y の初期化

for n1 = 1:n+1
    num = 2*n + 1 - n1;
    for n2 = 1:n+1
        for i = 1:k
            XX(n1,n2) = XX(n1,n2) + x_data(i)^(num);  // sum_{i=1}^{k}xi^num
        end
        num = num - 1;
    end
end

for n1 = 1:n+1
    num = n + 1 - n1;
    for i = 1:k
        Xy(n1) = Xy(n1) + x_data(i)^(num)*y_data(i);  // sum_{i=1}^{k}xi^num*yi
    end
end
// 行列 X'*X，X'*y の生成（ここまで）/////////////////////////////////////////

// 最小二乗法によるパラメータ決定と結果の表示（ここから）/////////////////////////
a = XX\Xy;  // 連立１次方程式を解く

for i = 0:n
  printf("a%d = %f\n",i,a(i+1));
end
// 最小二乗法によるパラメータ決定と結果の表示（ここまで）/////////////////////////

// グラフの描画のためのデータ生成（ここから）///////////////////////////////////
x = -4:0.25:3;
y = zeros(1,size(x,2)); // y の初期化

for num = 1:size(x,2)
  for i = 0:n
    y(num) = y(num) + a(i+1)*x(num)^(n-i);  // y = sum_{i=0}^{n}ai*x^(n-i)
  end
end
// グラフの描画のためのデータ生成（ここまで）///////////////////////////////////

// グラフの描画 ////////////////////////////////////////////////////////////
clf;                                      // グラフィックの消去
plot(x_data,y_data,'ro','linewidth',3,'markersize',12);
                  // データの描画（色：赤，印：○，線の太さ：3，印の大きさ：12）
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
graph.data_bounds = [-4 -8; 3 8];   // [xmin ymin; xmax ymax]
//////////////////////////////////////////////////////////////////////////
