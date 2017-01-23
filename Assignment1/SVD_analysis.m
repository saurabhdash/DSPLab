function error=SVD_analysis(I,noise_toggle)          %use imread('image.jpg') to get I
I=rgb2gray(I);
[a,b]=size(I);
error=zeros(1,min(a,b));

%{
subplot(2,1,1);         %To see grayscale distribution of image
surf(I)
subplot(2,1,2);
imshow(I)
%}

I=im2double(I);              %Note: im2double gives <cell-value>/255
%imshow(I);
I1=I;
if(noise_toggle)
    I1=noisy(I,a,b);
end

[u,s,v]=svd(I1);

for eigen=1:1:min(a,b)
    s_compressed=s(1:eigen,1:eigen);
    I_reconstruct=u(:,1:eigen)*s_compressed*v(:,1:eigen)';
    error(eigen)=sqrt(sumsqr(I-I_reconstruct))/sqrt(sumsqr(I))*100;
    
    if(eigen==37)%||eigen==40||eigen==80||eigen==148||eigen==200)
        %figure
        %imshow(I_reconstruct);
    end

end

%figure
plot(1:min(a,b),error);
xlabel('No. of SVD eigenvalues (N)');
ylabel('% error');
title('Compression of Image1');

end