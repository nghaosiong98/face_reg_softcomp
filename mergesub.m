function [] = mergesub(sub1,sub2,newsub)
    % This function merge two folders of images into one new folder.
    photo_dir = "photos\";

    sub1_path = fullfile(photo_dir,sub1);
    sub2_path = fullfile(photo_dir,sub2);

    subject1_list = dir(fullfile(sub1_path,"*"));
    subject2_list = dir(fullfile(sub2_path, "*"));

    subject1_list = {subject1_list.name};
    subject1_list(ismember(subject1_list, {'.', '..'})) = []; % remove . and ..
    subject2_list = {subject2_list.name};
    subject2_list(ismember(subject2_list, {'.', '..'})) = []; % remove . and ..

    temp_dir = fullfile(photo_dir,"temp");
    new_dir = fullfile(photo_dir,newsub);
    mkdir(temp_dir)

    i = 1;
    for imgname = subject1_list
        movefile(fullfile(photo_dir,sub1,imgname),fullfile(temp_dir,i+".jpg"));
        i = i + 1;
    end

    for imgname = subject2_list
        movefile(fullfile(photo_dir,sub2,imgname),fullfile(temp_dir,i+".jpg"));
        i = i + 1;
    end

    rmdir(sub1_path, 's');
    rmdir(sub2_path, 's');
    movefile(temp_dir,new_dir);
end

