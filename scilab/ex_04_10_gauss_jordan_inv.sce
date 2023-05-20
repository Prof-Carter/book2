clear

// ステップ 1 ///////////////////////////////////////////////
printf("n = ?\n"); n = scanf("%d");   // 行列のサイズの入力
printf("\n")

for i = 1:n   // A の要素の入力
  for j = 1:n
    printf("a%d%d = ?\n",i,j); a(i,j) = scanf("%f");
    printf("\n");
  end
end

printf("\n");
printf("A = ");
disp(a);

for i = 1:n   // 単位行列の生成
  for j = 1:n
    if i == j
      c(i,j) = 1;
    else
      c(i,j) = 0;
    end
  end
end

// ステップ 2 ///////////////////////////////////////////////
for k = 1:n-1
  // ステップ 2-1 の計算：行交換による部分ピボット操作（ここから）//
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
    for j = 1:n
      c_temp(j)  = c(k,j);
      c(k,j)     = c(i_max,j);
      c(i_max,j) = c_temp(j);
    end
  end
  // ステップ 2-1 の計算（ここまで）////////////////////////////
  
  // ステップ 2-2 の計算（ここから）////////////////////////////
  for j = k+1:n
    a(k,j) = a(k,j)/a(k,k);
  end
  for j = 1:n
    c(k,j) = c(k,j)/a(k,k);
  end
  
  for i = 1:n
    if i ~= k
      for j = k+1:n
        a(i,j) = a(i,j) - a(k,j)*a(i,k);
      end
      for j = 1:n
        c(i,j) = c(i,j) - c(k,j)*a(i,k);
      end
    end
  end
  // ステップ 2-2 の計算（ここまで）////////////////////////////
end

// ステップ 3 ///////////////////////////////////////////////
for j = 1:n
  c(n,j) = c(n,j)/a(n,n);
end

for i = 1:n-1
  for j = 1:n
    c(i,j) = c(i,j) - c(n,j)*a(i,n);
  end
end

printf("\n");
printf("A^(-1) = ");  // 結果の表示（A^(-1) = c）
disp(c);
