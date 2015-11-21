
require 'find'
FILES_SEARCHED = []

def search_files_in_this_folder(folder)
  Dir.chdir(folder)
  all_files_in_this_directory = Dir.glob("**/*")
  return if all_files_in_this_directory.empty?
  all_files_in_this_directory.each do |file|
    # begin
    if File.file?(File.join(folder, file))
      # p File.atime(file)
      # File.atime(file) > Time.now - 60 * 60 * 24 * 14 ? p true : p false
      # p file
      # break if FILES_SEARCHED.include?(File.join(folder, file))
      # FILES_SEARCHED << File.join(folder, file)
      p 'file'
    # elsif File.directory?(File.join(folder, file))
    #   p 'folder'
    #   search_files_in_this_folder(File.join(folder, file))
    # else
    #   next
    # end
    # rescue
    #   next
    end
  end
  # return
end
search_files_in_this_folder("/")

# def search_files_in_this_folder(folder)
#   folder.each do |file|
#     if file.type == folder
#       search_files_in_this_folder(file)
#     elsif file.last_opened < Date.one_week_ago 
#       compress(file)
#     else
#       next
#     end
#     return 
#   end
# end

# def compress(file)
#   file.gzip
# end
