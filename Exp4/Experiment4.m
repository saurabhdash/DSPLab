%{
Digital BPF:
Max passband ripple: 1dB            Min stopband attenuation: 30dB
Lower passband edge: 0.2pi          Lower stopband edge: 0.19pi
Upper passband edge: 0.3pi          Upper stopband edge: 0.31pi
1. FIR Window (Rectangular, Hanning)
2. FIR LS
3. FIR Park McClellan
4. IIR Butterworth
5. IIR Chebyshev
6. IIR Inverse Chebyshev
7. IIR Elliptic
%}
%% 1.a FIR-Rectangular window
N=512;
h1 = fir1(N, [0.199 0.301], 'bandpass', rectwin(N+1));
freqz(h1, 1, 10000);
%figure;
%h1_dash = bitprecision(10,1,N+1,h1);     %used for finite word length
%fvtool(h1,1,h1_dash,1);
%% 1.b.FIR-Hanning window
N=400;
h1 = fir1(N, [0.198 0.302], 'bandpass', hann(N+1));
figure;
freqz(h1,1,10000);
%% 2.FIR-LS
h1 = firls(155,[0 0.19 0.203 0.297 0.31 1],[0 0 1 1 0 0]);
figure;
freqz(h1,1,10000);
%% 3.FIR-Parks-McClellan
N=175;
h1=firpm(N,[0 0.19 0.205 0.295 0.31 1],[0 0 1 1 0 0]);
figure;
freqz(h1,1,10000);
%% 4.Butterworth IIR
[z,p,k] = butter(52,[0.2 0.3],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);
%% 5.Chebyshev IIR
[z,p,k] = cheby1(18,1,[0.2 0.3],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);
%% 6.Inverse Chebyshev IIR
[z,p,k] = cheby2(18,30,[0.19 0.31],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);
%% 7.Elliptic IIR
[z,p,k] = ellip(10,1,30,[0.2 0.3],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);