%retrieving ECG signal 
ECG = audiorecorder(1000,16, 1); 
% 1000 sample rate, 16 bits, 1 channel
time = 10;
disp('Start ECG.')         
recordblocking(ECG, time);
disp('End');
% Store data in double-precision array.
myECG = getaudiodata(ECG);
% create x axis in 1/1000 interval
t = [0:1/1000:time-1/1000];
% Plot the waveform
subplot(3,1,1);
plot(t,myECG);
title('ECG signal from patient');
ylabel('Voltage (mV)');
xlabel('time (sec)');
grid ;
 
%%
save('mydata');
%%
%zero-phase digital filtering
d1 = designfilt('lowpassiir','FilterOrder',10, ...
    'HalfPowerFrequency',0.05,'DesignMethod','butter');
y = filtfilt(d1,myECG);
 
subplot(3,1,2)
plot(myECG)
hold on
plot(y,'LineWidth',3)
legend('original ECG','Zero-Phase Filtering')
title('ECG signal from patient');
ylabel('Voltage (mV)');
xlabel('time (sec)');
grid ;
%%
% moving average filter
avg=ones(1,7)/7;
filtECG=filter(avg,1,y);
subplot(3,1,3);
plot(myECG,'b');
hold on
plot(filtECG,'r','linewidth',3);
legend ('noisy signal', 'filtered signal');
title('ECG signal from patient');
ylabel('Voltage (mV)');
xlabel('time (sec)');
grid ;

