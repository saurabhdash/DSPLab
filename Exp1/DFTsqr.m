function [T,y] = DFTsqr(L,Fs,displayplot)                                                  %L = Length of signal
Fs = Fs * 1e3;                                                             %Sampling frequency
T = 1/Fs;                                                                  %Sampling period
t = (0:L-1)*T;                                                             % Time vector
x = square(2*pi*1e3*t);                                                    % Signal Generated  
f = Fs *(0:L-1)/L;                                                         % frequency array                                                
y = circshift(abs(fft(x,L))/L,[0 L/2]);                                    % DFT of the Signal using the FFT algorithm     
if(strcmp(displayplot,'plot'))
figure;                                                                    % New figure for plotting
plot(f- Fs/2 ,y);                                                          % DFT Plotted                                          
xlabel('Frequency');                                                       % X label
ylabel('|X(f)|/N');                                                        % Y label
title(['DFT of  Square signal with N = ' num2str(L) ', Fs = ' num2str(Fs/1000) 'kHz']); %Title
end

y = fft(x,L);
end
