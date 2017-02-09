[x1,Fs1]=audioread('audio48kHz.wav');                                       % Reading sounds recorded at 48kHz
[x2,Fs2]=audioread('male_8kHz.wav');                                        % Reading voice recorded @ 8kHz

x2u = 6*upsample(x2,6);                                                     %upsampling by adding Zeros
x2u=x2u(1:size(x1,1));
A=fir1(48,1/6,'low');                                                       %LPF Coefficients
x2u_filt=filter(A,1,x2u);                                                   %filtering upsampled voice
y1=x1/3+x2u_filt;                                                           %Mixing sounds
x1d=downsample(x1,6);                                                       %Downsampling Music
x1d_filt=downsample(filter(A,1,x1),6);                                      %filtering Music @8kHz and then downsampling
y2=x1d_filt+x2(1:size(x1d_filt,1));                                         %Mixing sounds @8kHz

plotdft(x2,Fs2,'Audio@8kHz');
%sound(x2,Fs2)                                                               % Voice recording at 8kHz  

plotdft(x2u,Fs1,'Audio@48kHz without filter');
%sound(x2u,Fs1)                                                              %voice recording upsampled but not filtered

plotdft(x2u_filt,Fs1,'Audio@48kHz with filter');
%sound(x2,Fs2),sound(x2u_filt,Fs1)                                           %voice recording upsampled

plotdft(y1,Fs1,'Mixed voice and audio @48kHz');
%sound(y1,Fs1)                                                               %adding both sounds @ 48kHz

plotdft(x1d,Fs2,'Music downsampled');
%sound(x1d,Fs2)                                                              %music downsampled

plotdft(x1d_filt, Fs2, 'Music filtered @8kHz and then downsampled') 
%sound(x1d_filt,Fs2)                                                         %music filtered at 8kHz and then downsampled

plotdft(y2, Fs2, 'Mixed audio and music @8kHz') 
%sound(y2,Fs2)                                                               %music downsampled and added