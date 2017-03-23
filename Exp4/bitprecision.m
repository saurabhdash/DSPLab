function a_dash = bitprecision(m,n,N,a)
d2b=zeros(floor(N),floor(m+n));

for i=1:N
    d2b(i,:) = fix(rem(a(i)*pow2(-(n-1):m),2));     %de2bi with precision of n,m bits in integral and fractional parts
end

a_dash = d2b*pow2(n-1:-1:-m).';
a_dash = a_dash';
end