clear

deff('[dy1] = f1(t,y1,y2)', 'dy1 = y2');
deff('[dy2] = f2(t,y1,y2)', 'dy2 = -10*y1-2*y2');

h   = 0.2;  // 刻み幅
t0  = 0;    // t の初期値
y10 = 1;    // y の初期値
y20 = 0;
nmax = 14;   // n の最大値

// 4次の古典的ルンゲ・クッタ法の漸化式 /////////////////////////////////////////
for n=0:nmax
  if n == 0
    k11 = f1(t0,       y10,           y20);
    k12 = f2(t0,       y10,           y20);    
    k21 = f1(t0 + h/2, y10 + k11*h/2, y20 + k12*h/2);
    k22 = f2(t0 + h/2, y10 + k11*h/2, y20 + k12*h/2);        
    k31 = f1(t0 + h/2, y10 + k21*h/2, y20 + k22*h/2);
    k32 = f2(t0 + h/2, y10 + k21*h/2, y20 + k22*h/2);    
    k41 = f1(t0 + h,   y10 + k31*h,   y20 + k32*h);
    k42 = f2(t0 + h,   y10 + k31*h,   y20 + k32*h);
    y1(1) = y10 + (k11 + 2*k21 + 2*k31 + k41)*h/6;
    y2(1) = y20 + (k12 + 2*k22 + 2*k32 + k42)*h/6;
  else
    t(n) = n*h;
    
    k11 = f1(t(n),       y1(n),           y2(n));
    k12 = f2(t(n),       y1(n),           y2(n));    
    k21 = f1(t(n) + h/2, y1(n) + k11*h/2, y2(n) + k12*h/2);
    k22 = f2(t(n) + h/2, y1(n) + k11*h/2, y2(n) + k12*h/2);        
    k31 = f1(t(n) + h/2, y1(n) + k21*h/2, y2(n) + k22*h/2);
    k32 = f2(t(n) + h/2, y1(n) + k21*h/2, y2(n) + k22*h/2);    
    k41 = f1(t(n) + h,   y1(n) + k31*h,   y2(n) + k32*h);
    k42 = f2(t(n) + h,   y1(n) + k31*h,   y2(n) + k32*h);    
    y1(n+1) = y1(n) + (k11 + 2*k21 + 2*k31 + k41)*h/6;
    y2(n+1) = y2(n) + (k12 + 2*k22 + 2*k32 + k42)*h/6;
  end
end

t(n+1) = (n+1)*h;

// 厳密解の算出 ///////////////////////////////////////////////////////////
deff('[y1] = int_f1(t)', 'y1 = (1/3)*exp(-t).*(sin(3*t) + 3*cos(3*t))');
deff('[y2] = int_f2(t)', 'y2 = -(10/3)*exp(-t).*sin(3*t)');

// 結果の表示 /////////////////////////////////////////////////////////////
printf("\n");
printf("time \t\t Runge-Kutta method \t exact solution \t error\n");
printf("t0 = %.1f\t y0 = %.3e\t y(t0) = %.3e\t |e(t0)| = %.3e\n", ...
          t0, y10, int_f1(t0), abs(y10 - int_f1(t0)));
for n=1:nmax+1
    printf("t%d = %.1f\t y%d = %.3e\t y(t%d) = %.3e\t |e(t%d)| = %.3e\n", ...
          n, t(n), n, y1(n), n, int_f1(t(n)), n, abs(y1(n) - int_f1(t(n))));
end

// グラフの描画 ////////////////////////////////////////////////////////////
for i=1:2
  scf(i);
  clf
  if i==1
    plot([t0;t],[y10;y1],'bo-','linewidth',3,'markersize',12);
    ylabel('y1 = y');             // 縦軸のラベル
    graph = gca();                // 軸のハンドル（個々を認識する番号）を取得
    graph.data_bounds = [0 -0.4; 3 1.2]; // [xmin ymin; xmax ymax]
  else
    plot([t0;t],[y20;y2],'bo-','linewidth',3,'markersize',12);
    ylabel('y2 = dy/dt');         // 縦軸のラベル
    graph = gca();                // 軸のハンドル（個々を認識する番号）を取得
    graph.data_bounds = [0 -2.5; 3 1]; // [xmin ymin; xmax ymax]
  end
  xgrid;                          // グリッドラインの追加
  xlabel('t');                    // 横軸のラベル

  graph.font_style = 2;           // 目盛りのフォント（2: times）
  graph.font_size  = 4;           // 目盛りのフォントサイズ（0〜6まで設定可能）
  graph.x_label.font_style = 3;   // 横軸のラベルのフォント（3: times italic）
  graph.x_label.font_size  = 5;   // 横軸のラベルのフォントサイズ（0〜6まで設定可能）
  graph.y_label.font_style = 3;   // 縦軸のラベルのフォント（3: times italic）
  graph.y_label.font_size  = 5;   // 縦軸のラベルのフォントサイズ（0〜6まで設定可能）
end

tt = 0:0.01:3;

yy1 = int_f1(tt);
scf(1);
plot(tt,yy1,'r--','linewidth',3);

yy2 = int_f2(tt);
scf(2);
plot(tt,yy2,'r--','linewidth',3);
