#
# Cookbook:: hello
# Recipe:: default
#
# Creates a directory, a file, and a script in /tmp/hello
#
# Copyright:: 2024 Progress Software Inc
#

directory '/tmp/hello' do
  action :create
end

file '/tmp/hello/content.txt' do
  content "Hello, World!\n\n"
end

file '/tmp/hello/show-me' do
  content "#!/bin/bash\n\ncat /tmp/hello/content.txt\n"
  mode '0755'
end
