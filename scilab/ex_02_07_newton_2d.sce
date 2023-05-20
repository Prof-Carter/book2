clear;

e1 = 1e-5;   // ε1の設定
e2 = 1e-5;   // ε2の設定
kmax = 99;   // kmax（反復回数の最大値）の設定
flag = 0;

deff('  [z] =   f(x,y)','  z = y - sin(x)');              // z = f(x,y) の定義 
deff('  [z] =   g(x,y)','  z = x.^2 + (y + 1).^2 - 2^2'); // z = g(x,y) の定義

deff(' [dz] =  fx(x,y)',' dz = - cos(x)');  // df(x,y)/dx = fx(x,y) の定義
deff(' [dz] =  gx(x,y)',' dz = 2*x');       // dg(x,y)/dx = gx(x,y) の定義

deff(' [dz] =  fy(x,y)',' dz = 1');         // df(x,y)/dy = fy(x,y) の定義
deff(' [dz] =  gy(x,y)',' dz = 2*(y + 1)'); // dg(x,y)/dy = gy(x,y) の定義

k = 1;      // ステップ 1
printf("x(1) = ?\n"); x(1) = scanf("%f");   // 反復の初期値 x1 の入力
printf("y(1) = ?\n"); y(1) = scanf("%f");   // 反復の初期値 y1 の入力
printf("\n")
printf("(x(1), y(1)) = (%f, %f)\n", x(1), y(1));

while flag == 0 
  delta = fx(x(k),y(k))*gy(x(k),y(k)) - fy(x(k),y(k))*gx(x(k),y(k));
  if abs(delta) > e1              // ステップ 2：条件①
    x(k+1) = x(k) - (  gy(x(k),y(k))*f(x(k),y(k)) - fy(x(k),y(k))*g(x(k),y(k)))/delta;
    y(k+1) = y(k) - (- gx(x(k),y(k))*f(x(k),y(k)) + fx(x(k),y(k))*g(x(k),y(k)))/delta;
    printf("(x(%d), y(%d)) = (%f, %f) \n", k+1, k+1, x(k+1), y(k+1));
  else
    flag = 1;
    break;
  end
  
  if abs(f(x(k+1),y(k+1))) < e2 & abs(g(x(k+1),y(k+1))) < e2  // ステップ 3：条件②
    break;                                                    // （収束条件）
  end
  
  if k >= kmax   // ステップ 4：条件③
    flag = 3;
    break;
  end
  
  k = k + 1;
end

if flag == 0
  printf("solution: (x, y) = (%f, %f)\n", x(k+1), y(k+1));
else  
  if flag == 1
    printf("\n ===> |delta| < e1\n\n", k); 
  elseif flag == 3
    printf("\n ===> k >= kmax\n\n"); 
  end
  printf("Input another initial value."); 
end

// グラフの描画 ////////////////////////////////////////////////////////////
deff('[y] = h(x)','y = sin(x)') // y = h(x)  <===  z = f(x,y)

x_data = -4:0.01:4;                       // -4 から 4 まで0.01 刻みのデータ
clf;                                      // グラフィックの消去
plot(x_data,h(x_data),'linewidth',3);     // y = h(x) の描画（線の太さ：3）

theta_data = 0:0.01:2*%pi;
plot(2*cos(theta_data),2*sin(theta_data)-1,'linewidth',3);   
                                          // g(x,y) = 0 の描画（線の太さ：3）

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
graph.data_bounds = [-4 -4; 4 2]; // [xmin ymin; xmax ymax]
//////////////////////////////////////////////////////////////////////////

if flag <> 1    // flag = 1 以外
  // 点 P(i) と P(i+1) を結ぶ直線を赤色破線でプロット
  for i=1:k
    plot([x(i) x(i+1)],[y(i) y(i+1)],'r--','linewidth',2);
  end

  // 点 P(i) を緑色○印でプロット（線の太さ：3，サイズ：10）
  for i=1:k+1
    plot(x(i),y(i),'go','linewidth',3,'markersize',10);
  end
end
