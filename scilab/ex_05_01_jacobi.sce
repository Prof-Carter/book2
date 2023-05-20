clear

// ステップ 1：連立 1 次方程式の係数の入力 //////////////////////
printf("n = ?\n"); n = scanf("%d");   // 行列のサイズの入力
printf("\n")

a = input("Input A ");       // A の入力
b = input("Input b ");       // b の入力
x = input("Input x^(0) ");   // x^(0) の入力
  
k       = 0;
epsilon = 1e-5;
flag    = 1;
kmax    = 99;

printf("%d: ", k);
for i = 1:n
  printf("x%d = %f  ", i, x(i));
end
printf("\n");

for i = 1:n
  x_old(i) = x(i);
end

while flag == 1
  // ステップ 2（ここから）//////////////////////
  for i = 1:n
    x(i) = b(i)/a(i,i);
  end
  for i = 1:n
    for j = 1:n
      if i ~= j
        x(i) = x(i) - a(i,j)*x_old(j)/a(i,i);
      end
    end
  end
  
  printf("%d: ", k+1);
  for i = 1:n
    printf("x%d = %f  ", i, x(i));
  end
  printf("\n");
  // ステップ 2（ここまで）//////////////////////

  // ステップ 3（ここから）//////////////////////
  sum_e = 0;
  sum_x = 0;
  
  for i = 1:n
    sum_e = sum_e + abs(x(i) - x_old(i));
    sum_x = sum_x + abs(x(i));
  end
  
  if sum_e/sum_x < epsilon
    flag = 0;
  end

  for i = 1:n
    x_old(i) = x(i);
  end
  k = k + 1;
  // ステップ 3（ここまで）//////////////////////

  // ステップ 4（ここから）//////////////////////
  if k > kmax
    printf("\n")
    printf("There is no numerical solution.\n")
    break
  end
  // ステップ 4（ここまで）//////////////////////
end
