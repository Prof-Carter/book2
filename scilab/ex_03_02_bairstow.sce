clear

// n, a_i (i = 1, ..., n) の入力
printf("n = ?\n"); n = scanf("%f");
printf("a(0) = ?\n"); a0 = scanf("%f");
for i = 1:n
  printf("a(%d) = ?\n", i); a(i) = scanf("%f");
end
printf("\n");

m = n;    // ステップ 1

e1 = 1e-5;   // ε1の設定
e2 = 1e-5;   // ε2の設定
kmax = 99;   // kmax（反復回数の最大値）の設定
flag = 0;

num = 1;

while m >= 1 & flag == 0
  // ステップ 2（ここから）
  if m == 1
    printf("(%f)x + (%f) = 0\n", a0, a(1));
    printf("  ====> x(%d) is solved.\n\n", num);
    x(num) = - a(i)/a0;
    break;
  end
  // ステップ 2（ここまで）
  
  // ステップ 3（ここから）
  if m == 2 
    printf("(%f)x^2 + (%f)x + (%f) = 0\n", a0, a(1), a(2));
    printf("  ====> x(%d) and x(%d) are solved.\n\n", num, num+1);
    x(num)     = (- a(1) + sqrt(a(1)^2 - 4*a0*a(2)) )/(2*a0);
    x(num + 1) = (- a(1) - sqrt(a(1)^2 - 4*a0*a(2)) )/(2*a0);
    break;
  end
  // ステップ 3（ここまで）
  
  // ステップ 4（ここから）
  if m >= 3   
    // ステップ 4-1（ここから）
    k = 1;
    
    // p1, q1 （p, q の反復の初期値）の入力
    printf("p(1) = ?\n"); p(1) = scanf("%f");
    printf("q(1) = ?\n"); q(1) = scanf("%f");
    printf("\n");
    // ステップ 4-1（ここまで）
  
    while flag == 0   
      // ステップ 4-2（ここから）
      // b_i (i = 0, ..., m) の計算
      b0   = a0;
      b(1) = a(1) - b0*p(k);
      b(2) = a(2) - (b(1)*p(k) + b0*q(k));
      for i = 3:m
        b(i) = a(i) - (b(i-1)*p(k) + b(i-2)*q(k));
      end
      
      // c_i (i = 0, ..., m-1) の計算
      c0   = - b0;
      c(1) = - (b(1) + c0*p(k));
      c(2) = - (b(2) + c(1)*p(k) + c0*q(k));
      if m >= 4
        for i = 3:m-1
          c(i) = - (b(i) + c(i-1)*p(k) + c(i-2)*q(k));
        end
      end
      
      // d_i (i = 0, ..., m-2) の計算
      d0   = - b0;
      d(1) = - (b(1) + d0*p(k));
      if m >= 4
        d(2) = - (b(2) + d(1)*p(k) + d0*q(k));
      end
      if m >= 5
        for i=3:m-2
          d(i) = - (b(i) + d(i-1)*p(k) + d(i-2)*q(k));
        end
      end
      // ステップ 4-2（ここまで）
 
      // ステップ 4-3（ここから）
      // p, q の計算
      if m == 3
        delta = c(1)*d(1) - c(2)*d0;

        if abs(delta) > e1
          p(k+1) = p(k) - (  d(1)*b(2) - d0*b(3))/delta;
          q(k+1) = q(k) - (- c(2)*b(2) + c(1)*b(3))/delta;
        else
          flag = 1;
          printf("\n ===> |delta| < %f\n", e1);
          break;
        end
      end

      if m >= 4
        delta = c(m-2)*d(m-2) - c(m-1)*d(m-3);

        if abs(delta) >= e1
          p(k+1) = p(k) - (  d(m-2)*b(m-1) - d(m-3)*b(m))/delta;
          q(k+1) = q(k) - (- c(m-1)*b(m-1) + c(m-2)*b(m))/delta;
        else
          flag = 1;
          printf("\n ===> |delta| < %f\n", e1);
          break;
        end
      end
      // ステップ 4-3（ここまで）
      
      // ステップ 4-4（ここから）
      // p, q の収束判定
      if abs(p(k+1) - p(k)) < e2 & abs(q(k+1) - q(k)) < e2        
        for i = 1:k+1
          printf("p(%d) = %f, q(%d) = %f\n", i, p(i), i, q(i));
        end
        
        b0   = a0;
        b(1) = a(1) - b0*p(k+1);
        b(2) = a(2) - (b(1)*p(k+1) + b0*q(k+1));
        for i = 3:m
          b(i) = a(i) - (b(i-1)*p(k+1) + b(i-2)*q(k+1));
        end
        
        printf("\n");
        printf("b(%d) = %f\n", 0, b0);
        for i = 1:m
          printf("b(%d) = %f\n", i, b(i));
        end
               
        printf("\n");
        printf("x^2 + (%f)x + (%f) = 0\n", p(k+1), q(k+1)); 
        printf("  ====> x(%d) and x(%d) are solved.\n\n", num, num+1);

        break;
      end
      // ステップ 4-4（ここまで）
      
      // ステップ 4-5（ここから）
      if k >= kmax
        printf("\n");
        printf("k >= kmax ===> Input another initial value.\n");
        flag = 1;
        break;
      end
      
      k = k + 1;
      // ステップ 4-5（ここまで）
    end
    
    // ステップ 4-6（ここから）
    if flag == 0
      x(num)     = (- p(k+1) + sqrt(p(k+1)^2 - 4*q(k+1)))/2;
      x(num + 1) = (- p(k+1) - sqrt(p(k+1)^2 - 4*q(k+1)))/2;
    end
    // ステップ 4-6（ここまで）

    // ステップ 4-7（ここから）
    // a_i <== b_i
    // m   <== m - 2
    a0 = b0;
    for i = 1:m-2
      a(i) = b(i);
    end
    m = m - 2;
    num = num + 2;
    // ステップ 4-7（ここまで）
  end
  // ステップ 4（ここまで）
end
  
// ベアストウ法で得られた解の表示
if flag == 0
  printf("\n");
  printf("solution (Bairstow method):\n");
  disp(x)
end
printf("\n\n");
