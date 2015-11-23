[x] return an array of files in folder --> Dir.glob(dir)
[x] check last time each file was used --> File.stat(file)
[x] specify a 'stale_after' time --> 1209600 seconds (2 weeks)
[x] check if file is stale
[x] return _stale_ files: those last used before 'stale_after' date
[x] package stale files --> tar
[ ] compress stale files
[ ] decompress stale files