%this script test the representation of fft complex number representation
%when the input signal is padded with various samples 
%the parameter "padedSamples" will be used in a for loop, to add a sample 
%per iteration in the displaying figures%
close all; clear;

%sine initial values
amp     = 0.5;
freq    = 947.1375;
fs      = 44100;
time    = 1; 
t       = (0 : 1/fs : time - 1/fs);
fftSize = 1024;

%create sine
x = amp * sin(2 * pi * t * freq);

%represent the time domain signal
figure (1),
plot (t, x)
axis([0 freq/fs -1 1 ])

%make fft
fftX = fft(x, fftSize);
halfFFT = fftX(1, 1: fftSize/2);

nVal  = (0 : fs/(fftSize) : (fs/2 - fs/fftSize) );
figure( 2 ), 
subplot(2, 1, 1), plot(nVal, real(halfFFT) ),
axis([0, fs/2, -10, 10]),
title('FFT'),
xlabel(' Frequency (Hz) '), ylabel('Amplitude (real numbers)'),
subplot(2,1,2), plot( nVal, imag(halfFFT) ),
axis([0, fs/2, -pi, pi])
title(' phase of input signal '), xlabel( 'Frequency (Hz)' ), ylabel( 'Degree' ),

%The loop will pad the signal with different values and the output will be
%displayed, in order to see how the real and imag part of FFT change.
padedSamples = 10; %ATTN! Changing this number affects the loop iteration time and padding to the signal
figureNumber = 4;
for i = 1:padedSamples
    padX = zeros(1,i);
    padedSig = [padX x];
    delayedSig = padedSig(1: length(padedSig)- length(padX) );

    figure (figureNumber),
    plot ( t, delayedSig)
    axis([0 freq/fs -1 1 ])

    delayedSigFFT     = fft( delayedSig, fftSize);
    halfDelayedSigFFT = delayedSigFFT(1, 1:fftSize/2);
    nVal              = (0 : fs/(fftSize) : (fs/2 - fs/fftSize) );

    figure( figureNumber ), 
    subplot(2, 1, 1), plot(nVal, real(halfDelayedSigFFT) ),
    axis([0, fs/2, -256, 256]),
    title('FFT'),
    xlabel(' Frequency (Hz) '), ylabel('Amplitude (real numbers)'),
    subplot(2,1,2), plot( nVal, imag(halfDelayedSigFFT) ),
    axis([0, fs/2, -pi, pi])
    title(' phase of input signal '), xlabel( 'Frequency (Hz)' ), ylabel( 'Degree' ),

    figureNumber = figureNumber + 1;
end
