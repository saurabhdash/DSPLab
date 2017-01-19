function DFT(L,Fs)                                                         %L = Length of signal
Fs = Fs * 1e3;                                                             %Sampling frequency
T = 1/Fs;                                                                  %Sampling period
t = (0:L-1)*T;                                                             % Time vector
x = 10*cos(2*pi*1e3*t)+6*cos(2*pi*2*1e3*t)+2*cos(2*pi*4*1e3*t);            % Signal Generated
f = Fs *(0:L-1)/L;                                                         % frequency array                                                
y = circshift(abs(fft(x,L))/L,[0 L/2]);                                    % DFT of the Signal using the FFT algorithm                                      
figure;                                                                    % New figure for plotting
plot(f- Fs/2 ,y);                                                          % DFT Plotted                                          
xlabel('Frequency');                                                       % X label
ylabel('|X(f)|/N');                                                        % Y label
title(['DFT of signal with N = ' num2str(L) ', Fs = ' num2str(Fs/1000) 'kHz']); %Title
end
