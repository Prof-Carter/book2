clear

// ステップ 1：連立 1 次方程式の係数の入力 //////////////////////
printf("n = ?\n"); n = scanf("%d");   // 行列のサイズの入力
printf("\n")

for i = 1:n   // A の要素の入力
  for j = 1:n
    printf("a%d%d = ?\n",i,j); a(i,j) = scanf("%f");
    printf("\n");
  end
end

for i = 1:n   // b の要素の入力
  printf("b%d = ?\n",i); b(i) = scanf("%f");
  printf("\n");
end

// ステップ 2（前進消去）//////////////////////////////////////
for k = 1:n-1
  // 行交換による部分ピボット操作（ここから）/////
  a_max = a(k,k);   // ステップ i
  i_max = k;
  
  for i = k+1:n     // ステップ ii
    if abs(a(i,k)) > abs(a_max)
      a_max = a(i,k);
      i_max = i;
    end
  end
  
  if i_max ~= k     // ステップ iii
    for j = k:n
      a_temp(j)  = a(k,j);
      a(k,j)     = a(i_max,j);
      a(i_max,j) = a_temp(j);
    end
    
    b_temp = b(k);
    b(k) = b(i_max);
    b(i_max) = b_temp;
  end
  // 行交換による部分ピボット操作（ここまで）/////

  // 前進消去（ここから）//////////////////////
  for i = k+1:n
    for j = k+1:n
      a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
    end
    b(i) = b(i) - b(k)*a(i,k)/a(k,k);
  end
  // 前進消去（ここまで）//////////////////////
end

// ステップ 2（後進代入）//////////////////////////////////////
x(n) = b(n)/a(n,n);
printf("x%d = %f\n", n, x(n));

for i = n-1:-1:1
  x(i) = b(i)/a(i,i);
end
for i = n-1:-1:1
  for k = i+1:n
    x(i) = x(i) - a(i,k)*x(k)/a(i,i);
  end
  printf("x%d = %f\n", i, x(i));
end
