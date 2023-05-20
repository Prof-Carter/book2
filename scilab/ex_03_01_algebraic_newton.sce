clear

e1 = 1e-5;   // ε1の設定
e2 = 1e-5;   // ε2の設定
kmax = 99;   // kmax（反復回数の最大値）の設定
flag = 0;

deff('[y] = f(x)', 'y = x.^4 + 0*x.^3 - 29*x.^2 - 90*x - 350'); // 代数方程式 f(x) = 0

// f(x) = f_re(a,b) + f_im(a,b)*i, x = a + b*i
deff('[z] = f_re(a,b)', 'z = a^4 + b^4 - 6*a^2*b^2 - 29*(a^2 - b^2) - 90*a - 350'); 
deff('[z] = f_im(a,b)', 'z = 4*a^3*b - 4*a*b^3 - 58*a*b - 90*b');

// f_re_a(a,b) = df_re(a,b)/da, f_im_a(a,b) = df_im(a,b)/da
deff('[dz] = f_re_a(a,b)', 'dz = 4*a^3 - 12*a*b^2 - 58*a - 90');
deff('[dz] = f_im_a(a,b)', 'dz = 12*a^2*b - 4*b^3 - 58*b');

// f_re_b(a,b) = df_re(a,b)/db, f_im_b(a,b) = df_im(a,b)/db
deff('[dz] = f_re_b(a,b)', 'dz = 4*b^3 - 12*a^2*b + 58*b');
deff('[dz] = f_im_b(a,b)', 'dz = 4*a^3 - 12*a*b^2 - 58*a - 90');

k = 1;      // ステップ 1
printf("a(1) = ?\n"); a(1) = scanf("%f");   // 解 x の実数部αの初期値の入力
printf("b(1) = ?\n"); b(1) = scanf("%f");   // 解 x の虚数部βの初期値の入力
printf("\n")
printf("(a(1), b(1)) = (%f, %f)\n", a(1), b(1));

while flag == 0  
  delta = f_re_a(a(k),b(k))*f_im_b(a(k),b(k)) - f_re_b(a(k),b(k))*f_im_a(a(k),b(k));
  if abs(delta) > e1                // ステップ 2
    a(k+1) = a(k) - (  f_im_b(a(k),b(k))*f_re(a(k),b(k)) ...
                     - f_re_b(a(k),b(k))*f_im(a(k),b(k)))/delta;
    b(k+1) = b(k) - (- f_im_a(a(k),b(k))*f_re(a(k),b(k)) ...
                     + f_re_a(a(k),b(k))*f_im(a(k),b(k)))/delta;
    printf("(a(%d), b(%d)) = (%f, %f)\n", k+1, k+1, a(k+1), b(k+1));
  else
    flag = 1;
    break;
  end
  
  if abs(f_re(a(k+1),b(k+1))) < e2 & ...
     abs(f_im(a(k+1),b(k+1))) < e2  // ステップ 3
    break;
  end
  
  if k >= kmax   // ステップ 4
    flag = 3;
    break;
  end

  k = k + 1;
end

if flag == 0
  if b(k+1) > 0
    printf("solution: x = %f + %f i\n", a(k+1), abs(b(k+1)));
  elseif b(k+1) == 0
    printf("solution: x = %f       \n", a(k+1));  
  elseif b(k+1) < 0
    printf("solution: x = %f - %f i\n", a(k+1), abs(b(k+1)));
  end
else  
  if flag == 1
    printf("\n ===> |delta| < e1\n\n", k); 
  elseif flag == 3
    printf("\n ===> k >= kmax\n\n");  
  end
  printf("Input another initial value.");
end

// グラフの描画 ////////////////////////////////////////////////////////////
x_data = -8:0.05:10;                      // -8 から 10 まで 0.05 刻みのデータ
clf;                                      // グラフィックの消去
plot(x_data,f([x_data]),'linewidth',3);   // y = f(x) の描画（線の太さ：3）
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
