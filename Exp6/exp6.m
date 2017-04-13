close all;
clear all;
clc;

w0 = 0.05*pi;
a = 0.6;
N = 500;
p = 15;

% generate x[n] = s[n] + w[n]
s = zeros(1, N);
for n = 1:1:N
    if (mod(n, 5) == 1)
        phi = (rand-0.5)*2*pi;
    end
    s(n) = sin(w0*n + phi);
end
w = sqrt(1).*randn(1, 10*N);
w = w(1:N);
x = s + w;

figure;
stem(1:1:N, x);
title('Noisy Signal x[n]');

figure;
stem(1:1:N, s);
title('Original Signal s[n]');

% generate v[n]
v = zeros(1, N);
v(1) = w(1);
for n = 2:1:N
    v(n) = a*v(n-1) + w(n);
end

figure;
stem(1:1:N, v);
title('Noise v[n]');


% estimate 1 - subtract v[n] from x[n]
s_est1 = x - v;
figure;
subplot(2,1,1);
stem(1:1:N, s);
title('Original Signal s[n]');
subplot(2,1,2);
stem(1:1:N, s_est1);
title('Naive Estimated Signal s1[n]');

figure;
plot(1:1:N, s);
hold on;
plot(1:1:N, s_est1, 'r');
title('Naive Estimation');

err1 = rms(s_est1 - s);

% autocorrelation of v
r_vv = crosscorr(v, v, p-1);
start = ceil(length(r_vv)/2) + 1;
R_v = zeros(p, p);
for i = 1:1:p
    R_v(i,:) = r_vv(start-i:start-i+p-1);
end

% cross correlation of v and w
r_vw = crosscorr(w, v, p-1);
r_vw = r_vw(p:2*p-1)';

% wiener filter
w_opt = pinv(R_v)*r_vw;
w_opt = w_opt';

s_est2 = zeros(1, N);
for n = 1:1:N
    v_n = zeros(1, p);
    for i = 1:1:p
        if(n-i+1 <= 0)
            v_n(i) = 0;
        else
            v_n(i) = v(n-i+1);
        end
    end
    s_est2(n) = x(n) - w_opt*v_n';
end

figure;
subplot(2,1,1);
stem(1:1:N, s);
title('Original Signal s[n]');
subplot(2,1,2);
stem(1:1:N, s_est2);
title('Weiner Estimated Signal s1[n]');

figure;
plot(1:1:N, s);
hold on;
plot(1:1:N, s_est2, 'r');
title('Optimal Wiener Estimation');

err2 = rms(s_est2 - s);
display(['Error with Naive estimation: ', num2str(err1)]);
display(['Error with Optimal Wiener estimation: ', num2str(err2)]);