require 'yaml'
require 'fileutils'
require 'erb'
require 'ostruct'

root=ARGV.first
flavor_name=ARGV[1]
platform=ARGV.last
if root.nil? then
	puts "need root path"
	return
end
flavors="#{root}/flavors/#{flavor_name}"
unless File.exist?(flavors) then
	puts "flavors :#{flavor_name}: not exist"
	return
end
 FileUtils.cp_r("#{flavors}/app", "#{root}")



config = YAML::load(File.read("#{flavors}/build/config.yaml"))

config_file = File.open("#{root}/app/scripts/config.js","w+")
config_tmp = File.read("#{root}/config.js.erb")

config_file << ERB.new(config_tmp).result(OpenStruct.new(config).instance_eval { binding })
config_file.close


