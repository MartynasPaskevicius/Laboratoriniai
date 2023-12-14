clear all
clc

%iejimas
x = 0.1:1/22:1;
%isejimas
f = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;

%pradinis grafikas
figure(1)
plot(x, f,"rx")

%random svoriai
w0 = randn(1);
w1 = randn(1);
w2 = randn(1);

%centru reiksmes
c1 = 0.19;
c2 = 0.89;
%spinduliu reiksmes
r1 = 0.18;
r2 = 0.17;

%mokymosi zingsnis
z = 0.1;

for k=1:1000
    for n=1:20
      %spindulio tipo funkcijos (Gauso)
      F1=exp(-((x(n)-c1)^2)/(2*(r1^2)));
      F2=exp(-((x(n)-c2)^2)/(2*(r2^2)));

      y(n) = F1*w1+F2*w2+w0;
      
      e = f(n)-y(n);

      w1 = w1 + z * e * F1;
      w2 = w2 + z * e * F2;
      w0 = w0 + z * e;
      
    end
end

%apmokymu grafikas
figure(2)
plot(x,y, "rx")

%patikrinimas
x2=0.1:0.005:1;


for i=1:length(x2)
      %spindulio tipo funkcijos (Gauso)
      F1_2=exp(-((x2(i)-c1)^2)/(2*(r1^2)));
      F2_2=exp(-((x2(i)-c2)^2)/(2*(r2^2)));

      y2(i) = F1_2*w1+F2_2*w2+w0;
end

%patikrinimo grafikas
figure(3)
plot(x2,y2, "rx")