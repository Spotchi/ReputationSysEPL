function [NOMAList,notesList,courseList] = runUCL(option)
data_dir = 'data/';

courseList = {};
courseList = readSheet(strcat(data_dir,'2011-2012Bac3.csv'),courseList, option);
courseList = readSheet(strcat(data_dir,'2012-2013MAP2M.csv'),courseList, option);
courseList = readSheet(strcat(data_dir,'2013-2014MAP2M.csv'),courseList, option);
[notesList,NOMAList] = transcript(courseList,option);
end

function [notesList,NOMAList] = transcript(courseList,option)
	
	notesList = {};
	NOMAList = {};
	[nCourses,~] = size(courseList);
	mean = zeros(nCourses,1);
	var = zeros(nCourses,1);
	nRatings = zeros(nCourses,1);
	
	% Preprocessing
    if strcmp(option,'meanVariance') == 1 || strcmp(option,'meanVarianceSelect')==1
        for cCourse = 1:nCourses
            [~,nNotes] = size(courseList{cCourse,3});
            for cNote = 1:nNotes
                mean(cCourse) = mean(cCourse) + courseList{cCourse,3}{1,cNote}{1,2};
                nRatings(cCourse) = nRatings(cCourse)+1;
            end
            mean(cCourse) = mean(cCourse)/nRatings(cCourse);
            for cNote = 1:nNotes
                var(cCourse) = var(cCourse) + (mean(cCourse)-courseList{cCourse,3}{1,cNote}{1,2})^2;
            end
            var(cCourse) = var(cCourse)/nRatings(cCourse);
            for cNote = 1:nNotes
                courseList{cCourse,3}{1,cNote}{1,2} = (courseList{cCourse,3}{1,cNote}{1,2}-mean(cCourse))/sqrt(var(cCourse));
            end
        end
    end

	i = 1;
	while i <= nCourses
		cours = courseList{i,1};
		profs = courseList{i,2};
		[~,nNotes] = size(courseList{i,3});
		j = 1;
		while j <= nNotes
			NOMA = courseList{i,3}{1,j}{1};
			note = courseList{i,3}{1,j}{2};
			[notesList,NOMAList] = insertNotes(profs,cours,note,NOMA,notesList,NOMAList);
			j = j + 1;
		end
		i = i + 1;
	end
end
	
function courseList = readSheet(filename,oldCourseList,option)
	fid = fopen(filename);
	courseList = oldCourseList;
		
	i = 0;
	textscan(fid,'%s',1,'Delimiter','\n');
	while(~feof(fid))
	    m = textscan(fid,'%s',4,'Delimiter',';');
	    cours = m{1}{1};
	    profs = strsplit(m{1}{2},', ');
	    note = str2double(m{1}{3});
	    NOMA = str2double(m{1}{4});
        if ~isnan(note)
            if note >= 8 || ~(strcmp(option,'meanVarianceSelect')==1)
                courseList = insertCourse(profs,cours,note,NOMA,courseList);
            end
        end
        i = i+1;
	end
	fclose(fid);
end

function newCourseList = insertCourse(profs,course,note,NOMA,coursesList)
	
	newCourseList = coursesList;
	[nCourses,~] = size(newCourseList);
	courseInList = 0;
    i = 1;
    while i<=nCourses && ~courseInList
        if strcmp(course,newCourseList{i})==1
    		courseInList = 1;
    		previous = newCourseList{i,3};
    		new = {NOMA,note};
            if isempty(previous)
    			newCourseList{i,3} = {new};
            else
                [~, nNotes] = size(previous);
          		newCourseList{i,3} = cell(1,nNotes+1);
                newCourseList{i,3}(1:nNotes) = previous;
                newCourseList{i,3}(nNotes+1) = {new};
            end
        end
        i = i + 1;
    end
    
    if ~courseInList
    	newCourseList{i,1} = course;
    	newCourseList(i,2) = {profs};
    	newCourseList{i,3} = {{NOMA,note}};
    end
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
                new = {course,note,spr};
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
            newNotesList{nTeachers,NOMAindex+1} = {{course, note, spr}};
        end
    end
end

