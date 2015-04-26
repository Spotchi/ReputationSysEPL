function [notesList,NOMAList] = runUCL
data_dir = 'data/';
NOMAList = {};
notesList = {};
[notesList,NOMAList] = transcript(strcat(data_dir,'2011-2012Bac3.csv'),NOMAList,notesList);
[notesList,NOMAList] = transcript(strcat(data_dir,'2012-2013MAP2M.csv'),NOMAList,notesList);
[notesList,NOMAList] = transcript(strcat(data_dir,'2013-2014MAP2M.csv'),NOMAList,notesList);
end

function [notesList,NOMAList] = transcript(filename,oldNOMAList,oldNotesList)
fid = fopen(filename);
notesList = oldNotesList;
NOMAList = oldNOMAList;

i = 0;
textscan(fid,'%s',1,'Delimiter','\n');
while(~feof(fid))
    m = textscan(fid,'%s',4,'Delimiter',';');
    cours = m{1}{1};
    profs = strsplit(m{1}{2},', ');
    note = str2double(m{1}{3});
    NOMA = str2double(m{1}{4});
    [notesList,NOMAList] = insertNotes(profs,cours,note,NOMA,notesList,NOMAList);
    i = i+1;
end
fclose(fid);
end

function [newNotesList,newNOMAList] = insertNotes(profs,course,note,NOMA,coursesList,NOMAList)
    newNotesList = coursesList;
    newNOMAList = NOMAList;
    [~,spr] = size(profs);
    [nTeachers,~] = size(newNotesList);
    NOMAindex = 0;
    NOMAinList = 0;
    [~,sizeNOMA] = size(newNOMAList);
    while NOMAindex <= sizeNOMA && ~NOMAinList
        NOMAindex = NOMAindex+1;
        if NOMAindex < sizeNOMA
            if NOMA== newNOMAList{NOMAindex}
                NOMAinList = 1;
            end
        end
    end
    if ~NOMAinList
        newNOMAList{NOMAindex} = NOMA;
        newNotesList{1,NOMAindex+1} = [];
    end
    for l = 1:spr
        [s,~] = size(newNotesList);
        prof = profs{l};
        isInList = 0;
        i = 1;
        while i <= s && ~isInList
            if (strcmp(newNotesList{i,1},prof)==1)
                isInList = 1;
                previous = newNotesList{i,NOMAindex+1};
                new = {course,note};
                if isempty(previous)
                    newNotesList{i,NOMAindex+1} = {new};
                else
                    newNotesList{i,NOMAindex+1} = {previous{1,1},new};
                end
            end
            i = i+1;
        end
        nTeachers = nTeachers+1-isInList;
        if ~isInList
            newNotesList{nTeachers,1} = prof;
            newNotesList{nTeachers,NOMAindex+1} = {{course, note}};
        end
    end
end
function newNOMAList = insertNOMA(NOMA,NOMAList)
    [s,~] = size(NOMAList);
    newNOMAList = NOMAList;
    isInList = 0;
    i = 1;
    while i <= s && ~isInList
        if (NOMA==NOMAList{i})
            isInList = 1;
        end
        i = i+1;
    end
    if ~isInList
        newNOMAList{s+1} = NOMA;
    end
end