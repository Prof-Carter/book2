clear

a = -1;
b = 1;
deff('[dy] = f(t,y)', 'dy = a*y + b*sin(t)');

h = 0.8;    // 刻み幅
t0 = 0;     // t の初期値
y0 = 0.5;   // y の初期値
nmax = 9;   // n の最大値

// ホイン法の漸化式 /////////////////////////////////////////////////////////
for n=0:nmax
  if n == 0
    k1 = f(t0, y0);
    k2 = f(t0 + h, y0 + k1*h);
    y(1) = y0 + (k1 + k2)*h/2;
  else
    t(n) = n*h;
    k1 = f(t(n), y(n));
    k2 = f(t(n) + h, y(n) + k1*h);
    y(n+1) = y(n) + (k1 + k2)*h/2;
  end
end

t(n+1) = (n+1)*h;

// 厳密解の算出 ///////////////////////////////////////////////////////////
deff('[y] = int_f(t)', ...
     'y = exp(a*t)*y0 - (b/(a^2 + 1))*(a*sin(t) + cos(t) - exp(a*t))');

// 結果の表示 /////////////////////////////////////////////////////////////
printf("\n");
printf("time \t\t Heun method \t\t exact solution \t error\n");
printf("t0 = %.1f\t y0 = %e\t y(t0) = %e\t |e(t0)| = %e\n", ...
          t0, y0, int_f(t0), abs(y0 - int_f(t0)));
for n=1:nmax+1
    printf("t%d = %.1f\t y%d = %e\t y(t%d) = %e\t |e(t%d)| = %e\n", ...
          n, t(n), n, y(n), n, int_f(t(n)), n, abs(y(n) - int_f(t(n))));
end

// グラフの描画 ////////////////////////////////////////////////////////////
clf
plot([t0;t],[y0;y],'bo-','linewidth',3,'markersize',12);
xgrid;                          // グリッドラインの追加
xlabel('t');                    // 横軸のラベル
ylabel('y');                    // 縦軸のラベル

graph = gca();                  // 軸のハンドル（個々を認識する番号）を取得
graph.font_style = 2;           // 目盛りのフォント（2: times）
graph.font_size  = 4;           // 目盛りのフォントサイズ（0〜6まで設定可能）
graph.x_label.font_style = 3;   // 横軸のラベルのフォント（3: times italic）
graph.x_label.font_size  = 5;   // 横軸のラベルのフォントサイズ（0〜6まで設定可能）
graph.y_label.font_style = 3;   // 縦軸のラベルのフォント（3: times italic）
graph.y_label.font_size  = 5;   // 縦軸のラベルのフォントサイズ（0〜6まで設定可能）
graph.data_bounds = [0 -1; 8 1]; // [xmin ymin; xmax ymax]

tt = 0:0.01:8;
yy = int_f(tt);
plot(tt,yy,'r--','linewidth',3);
