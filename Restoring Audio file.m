clc; clear all; close all;

%% wav ���� �о �̻��ȣ�� ����
% wav ���� �а� ����ȣ ����
[x,f0]=audioread('Original.wav');                                             

%����ȣ�� �ð� ���� ����
T0=1/f0;
t=[0:T0:10];

%% �̻��ȣ�� ���ø�
%���ø� ���ļ�
fs= 7000;
Ts=1/fs;
sample_step=floor(Ts/T0);
n= 0:10/Ts;
for i1 = 1:length(n)-1
    t_s(i1)=t(i1*sample_step);
    x_s(i1)=x(i1*sample_step);
end

%% ���ø��� ��ȣ�� ����
y= zeros(1,length(t)); 
for i1=1:length(t_s)
    y=y+x_s(i1)*sinc((t-(i1-1)*Ts)/Ts);
end

%������ ��ȣ�� wav ���Ͽ� ����
audiowrite('Reconstruction_fs_7000.wav',y,f0);
sound(y,f0);

%% ��ȣ���� ���ļ� �������� Ȯ��
%���ø� ��ȣ�� �ٽ� ����
x_s2(1)=x(1);
t_s2(1)=t(1);
x_s2=zeros(1,length(x));
for i1=2:length(t)
    if (mod(i1,sample_step)==0)
        x_s2(i1)=x(i1);
    end 
end
t_s2=t;

%FFT
FT_x=fft(x); FT_x_s=fft(x_s2); FT_y=fft(y);
n1=length(x);
ff1=[0:n1-1]*(f0/n1);
n2=length(x_s2);
ff2=[0:n2-1]*(f0/n2);
n3=length(y);
ff3=[0:n3-1]*(f0/n3);
figure;
subplot(3,1,1); plot(ff1,10*log10(abs(FT_x))); grid on; legend('Original');xlim([0,20000]);ylim([0 40])
subplot(3,1,2); plot(ff2,10*log10(abs(FT_x_s))); grid on; legend('Sampling');xlim([0,20000]);ylim([0 40])
subplot(3,1,3); plot(ff3,10*log10(abs(FT_y))); grid on; legend('Reconstruction');xlim([0,20000]);ylim([0 40])


 














