clear;
x = 0:0.05:5;
y = 1 - exp(-2*x).*cos(5*x);
scf(1);
clf;
plot(x,y);
xlabel('x'); ylabel('y');
