* return an array of files in folder --> Dir.glob(dir)
* check last time each file was used --> File.stat(file)
* specify a 'stale_after' time --> 1209600 seconds (2 weeks)
* check if file is stale
* return _stale_ files: those last used before 'stale_after' date