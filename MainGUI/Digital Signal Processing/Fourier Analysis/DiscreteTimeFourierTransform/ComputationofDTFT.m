% -----------------------------------------------------------------------------
% The Discrete-time Fourier transform (DTFT) 
%
% Reference: Digital Signal Processing: Principles, Algorithms and Applications 
%	     by John G.Proakis and Dimitris G.Manolakis
%
% (c) Author   : Sandeep Konam 
%     Portfolio: http://sandeepkonam.com
%     Email Id : sandeepkonam2020@gmail.com
% -----------------------------------------------------------------------------

n=input('Enter no.of samples');
for n=1:n 
    x(n)=input('Enter the samples'); 
end
c=1;
wk=0:0.1:13;
for w=0:0.1:13
     t=0;
     for i=1:n
         t=t+x(i)*cos(w*i); 
    end
    y(c)=t;
    c=c+1;
end 
c=1; 
for w=0:0.1:13 
    t=0;
    for i=1:n
         t=t+x(i)*sin(w*i);
     end
     z(c)=t;
     c=c+1;
end
for k=1:131
     mag(k)=sqrt((y(k)*y(k))+(z(k)*z(k)));
     angle(k)=-atan(z(k)/y(k)); 
     %disp(angle); 
     %disp(mag); 
end 

 plot(wk,mag); 

