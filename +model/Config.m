classdef Config

    properties (Constant)
        isDebug logical = true
        optionsFile = 'shulte_options.mat'
        typoSoundEffect = {'+model', 'typo_buzz.mp3'}

        databaseFilename = "shulte_tables.db"
        databaseInitScript = "init.sql"

        targetCompletionTimesColumns = {'Table Size', 'Skill Level', 'Target Time, sec', 'Last Result, sec', 'Avg. Search Time, sec', 'Mistakes'}
        targetCompletionTimes = {
            '4x4', 'Beginner', '≤ 25 seconds', '', '', ''; ...
            '5x5', 'Intermediate', '25–35 seconds', '', '', ''; ...
            '6x6', 'Advanced', '35–50 seconds', '', '', ''; ...
            '7x7', 'Expert/Trainer', '>50 seconds', '', '', ''; ...
            };
    end
end

