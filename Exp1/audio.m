[x1,Fs1]=audioread('audio48kHz.wav');
[x2,Fs2]=audioread('male_8kHz.wav');

x2u = 6*upsample(x2,6);
x2u=x2u(1:size(x1,1));
A=fir1(48,1/6,'low');
x2u_filt=filter(A,1,x2u);
y1=x1+x2u_filt;

x1d=downsample(x1,6);
x1d_filt=downsample(filter(A,1,x1),6);
y2=x1d_filt+x2(1:size(x1d_filt,1));
%statement 1. sound(x2,Fs2)
%statement 2. sound(x2u,Fs1)
%statement 3. sound(x2,Fs2),sound(x2u_filt,Fs1)
%statement 4. sound(y1,Fs1)
%statement 5. sound(x1d,Fs2)
%statement 6. sound(x1d_filt,Fs2)
%statement 7. sound(y2,Fs2)