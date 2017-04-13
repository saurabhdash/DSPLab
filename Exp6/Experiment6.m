clear;
clc;
%%
N = 500;
n = 0:N-1;
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
p = 15;
r_xv = crosscorr(x, v, p-1);
r_xv = r_xv(p:2*p-1)';
r_v = crosscorr(v, v, p-1);
r_v(1:ceil(length(r_v)/2) - 1)=[];
R_v = toeplitz(r_v,conj(r_v));
wien = R_v\r_xv;

s2=zeros(1,N);
v_n = fliplr(v);
for i=1:N-p+1
    s2(N-i+1) = x(N-i+1)-v_n(i:i+p-1)*wien;
end
plot(s2);