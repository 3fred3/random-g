clear all
close all
clc

%Primeira 
[gaussian_audio, freq_sample_gaussian_audio] = audioread('C:\Users\Usuario\Desktop\eletrica\SINAIS 2\Trabalho_Transformada_de_Fourier\vrg.m4a');
%sound(gaussian_audio, freq_sample_gaussian_audio)

len_gaussian_audio = length(gaussian_audio);
time_sec_gaussian_audio = len_gaussian_audio/freq_sample_gaussian_audio;
fprintf('Taxa de amostragem do sinal %d; Total de amostras %d; DuranÃ§Ã£o em s: %d \n',freq_sample_gaussian_audio, len_gaussian_audio, time_sec_gaussian_audio);
time_sec_vector = linspace(0, time_sec_gaussian_audio,len_gaussian_audio);
plot(time_sec_vector, gaussian_audio, color = 'blue')
title('Sinal Gaussiano (Com Ruído)', 'FontSize', 18);
ylabel('Sinal', 'FontSize', 16);
xlabel('Tempo (s)', 'FontSize', 16);

fft_gaussian_audio = fft(gaussian_audio);
freq_axis = [0:len_gaussian_audio-1]/time_sec_gaussian_audio;
figure;
plot(freq_axis, abs(fft_gaussian_audio), color = 'red');
title('Espectro de Frequências do Sinal Gaussiano', 'FontSize', 18);
ylabel('Amplitude de X(e^(jw))', 'FontSize', 16);
xlabel('Frequências (Hz)', 'FontSize', 16);

order_mv_av = 20;
num = ones(1,order_mv_av);
filtered_gaussian_audio = filter(num, 1, gaussian_audio)/order_mv_av;
figure;
plot(time_sec_vector, filtered_gaussian_audio);
title('Audio filtrado', 'FontSize', 18)
ylabel('Sinal Filtrado', 'FontSize',16)
xlabel('Tempo (s)', 'FontSize', 16)

fft_filtered_gaussian = fft(filtered_gaussian_audio);
figure;
plot(freq_axis, abs(fft_filtered_gaussian),color = 'green');
title('Espectro de Frequências do Audio Filtrado', 'FontSize', 18);
ylabel('Amplitude de Y(e^(jw))', 'FontSize', 16);
xlabel('Frequências (Hz)', 'FontSize', 16);

audiowrite('C:\Users\Usuario\Desktop\Transformada_de_Fourier\vrg_fil.m4a',filtered_gaussian_audio, freq_sample_gaussian_audio);

%sound(filtered_gaussian_audio, freq_sample_gaussian_audio);

%Segunda 
[high_freq_audio, sample_rate_high_freq] = audioread('C:\Users\Usuario\Desktop\eletrica\SINAIS 2\Trabalho_Transformada_de_Fourier\vraf.m4a');
len_high_freq_audio = length(high_freq_audio);
time_sec_high_freq_audio = len_high_freq_audio/sample_rate_high_freq;
fprintf('Taxa de Amostragem HF: %d; Total de Amostras: %d; Duração em segundos: %f',sample_rate_high_freq,len_high_freq_audio,time_sec_high_freq_audio);

%sound(high_freq_audio, sample_rate_high_freq);
time_vec = linspace(0, time_sec_high_freq_audio, len_high_freq_audio); 
figure;
plot(time_vec, high_freq_audio);
title('Sinal com Ruído de Alta frequÃªncia', 'FontSize', 18);
ylabel('Sinal', 'FontSize', 16);
xlabel('Tempo [s]', 'FontSize', 16);

fft_high_freq_audio = fft(high_freq_audio);
freq_axis_high_freq = [0:len_high_freq_audio-1]/time_sec_high_freq_audio;
figure;
plot(freq_axis_high_freq,abs(fft_high_freq_audio), color = 'red');
title('Transforamda Sinal Ruído Alta Frequência', 'FontSize', 18);
ylabel('Amplitude do Espectro X(e^(jw))', 'FontSize', 16);
xlabel('Frequencias [Hz]');


order_reject_band = 10;
half_freq = sample_rate_high_freq/2;
cutoff_freq = 7000;
Wn = cutoff_freq/half_freq; %frequencia normalizada
[b,a] = butter(order_reject_band, Wn);
butter_filter = tf(b,a);
figure;
bode(butter_filter);

figure;
filtered_high_freq_audio = filter(b,a, high_freq_audio);
plot(time_vec, filtered_high_freq_audio);
title('Sinal Filtrado', 'FontSize', 18);
ylabel('Sinal Normalizado', 'FontSize', 16);
xlabel('Tempo [s]', 'FontSize', 16);

figure;
fft_filtered_high_freq_audio = fft(filtered_high_freq_audio);
plot(freq_axis_high_freq, abs(fft_filtered_high_freq_audio), color = 'green');
title('Espectro de FrequÃªncias do Sinal filtrado', 'FontSize', 18);
ylabel('Y(e^(jw)', 'FontSize', 16);
xlabel('Frequencias [Hz]', 'FontSize', 16);

audiowrite('C:\Users\Usuario\Desktop\Transformada_de_Fourier\vraf_fil.m4a',filtered_high_freq_audio, sample_rate_high_freq);


%sound(filtered_high_freq_audio, sample_rate_high_freq);


