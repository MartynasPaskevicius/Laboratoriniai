clear all
clc

x=0.1:1/22:1;
y1=((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;
% plot(x,y1,'kx')

%1 sluoksnis
w11_1 = randn(1) ; b1_1 = rand (1);
w21_1 = randn(1) ; b2_1 = rand (1);
w31_1 = randn(1) ; b3_1 = rand (1);
w41_1 = randn(1) ; b4_1 = rand (1);

%Isejimo sluoksnis
w11_2 = randn(1) ; b1_2 = rand (1);
w12_2 = randn(1) ; 
w13_2 = randn(1) ; 
w14_2 = randn(1) ; 


zingsnis = 0.1;
for iter = 1:10000
    for n = 1:20
    %Pirmas sluoksnis
    v1_1 = x(n)*w11_1 + b1_1;
    v2_1 = x(n)*w21_1 + b2_1;
    v3_1 = x(n)*w31_1 + b3_1;
    v4_1 = x(n)*w41_1 + b4_1;
    %Aktyvacijos funkcijos taikymas 
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));

    %Pasleptas sluosnkis
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;
    
    %Isejimas
    y2 = v1_2;
    
    %Klaidos skaiciavimas
    e1= y1(n) - y2;
    
    %Klaidos gradiento skaiciavimas
    delta_out_1 = e1;
    %Pasleptame sluoksnyje
    delta1_1 = y1_1*(1-y1_1)*(delta_out_1*w11_2);
    delta2_1 = y2_1*(1-y2_1)*(delta_out_1*w12_2);
    delta3_1 = y3_1*(1-y3_1)*(delta_out_1*w13_2);
    delta4_1 = y4_1*(1-y4_1)*(delta_out_1*w14_2);
    
    %Svorių atnaujinimas
    %Isėjimo sluoksnis
    w11_2 = w11_2 + zingsnis*delta_out_1*y1_1;
    w12_2 = w12_2 + zingsnis*delta_out_1*y2_1;
    w13_2 = w13_2 + zingsnis*delta_out_1*y3_1;
    w14_2 = w14_2 + zingsnis*delta_out_1*y4_1;
    b1_2 = b1_2 + zingsnis*delta_out_1;
    
     %Paslėptasis sluoksnis
    w11_1 = w11_1 + zingsnis*delta1_1*x(n);
    w21_1 = w21_1 + zingsnis*delta2_1*x(n);
    w31_1 = w31_1 + zingsnis*delta3_1*x(n);
    w41_1 = w41_1 + zingsnis*delta4_1*x(n);
    b1_1 = b1_1 + zingsnis*delta1_1;
    b2_1 = b2_1 + zingsnis*delta2_1;
    b3_1 = b3_1 + zingsnis*delta3_1;
    b4_1 = b4_1 + zingsnis*delta4_1;
    
    end
end
x1=0.1:1/220:1;
    for m = 1:199
    
    v1_1 = x1(m)*w11_1 + b1_1;
    v2_1 = x1(m)*w21_1 + b2_1;
    v3_1 = x1(m)*w31_1 + b3_1;
    v4_1 = x1(m)*w41_1 + b4_1;
    
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;
    
    y2(m) = v1_2;
end
    figure,
    plot(x, y1, 'bx',x1,y2,'rx')
