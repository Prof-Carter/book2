for i = -1:0.5:1
  if i < 0
    printf("i = %f : negative\n", i);
  elseif i > 0
    printf("i = %f : positive\n", i);
  else
    printf("i = %f : zero\n", i);  
  end
end
