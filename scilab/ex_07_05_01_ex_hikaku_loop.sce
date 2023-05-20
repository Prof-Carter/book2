clear

deff('[y] = f(x)'     ,'y  = 1/x');
deff('[S] = int_f(x)' ,'S  = log(x)');

a  = 1;         // 積分区間の下限
b  = 5;         // 積分区間の上限

k = 0;

for nn = 2:1:15

  n = 2^nn;
  
  h  = (b - a)/n; // 分割幅
  xi = a:h:b;     // 分割データ（a から b まで等間隔 h のデータ）
  xi2 = a+h/2:h:b-h/2;

  for i=1:n+1
    yi(i) = f(xi(i));
  end
  for i=1:n
    yi2(i) = f(xi2(i));
  end

  S_left  = 0;
  S_right = 0;
  
  S_mid = 0;
  
  S_tr = 0;
  
  S_sim = 0;

  for i=1:n
    S_left  = S_left  + h*yi(i);      // 区分求積法（左端型）による数値積分
    S_right = S_right + h*yi(i+1);    // 区分求積法（右端型）による数値積分
    
    S_mid = S_mid + h*yi2(i);    // 中点公式による数値積分
    
    S_tr  = S_tr + (h/2)*(yi(i) + yi(i+1));   // 台形公式による数値積分
  end
  
  m = n/2;
  for i=1:m
   	k0 = (2*i - 2) + 1;
   	k1 = (2*i - 1) + 1;
   	k2 = (2*i - 0) + 1;
    S_sim = S_sim + (h/3)*(yi(k0) + 4*yi(k1) + yi(k2)); // シンプソン公式による数値積分
  end

  S = int_f([b]) - int_f([a]);  // 解析解

  k = k + 1;

  num(k) = n;
  e_left(k)  = S - S_left;
  e_right(k) = S - S_right;
  e_mid(k)   = S - S_mid;
  e_tr(k)    = S - S_tr;
  e_sim(k)   = S - S_sim;
  
  s_left(k)  = S_left;
  s_right(k) = S_right;
  s_mid(k)   = S_mid;
  s_tr(k)    = S_tr;
  s_sim(k)   = S_sim;

end


kmax = k;

printf("left\n")
for k=1:kmax
    printf("%9.6f\n",s_left(k))
end

printf("right\n")
for k=1:kmax
    printf("%9.6f\n",s_right(k))
end

printf("mid\n")
for k=1:kmax
    printf("%9.6f\n",s_mid(k))
end

printf("tr\n")
for k=1:kmax
    printf("%9.6f\n",s_tr(k))
end

printf("sim\n")
for k=1:kmax
    printf("%9.6f\n",s_sim(k))
end

scf(0);
clf

plot2d(num,abs(e_left) ,-5,logflag="ll")
plot2d(num,abs(e_right),-7,logflag="ll")
plot2d(num,abs(e_mid)  ,-1,logflag="ll")
plot2d(num,abs(e_tr)   ,-6,logflag="ll")
plot2d(num,abs(e_sim)  ,-8,logflag="ll")

plot2d(num,abs(e_left) , 2, logflag="ll")
plot2d(num,abs(e_right), 3, logflag="ll")
plot2d(num,abs(e_mid)  , 4, logflag="ll")
plot2d(num,abs(e_tr)   , 5, logflag="ll")

printf("\n\n");
printf("|e_left|   |e_right|  |e_mid|    |e_tr|     |e_sim|\n");
printf("------------------------------------------------------\n");
for k=1:kmax
    printf("%.3e %.3e %.3e %.3e %.3e \n",abs(e_left(k)),abs(e_right(k)),abs(e_mid(k)),abs(e_tr(k)),abs(e_sim(k)))
end
  
