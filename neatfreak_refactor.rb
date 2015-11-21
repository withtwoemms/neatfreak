STALE_AFTER = 1209600 # two weeks

def get_stale_files(path)
	Dir.chdir(path)
	files = Dir.glob('*')
	return files.select { |file| is_stale?(file) }
end

def is_stale?(file)
	last_used = File.stat(file).atime
	fresh_then = Time.now - STALE_AFTER
	return last_used < fresh_then
end