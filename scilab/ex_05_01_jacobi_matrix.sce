clear

// ステップ 1：連立 1 次方程式の係数の入力 //////////////////////
printf("n = ?\n"); n = scanf("%d");   // 行列のサイズの入力
printf("\n")

A = input("Input A ");       // A の入力
b = input("Input b ");       // b の入力
x = input("Input x^(0) ");   // x^(0) の入力

k       = 0;
epsilon = 1e-5;
flag    = 1;
kmax    = 99;

printf("k = %d", k);
for i = 1:n
  printf(", x%d = %f", i, x(i));
end
printf("\n");

x_old   = x;
  
// D, E の計算 //////////////////////////////////////////////
D = zeros(n,n);
for i = 1:n
  D(i,i) = A(i,i);
end
E = A - D;

while flag == 1
  // ステップ 2（ここから）//////////////////////
  x = inv(D)*(b - E*x_old);
  
  printf("k = %d", k+1);
  for i = 1:n
    printf(", x%d = %f", i, x(i));
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
  
  x_old = x;
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
