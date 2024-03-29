clear;

e1 = 1e-5;   // ε1の設定
e2 = 1e-5;   // ε2の設定
kmax = 99;   // kmax（反復回数の最大値）の設定
flag = 0;

deff('[y]  = f(x)' ,'y  = (1)./(1 + exp(-x)) - 1/3');   // y = f(x) の定義
deff('[dy] = df(x)','dy = exp(-x)./(1 + exp(-x)).^2');  // y' = f'(x) の定義

k = 1;      // ステップ 1
printf("x(1) = ?\n"); x(1) = scanf("%f");       // 反復の初期値 x1 の入力
printf("\n")
printf("x(1) = %f \n", x(1));

while flag == 0   
  if abs(df(x(k))) > e1             // ステップ 2：条件①
    x(k+1) = x(k) - f(x(k))/df(x(k));
    printf("x(%d) = %f \n", k+1, x(k+1));
  else
    flag = 1;
    break;
  end
  
  if abs(f(x(k+1))) < e2            // ステップ 3：条件②（収束条件）
    break;
  end

  if k >= 2 & abs(x(k+1)-x(k)) > abs(x(k)-x(k-1)) // ステップ 3：条件③
    flag = 2;
    break;
  end  
  
  if k >= kmax   // ステップ 4：条件④
    flag = 3;
    break;
  end
  
  k = k + 1;
end

if flag == 0
  printf("solution: x = %f\n", x(k+1));
else
  if flag == 1      // 条件①を満足しない（x軸と交わらない）
    printf("\n ===> |df(x(%d))/dx| < e1\n\n", k);
  elseif flag == 2  // 条件③を満足しない（発散）
    printf("\n ===> |x(%d)-x(%d)| > |x(%d)-x(%d)|\n\n", k+1, k, k, k-1); 
  elseif flag == 3  // 条件④を満足（反復回数が制限を越えている）
    printf("\n ===> k >= kmax\n\n"); 
  end
  printf("Input another initial value."); 
end

// グラフの描画 ////////////////////////////////////////////////////////////
x_data = -6:0.05:6;                       // 1 から 6 まで0.05 刻みのデータ
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
graph.data_bounds = [-6 -0.5; 6 1]; // [xmin ymin; xmax ymax]
//////////////////////////////////////////////////////////////////////////

if flag <> 1    // flag = 1 以外
  // 点 Pi における接線を赤色破線でプロット
  for i=1:k
    plot([x(i)   x(i+1)],[f(x(i)) 0],         'r--', 'linewidth',3);
    plot([x(i+1) x(i+1)],[0       f(x(i+1))], 'r--', 'linewidth',3);
  end

  // 点 Pi を緑色○印でプロット（線の太さ：3，サイズ：10）
  for i=1:k+1
    plot(x(i), f(x(i)), 'go', 'linewidth',3,'markersize',10);
  end
end
