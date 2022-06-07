
listing = {'brightkite', 'flixster',  'gowalla', 'hyves', 'livejournal', 'myspace', 'orkut', 'youtube',};
% listing = {'astroph', 'condmat', 'grqc',  'hepth'};
% listing = {'roadbel', 'roadca', 'roadpa', 'roadtx'};
% listing = {'bio-dmela', 'bio-grid-human', 'bio-grid-yeast', 'human-brain'} 


figure
index = 0;
for s = listing
    input1 = strcat('moments/', s{1,1}, '.mat');
    v1 = load(input1);
    m = v1.('m'); 
    
    expected_moments = [];
    for samplie_prop = 1:9
       samples =  m(2+(samplie_prop-1)*20: 1+ samplie_prop*20, :);
       expected_moments = [expected_moments; mean(samples)];
    end
    expected_moments = [expected_moments(:, [2:4 21]); m(1, [2:4 21])];
    expected_moments = flip(expected_moments);
    
    X = expected_moments(1:end-1, 1);
    Y = expected_moments(1:end-1, 2);
    Z = expected_moments(1:end-1, 3);

    X_direction = expected_moments(2:end, 1) - X;
    Y_direction = expected_moments(2:end, 2) - Y;
    Z_direction = expected_moments(2:end, 3) - Z;
    
    quiver3(X, Y, Z, X_direction, Y_direction, Z_direction, 0, 'MaxHeadSize', 0.02, 'DisplayName', s{1,1})
%     quiver3(X, Y, Z, X_direction, Y_direction, Z_direction, 'DisplayName', s{1,1})
    hold on
%     scatter3(expected_moments(1,1), expected_moments(1,2), expected_moments(1,3), 30, '*', 'r');
%     scatter3(expected_moments(2:end,1), expected_moments(2:end,2), expected_moments(2:end,3), 30, expected_moments(2:end,4));
%     
    xlabel('m_2')
    ylabel('m_3')
    zlabel('m_4')
end
legend(listing);
