clear

k = 14;  // 与えられたデータ数
n = k - 1;

deff('[y] = f(x)', 'y = 1/(1 + x^2)');

x_data  = linspace(-5,5,k);

for  i=1:k
  y_data(i)  = f(x_data(i));
end

// グラフの描画 ////////////////////////////////////////////////////////////
clf;                                      // グラフィックの消去
subplot(1.5,1,1)
plot(x_data,y_data,'ko','linewidth',3,'markersize',12);
                  // データの描画（色：赤，印：○，線の太さ：3，印の大きさ：12）
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

for i = 1:n
  k = i + 1;
  h(i) = x_data(k) - x_data(k-1);
end

for i = 1:n-1
  k = i + 1;
  z(i) = 6*((y_data(k+1) - y_data(k))/h(i+1) - (y_data(k) - y_data(k-1))/h(i));
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

p = inv(A)*z;
ddy = [ 0
        p
        0 ];
        
printf("\n")
printf("////////////////////////////////////////\n")
printf("// cubic natural spline interpolation //\n")
printf("////////////////////////////////////////\n\n")
printf("ddy%d = %f\n"  , 1,   p(1));
printf("ddy%d = %f\n\n", n-1, p(n-1));

///////////////////////////////////////////////////
cnt = 0;

for x = x_data(1):0.1:x_data(n+1);
  cnt = cnt + 1;

  for i = 0:n-1
    k = i + 1;
    if x >= x_data(k) & x <= x_data(k+1)
      num = i + 1;
      break
    end
  end

  i = num;
  k = i + 1;

  y =   (1/6)*(x_data(k) - x).^3/h(i)*ddy(k-1) ...
      + (1/6)*(x - x_data(k-1)).^3/h(i)*ddy(k) ...
      + (1/h(i)*y_data(k-1) - h(i)/6*ddy(k-1))*(x_data(k) - x) ...
      + (1/h(i)*y_data(k)   - h(i)/6*ddy(k)  )*(x - x_data(k-1));

//  if modulo(x,0.5) == 0
//    printf("x = %f, y = %f\n", x, y);
//    plot(x,y,'bx','linewidth',3,'markersize',6);
//                    // 推定値の描画（色：青，印：×，線の太さ：3，印の大きさ：6）
//  end
                    
  xx(cnt) = x;
  yy(cnt) = y;
end

plot(xx,yy,'k','linewidth',3)

x_real = linspace(-6,6,200);
for i=1:200
  y_real(i)  = f(x_real(i));
end
plot(x_real,y_real,'k--','linewidth',3);
graph.data_bounds = [-6 -1.5; 6 1.5];   // [xmin ymin; xmax ymax]

