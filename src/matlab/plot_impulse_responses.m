clear all;
close all;

impulse_response_path = '..\samples\impulse_responses\';
output_path_sim  = '..\samples\outputs\sim\';
output_path_real = '..\samples\outputs\raw\';
locations = [
    ["anechoic_chamber"; "Anechoic Chamber"];
    ["erics_apartment"; "Eric\'s Apartment"];
    ["intramural_field"; "Intramural Field"];
    ["simrall_stairwell"; "Simrall Stairwell"];
    ["ssrc_foyer"; "SSRC Foyer"]
];

input_samples_files = [
    ['..\samples\inputs\eric_voice.wav'; '\Audio (Speech).wav'],
    ['..\samples\inputs\prdog3.wav'; '\Audio (Animal).wav'],
    ['..\samples\inputs\Sample_BeeMoved_96kHz24bit_short.wav'; '\Audio (Music).wav']
];

impulse_response_files = [
    '\Impulse 1.wav';
    '\Impulse 2.wav';
    '\Impulse 3.wav'
];

figure_counter = 1;
for i = 1 : 2 : length(locations(:,1))
    [h1, fs1] = audioread(strcat(impulse_response_path, locations(i,:), impulse_response_files(1,:)));
    [h2, fs2] = audioread(strcat(impulse_response_path, locations(i,:), impulse_response_files(2,:)));
    [h3, fs3] = audioread(strcat(impulse_response_path, locations(i,:), impulse_response_files(3,:)));

    x1 = 0 : length(h1)-1;
    x2 = 0 : length(h2)-1;
    x3 = 0 : length(h3)-1;
    t1 = x1 / fs1;
    t2 = x2 / fs2;
    t3 = x3 / fs3;

    figure(figure_counter);
    figure_counter = figure_counter + 1;
    clf;
    plot(t1, h1, '-r');
    hold on;
    plot(t2, h2, '-g');
    plot(t3, h3, '-b');
    xlabel('Time (s)');
    ylabel('Impulse Response Magnitude');
    title(locations(i+1,:));
    legend(impulse_response_files(1,2:end-4), impulse_response_files(2,2:end-4), impulse_response_files(3,2:end-4))
end
