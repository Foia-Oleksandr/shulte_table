classdef Config

    properties (Constant)
        isDebug logical = true
        optionsFile = 'shulte_options.mat'
        typoSoundEffect = {'+model', 'typo_buzz.mp3'}

        databaseFilename = "shulte_tables.db"
        databaseInitScript = "init.sql"
    end
end

