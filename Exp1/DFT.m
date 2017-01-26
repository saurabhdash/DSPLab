function DFT(L,Fs)

Fs = Fs * 1e3;            % Sampling frequency
T = 1/Fs;             % Sampling period
%L = 10000;             % Length of signal
t = (0:L-1)*T;        % Time vector
x = 10*cos(2*pi*1e3*t)+6*cos(2*pi*2*1e3*t)+2*cos(2*pi*4*1e3*t);
f = Fs *(0:L-1)/L;
y = circshift(abs(fft(x,L))/L,[0 L/2]);
figure;
plot(f- Fs/2 ,y);
xlabel('Frequency');
ylabel('|X(f)|');
ylabel('|X(f)|/N'); 
title(['DFT of signal with N = ' num2str(L) ', Fs = ' num2str(Fs/1000) 'kHz']);
end
