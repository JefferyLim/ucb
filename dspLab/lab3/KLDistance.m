function [ d ] = KLDistance(coefficient1, coefficient2, gam)
% KLDistance calculates the KL Distance between two coefficient matrix

%calculate mean and covariance of both songs
mu0 = mean(coefficient1,2);
cov0 = cov(coefficient1');

mu1 = mean(coefficient2,2);
cov1 = cov(coefficient2');

icov0 = inv(cov0);
icov1 = inv(cov1);

%KL   =  1/2*(trace(icov1*cov0) + (mu1 - mu0)'*(icov1)*(mu1-mu0) - 12 + log(det(cov1/cov0)));
KL = 1/2*(trace(icov1*cov0 + icov0*cov1)) - 12 + 1/2*((mu1 - mu0)'*(icov1+icov0)*(mu1-mu0));
%KL = 0.5*(trace(cov0*icov1) + trace(cov1*icov0)) + 0.5*trace((icov0+icov1)*(mu0-mu1)*(mu0-mu1)') - 12;
d    = exp(-gam*(KL));
%d    = (1-exp(-gam/(KL + eps)));

%If the songs are exactly the same, d will go to -inf
%Remapping it to 1
if d == -inf
    d = 1;
end

end

