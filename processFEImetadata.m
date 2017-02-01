%% config
data_dir = 'E:\WD_study\20161129\20161129A\test\original'; 
save_filename = 'metadata_20161129A'; % name of the Excel file output

%% prep and preallocate
main_dir = pwd;
cd(data_dir); % go to the folder with the hdr files
filestruct = dir('*.tif'); % make a file structure of the hdr files
filecount = length(filestruct);
outputrowcount = filecount+1; % one header row in output spreadsheet
outputs = cell(outputrowcount,160); % there are 160 rows in each UnknownTags.Value

%% loop through files
cd(data_dir);
for ii = 1:filecount
    % load the text
    meta_raw = imfinfo(filestruct(ii,1).name);
    extravals = meta_raw.UnknownTags.Value;
    C = transpose(strsplit(extravals,'\n'));
    C = regexp(C, '=', 'split');
    C = C(cellfun('length',C)==2);
    C = transpose(vertcat(C{:}));
    if ii == 1
        outputs(1,:) = C(1,:);
    end
    outputs(ii+1,:) = C(2,:);
end
xlswrite([save_filename,'.xlsx'],outputs);
cd(main_dir); % go back to the starting directory
