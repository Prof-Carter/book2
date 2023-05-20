clear;
x = 0:0.05:5;
y = 1 - exp(-2*x).*cos(5*x);
scf(1);
clf;
plot(x,y,'r--','linewidth',3);
xlabel('x'); ylabel('y');
xgrid;

graph = gca();
graph.font_style = 2;
graph.font_size  = 4;
graph.x_label.font_style = 3;
graph.x_label.font_size  = 5;
graph.y_label.font_style = 3;
graph.y_label.font_size  = 5;
graph.data_bounds = [0 0; 3 1.5];
