clear;
deff('[y] = f(x)', 'y = 1 - exp(-2*x).*cos(5*x)');
x = 0:0.05:5;
scf(1);
clf;
plot(x,f(x))
xlabel('x'); ylabel('y');
