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
%% 2.FIR-LS
%{
h1=fir1(120,[0.2 0.3],'bandpass',chebwin(121,15));
freqz(h1,1,10000);
%}
%% 4.Butterworth IIR
%{
[z,p,k] = butter(22,[0.2 0.3],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);
%}
%% 5.Chebyshev IIR
%[b,a] = cheby1(9,1,[0.2 0.3],'bandpass');
%freqz(b,a);
%% 6.Inverse Chebyshev IIR
%{
[z,p,k] = cheby2(7,30,[0.19 0.31],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);
%}
%% 7.Elliptic IIR
%{
[z,p,k] = ellip(5,1,30,[0.2 0.3],'bandpass');
sos = zp2sos(z,p,k);
fvtool(sos);
xlim([0.18 0.32]);
ylim([-45 5]);
%}