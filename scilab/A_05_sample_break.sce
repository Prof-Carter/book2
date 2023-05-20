printf("k = ?\n");
k = scanf("%f");
  
for i = 0:0.1:1
  printf("i = %f\n", i); 
  if i > k
    printf("break point: k = %f\n", k); 
    break;     
  end
end
