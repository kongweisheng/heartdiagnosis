
%            双线性变换
%                  巴特沃思低通滤波器设计
%
% 数字滤波器指标:
wp = 0.2*pi;                         % 数字通带频率(弧度)
ws = 0.3*pi;                         % 数字阻带频率(弧度)
Rp = 1;                              % 通带波动(dB)
As = 15;                             % 阻带衰减(dB) 

% 模拟原型指标的频率逆映射
T = 1; Fs = 1/T;                     % 置 T=1
OmegaP = (2/T)*tan(wp/2);            % 预修正原型通带频率
OmegaS = (2/T)*tan(ws/2);            % 预修正原型阻带频率
ep = sqrt(10^(Rp/10)-1);             % 通带波动参数
Ripple = sqrt(1/(1+ep*ep));          % 通带波动
Attn = 1/(10^(As/20));               % 阻带衰减

% 模拟巴特沃思原型滤波器计算:
[cs,ds] = afd_butt(OmegaP,OmegaS,Rp,As);
%%*** 巴特沃思滤波器阶次=  6

% 双线性变换:
[b,a] = bilinear(cs,ds,T);
[C,B,A] = dir2cas(b,a)
%%C = 5.7969e-004
%%B = 1.0000    2.0183    1.0186
%%    1.0000    1.9814    0.9817
%%    1.0000    2.0004    1.0000
%%A = 1.0000   -0.9459    0.2342
%%    1.0000   -1.0541    0.3753
%%    1.0000   -1.3143    0.7149

% Plotting
figure(1); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a);
subplot(2,2,1); plot(w/pi,mag); title('幅度响应')
xlabel(''); ylabel('|H|'); axis([0,1,0,1.1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0,Attn,Ripple,1]); grid
subplot(2,2,3); plot(w/pi,db); title('模值(dB)');
xlabel('频率：（单位：pi）'); ylabel('分贝'); axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-50,-15,-1,0]); grid
set(gca,'YTickLabelMode','manual','YTickLabels',['50';'15';' 1';' 0'])
subplot(2,2,2); plot(w/pi,pha/pi); title('相位响应')
xlabel(''); ylabel('单位:pi'); axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid
subplot(2,2,4); plot(w/pi,grd); title('群延迟')
xlabel('频率（单位：pi）'); ylabel('样本'); axis([0,1,0,10])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0:2:10]); grid

