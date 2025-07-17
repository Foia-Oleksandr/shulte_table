classdef Config

    properties (Constant)
        isDebug logical = true
        optionsFile = 'shulte_options.mat'
        typoSoundEffect = {'+model', 'typo_buzz.mp3'}

        databaseFilename = "shulte_tables.db"
        databaseInitScript = "init.sql"

        targetCompletionTimesColumns = {'Table Size',  'Symbols', 'Properties', 'Skill Level', 'Target Time, sec', 'Last Result, sec', 'Avg. Search Time, sec', 'Mistakes'}
        targetCompletionTimes = {
            '4x4', 'Dec', '', 'Beginner', '≤ 25 seconds', '', '', ''; ...
            '5x5', 'Dec', '', 'Intermediate', '25–35 seconds', '', '', ''; ...
            '6x6', 'Dec', '', 'Advanced', '35–50 seconds', '', '', ''; ...
            '7x7', 'Dec', '', 'Expert/Trainer', '>50 seconds', '', '', ''; ...
            };
    end
end

