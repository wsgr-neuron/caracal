bundler_standalone_loader = ENV["BUNDLER_STANDALONE_LOADER"] || "gems/bundler/setup"

begin
  require_relative bundler_standalone_loader
rescue LoadError
  warn "WARNING: Standalone bundle loader is not at #{bundler_standalone_loader}. Using Bundler to load gems."
  require "bundler/setup"
end

lib_dir = File.expand_path("lib", __dir__)
if not $LOAD_PATH.include?(lib_dir)
  $LOAD_PATH.unshift(lib_dir)
end

libraries_dir = ENV["LIBRARIES_HOME"]
return if libraries_dir.nil?

libraries_dir = File.expand_path(libraries_dir)

Dir.glob("#{libraries_dir}/*/lib") do |library_dir|
  if not $LOAD_PATH.include?(library_dir)
    $LOAD_PATH.unshift(library_dir)
  end
end
