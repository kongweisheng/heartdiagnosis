
%            ���岻�䷨�任
%                  ��ʵ��
%
subplot(1,1,1); clg
c = [1,1]; d = [1,5,6]; T = 0.1; Fs = 1/T;
[b,a] = imp_invr(c,d,T)
%%b =  1.0000   -0.8966
%%a =  1.0000   -1.5595    0.6065
% ģ���˲�����������Ӧ
t = [0:0.01:3]; subplot(2,1,1); impz(c,d,t); 
axis([0,3,-0.1,1]);hold on
% I�����˲�����������Ӧ
n = [0:1:3/T]; hn = filter(b,a,impseq(0,0,3/T));
stem(n*T,hn); text(3.05,-.1,'ʱ��(��)'); title ('������Ӧ');
xlabel('');ylabel('����');hold off;
% �����˲����ķ�����Ӧ
[db,magd,pha,grd,wd] = freqz_m(b,a);
% ģ���˲����ķ�����Ӧ
[db,mags,pha,ws] = freqs_m(c,d,2*pi*Fs);
subplot(2,1,2); plot(ws/(2*pi),mags*Fs,wd/(2*pi)*Fs,magd)
xlabel('Ƶ��(Hz)'); title('������Ӧ');
ylabel('����'); 
text(1.4,.5,'ģ���˲���'); text(1.5,1.5,'�����˲���')
