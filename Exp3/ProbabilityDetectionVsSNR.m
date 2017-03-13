arr=[4 5 6 7 8 9 10 12 14 15 17 20];
Pd=zeros(1,length(arr));

for k=1:length(arr)
SNR=arr(k);
for test=1:1000                    %compute statistical probability for given SNR
    Experiment3;
    if(~any(keys-sequence))
        Pd(k)=Pd(k)+1/1000;
    end
end
end

plot(arr,Pd);
xlim=[4 20];
title('Probability of Detection vs. SNR for AWGN in DTMF');
xlabel('SNR(dB)');
ylabel('P_d');