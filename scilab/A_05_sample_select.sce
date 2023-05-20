for i = -1:0.5:1
  select sign(i)
    case -1
      printf("i = %f : negative\n", i);
    case 1
      printf("i = %f : positive\n", i);
    else
      printf("i = %f : zero\n", i);
    end
end
