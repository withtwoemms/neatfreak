require 'zlib'
require 'archive/tar/minitar'
require 'rubygems/package'
require 'fileutils'

include Archive::Tar


# STALE_AFTER = 1209600 # two weeks
STALE_AFTER = 50 

def clean_up(*not_these)
	tidy(get_stale_files('./'))
	seal('cabinet.neat')
end

def make_mess
	unseal('arxv.neat')
	untidy('cabinet.neat')
end


private
	def get_stale_files(*not_these)
		Dir.chdir('./')
		files = Dir.glob('*')
		return files.select { |file| is_stale?(file) } - not_these
	end

	def is_stale?(file)
		last_used = File.stat(file).atime
		fresh_then = Time.now - STALE_AFTER
		return last_used < fresh_then
	end

	def tidy(files)
		FileUtils.mkdir('./cabinet.neat')
		files.each do |file|
			FileUtils.mv("#{file}", './cabinet.neat')
			puts "cabinet << #{file}"
		end
	end

	def untidy(cabinet)
		files = Dir.glob("./#{cabinet}/*")
		files.each do |file|
			FileUtils.mv("#{file}", './')
			# puts "cabinet >> #{file}"
		end
		puts('*'*20 + "\ncabinet emptied")
		FileUtils.rm_rf(cabinet, secure: true)
	end

	def seal(cabinet)
		Minitar.pack(cabinet, Zlib::GzipWriter.new(File.open('arxv.neat', 'wb')))
		puts("*"*20 + "\ncabinet sealed in arxv.neat")
		FileUtils.rm_rf(cabinet, secure: true)
	end

	def unseal(arxv)
		# Minitar.unpack(Zlib::GzipReader.new(File.open(arxv, 'rb')), './') # stream version
		`tar -xvf #{arxv}`
		FileUtils.rm_rf(arxv, secure: true)
	end
