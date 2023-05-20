// テイラー展開

clear

xk = %pi/4; 
n = 8;   // 次数

x = -10:0.01:10;

y = sin(xk);

for i = 1:n
  if modulo(i,4) == 1
     y = y + 1/factorial(i)*cos(xk)*(x - xk).^i;
  elseif modulo(i,4) == 2
     y = y - 1/factorial(i)*sin(xk)*(x - xk).^i;
  elseif modulo(i,4) == 3
     y = y - 1/factorial(i)*cos(xk)*(x - xk).^i;
  elseif modulo(i,4) == 0
     y = y + 1/factorial(i)*sin(xk)*(x - xk).^i;
  end
end

clf
plot(x,y,'b',x,sin(x),'r--','linewidth',3)
plot(xk,sin(xk),'go','markersize',12,'linewidth',3)

  g = gca();
  g.font_style = 2;
  g.font_size  = 4;
  g.x_label.font_style = 3;
  g.x_label.font_size  = 5;
  g.y_label.font_style = 3;
  g.y_label.font_size  = 5;
  g.data_bounds = [-10 -1.5; 10 1.5]; // [xmin ymin; xmax ymax]
