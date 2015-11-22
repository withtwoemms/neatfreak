require 'zlib'

def find_all_files_that_should_be_compressed(folder)
  # Changes to the directory desired
  Dir.chdir(folder)
  # Grabs & stores all file paths 
  all_files_in_this_directory = Dir.glob("**/*")
  return if all_files_in_this_directory.empty?
  # Iterates over file paths, checks if it's a file
  # Sees if it has been accessed within last 2 weeks
  all_files_in_this_directory.each do |path|
    if File.file?(File.join(Dir.pwd, path)) && File.atime(path) < Time.now - 60 * 60 * 24 * 14 
      # Create a compressed version of the file
      File.write("#{path}.gz", Zlib.deflate(path))
      # Delete the uncompressed file
      File.unlink(path)
    end
  end
end

# replace the argument below with the folder that you want to target. 
# to run this on your entire computer use "/" as the argument.
# find_all_files_that_should_be_compressed("/neatfreak/test_folder")

def find_all_files_that_should_be_decompressed(folder)
    # Changes to the directory desired
    Dir.chdir(folder)
    # Grabs & stores all file paths
    all_files_in_this_directory = Dir.glob("**/*")
    return if all_files_in_this_directory.empty?
    # Iterates over file paths, checks if it's a file
    # Sees if it has been accessed within last 2 weeks
    all_files_in_this_directory.each do |path|
      begin
        if File.extname(path) == ".gz"
            # Create a compressed version of the file
            # Zlib::GzipReader.open(path) { |gz| File.write("#{path}".chomp('.gz'), gz.read) }
            Zlib::GzipReader.open(path)
            # Delete the uncompressed file
            File.unlink(path)
        end
        rescue Exception => ex
          puts "An error of type #{ex.class} happened, message is #{ex.message}"
          next
        end
    end
end

find_all_files_that_should_be_decompressed("/")
