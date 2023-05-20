clear;

deff('[y] = h(x)',   'y = sin(x)');   // f(x,y)=0 
deff('[z] = g(x,y)', 'z = x.^2 + (y + 1).^2 - 2^2');  //g(x,y) = 0

// グラフの描画 ////////////////////////////////////////////////////////////
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

printf("\n")
printf("Input xa and xb (xa < xb and g(xa,ya)*g(xb,yb) < 0).\n")
printf("xa = ?\n"); xa = scanf("%f")     // ステップ 1
printf("xb = ?\n"); xb = scanf("%f")
ya = h(xa);
yb = h(xb);

xc = (xa + xb)/2;  // ステップ 2
yc = h(xc);
e = 1e-5;          // εの設定

k = 1;

if xa > xb
  flag = 1;
elseif g(xa,ya)*g(xb,yb) > 0
  flag = 2;
else
  flag = 0;
end

// A(xa,ya), B(xb,yb) をo印で描画（色：赤，線の太さ：3，サイズ：10）
plot(xa,ya,'ro','linewidth',3,'markersize',10);
plot(xb,yb,'ro','linewidth',3,'markersize',10);

while flag == 0 & xb - xa > e             // ステップ 3 の収束条件
  printf("k = %3d, ", k); 
  printf("(xa, ya) = (%f, %f), ", xa, ya); 
  printf("(xb, yb) = (%f, %f)\n", xb, yb); 
  printf("\t "); 
  printf("(xc, yc) = (%f, %f), ", xc, yc); 
  printf("xb - xa = %f\n", xb-xa); 
  
  if g(xa,ya)*g(xc,yc) < 0  // ステップ 4
    xb = xc;
    yb = h(xb);
  else // g(xa,ya)*g(xc,yc) > 0
    xa = xc;
    ya = h(xa);
  end
  
  k = k + 1;
  xc = (xa + xb)/2;           // ステップ 2
  yc = h(xc);
end

if flag == 0
  printf("k = %3d, ", k);
  printf("(xa, ya) = (%f, %f), ", xa, ya);
  printf("(xb, yb) = (%f, %f)\n", xb, yb);
  printf("\t ");
  printf("(xc, yc) = (%f, %f), ", xc, yc);
  printf("xb - xa = %f\n\n", xb-xa); 
  printf("solution: (x, y) = (%f, %f)\n",xc,yc); 
elseif flag == 1
  printf("xa > xb !!\n");   
elseif flag == 2
  printf("g(xa,ya)*g(xb,yb) > 0!!\n");   
end
