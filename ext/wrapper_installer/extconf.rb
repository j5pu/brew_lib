
# Fake building extension
File.open('Makefile', 'w') { |f| f.write("all:\n\ninstall:\n\n") }
File.open('make', 'w') do |f|
  f.write('#!/bin/sh')
  f.chmod(f.stat.mode | 0111)
end
File.open('wrapper_installer.so', 'w') {}
File.open('wrapper_installer.dll', 'w') {}
File.open('nmake.bat', 'w') { |f| }

Gem.pre_install do |installer|
   installer.spec.post_install_message = "Post-install Extension Message: #{installer.spec.name} => #{__FILE__}"
   puts "Pre-install Extension: #{installer.spec.name} => #{__FILE__}"
end

Gem.post_install do |installer|
    puts "Post-install Extension: #{installer.spec.name} => #{__FILE__}"
end

# just in case - it worked
true
