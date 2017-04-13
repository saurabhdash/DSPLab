clear;
clc;
%%
L = 500;
n = 0:L-1;
w0 = 0.05*pi;
s = sin(w0*n + -pi+ 2*pi*rand);
%plot(s);
w = random('norm', 0,1,1,500);
%plot(w);
v = zeros(1,500);
a = 0.6;
v(1)=w(1);
for i=2:500
    v(i)=a*v(i-1)+w(i);
end
%plot(v);
%figure;
x = s + w;
%plot(x);
%% Naive Noise Cancellation
s1 = x - v;         %subtract signals at primary and secondary signals
%figure;
%plot(s1);
%% Wiener filtering of secondary signal
p = 4;
r_xv = xcorr(x,v)';
r_xv = r_xv(1:p);
r_v = xcorr(v);
r_v = r_v(1:p);
R_v = toeplitz(r_v,conj(r_v));
wien = R_v\r_xv;
w_est = wien*v;
w_est = sum(w_est,1);
s2 = x - w_est;
plot(s2);