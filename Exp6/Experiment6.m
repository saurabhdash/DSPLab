clear;
clc;
L = 500;
n = 0:L-1;
w0 = 0.05*pi;
s = sin(w0*n + -pi+ 2*pi*rand);
%plot(s);
w = random('norm', 0,1,1,500);
%plot(w);
v = zeros(1,500);
v(1) = 0;
a = 0.6;
for i=2:500
    v(i)=a*v(i-1)+w(i);
end
%plot(v);
%figure;
x = s + w;
plot(x);
%% Initial Faggotry
s1 = x - v;
%figure;
%plot(s1);
%% Ultimate gawdaap
N = 4;
r_xv = xcorr(x,v);
r_xv = r_xv(1:N);
r_x = xcorr(x);
r_x = r_x(1:N);
R_x = toeplitz(r_x,conj(r_x));
wien = r_xv/(R_x);
%s2 = conv(x,wien);
plot(x-s2(1:500));
%plot(s2)