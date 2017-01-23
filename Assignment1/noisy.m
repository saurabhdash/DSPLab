function I_noisy = noisy(I,a,b)
noise=round(40*rand(a,b)-20)/255;       %uniform noise of maximum +/- 30 grayscale units
I_noisy=I+noise;
%figure
%imshow(I_noisy);
end