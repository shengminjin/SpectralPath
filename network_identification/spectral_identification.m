listing = {'brightkite', 'flixster',  'gowalla', 'hyves', 'livejournal', 'myspace', 'orkut', 'youtube', 'astroph', 'condmat', 'grqc',  ...
'hepth', 'roadbel', 'roadca', 'roadpa', 'roadtx','bio-dmela', 'bio-grid-human', 'bio-grid-yeast', 'human-brain'} 
% listing = {'brightkite', 'flixster',  'gowalla', 'hyves', 'livejournal', 'myspace', 'orkut', 'youtube',};
% listing = {'astroph', 'condmat', 'grqc',  'hepth'};
% listing = {'roadbel', 'roadca', 'roadpa', 'roadtx'};
% listing = {'bio-dmela', 'bio-grid-human', 'bio-grid-yeast', 'human-brain'} 
% listing = {'brightkite'};


n = size(listing, 2);
sampling_prop = 0;

confusion_matrix = zeros(n, n);
features = [];
for i = 1:n
    f1 = listing(i);
    
    input2 = strcat('moments/', f1{1,1}, '-sample.mat');
    points = load(input2);
    points = points.('m');
    points = points(2:end, 2:4); % the points to be identifies
     
    for entry_number = 1:size(points, 1)
        point = points(entry_number, :);
        distances = [];
        for j = 1:n
            f2 = listing(j);
            input1 = strcat('moments/', f1{1,1}, '.mat');
            v1 = load(input1);
            m = v1.('m'); 
%           get the expected points
            expected_moments = m(1, 2:4);
            for samplie_prop = 1:9
               samples =  m(2+(samplie_prop-1)*20: 1+ samplie_prop*20, 2:4);
               expected_moments = [expected_moments; mean(samples)];
            end
%             get the distance as features
            distance = sqrt((expected_moments(:, 1)-point(:,1)).^2 + (expected_moments(:, 2)-point(:,2)).^2 + (expected_moments(:, 3)-point(:,3)).^2);
            distances = [distances distance'];
        end
        features = [features; distances];
    end
end
dataset = array2table(features);
labels = repelem(listing', 180);
dataset.Group = labels;

[classifier, accuracy] = trainKNN(dataset);
accuracy
