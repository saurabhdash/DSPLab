clear;
clc;
close all;
%%
a = -10/(9*1i) + 0.98*exp(1i*pi/6)/1i;
b = 10/(9*1i) - 0.98*exp(-1i*pi/6)/1i;
n = 0:1:100;
x = a*power(0.9*exp(1i*pi/6),n)+b*power(0.9*exp(-1i*pi/6),n);
stem(n,x);
c0 = cceps(x);
%figure;
%stem(0:1:100,c0)
%%
h = zeros(1,101);
h(1) = 1;
h(16) = 0.9;
h(31) = 0.81;
%%
y = conv(x,h);
figure;
stem(0:1:200,y)
%%
c = cceps(y);
figure;
stem(0:1:200,c)
%%
%{
c1 = c;
for i = 1:200
if (mod(i,15) == 0)
    c1(1,i+1) = (c1(1,i) + c1(1,i+2))/2;
end
end
%}
%%

c1 = zeros(1,201);
c1(1:15) = c(1:15);

%%
%figure;
hold on;
stem(0:1:200,c1);
stem(0:1:100,c0,'p');
x1 = icceps(c1);

%{
for i = 10:1:100
c1(1:i) = c(1:i);
x1 = icceps(c1);
err(i-9) = sqrt(sum(abs(x-x1)));
end
%}
%plot(10:1:100,err);

figure;
stem(0:1:100,x1(1:101)); 
hold on; 
stem(0:1:100, x);
