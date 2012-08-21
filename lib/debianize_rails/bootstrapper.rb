module DebianizeRails
  class Bootstrapper

    attr_reader :errors

    def initialize(options)
      @options = options
      validate!
    end

    def valid?
      @errors.nil? || @errors.empty?
    end

    def run!
      raise "Bootstrapper is not in a valid state!" unless valid?
      Dir.chdir(@options.path)
      @debian_dir = File.join(Dir.pwd, DebianizeRails::DEBIAN_DIR)
      mkdir
      Dir[File.expand_path("../data/*.erb", __FILE__)].each(&method(:build_template))
      build_install_file
      copy_license
    rescue => e
      FileUtils.rmdir(@debian_dir) if File.exists?(@debian_dir) && File.directory?(@debian_dir)
      raise e
    end

    private
    def validate!
      @options.send(:table).keys.each do |key|
        value = @options.instance_eval key.to_s
        (@errors ||= []) << "Invalid value for #{key}" if value.nil? || value == ""
      end
      (@errors ||= []) << "Invalid path given for target application!" unless File.exists?(@options.path) && File.directory?(@options.path)
    end

    def build_template(filename)
      template = ERB.new File.read(filename)
      File.open(File.join(@debian_dir, File.basename(filename, ".erb")), 'w') do |f|
        f.write(template.result(@options.instance_eval("binding")))
      end
    end

    def build_install_file
      files = Dir[File.join(Dir.pwd, "*")].map{|file| File.basename(file)}
      files.push(".bundle") unless files.include?(".bundle")
      File.open(File.join(@debian_dir, "#{@options.package_name}.install"), "w") do |f|
        files.each do |cur|
          f.puts "#{cur} #{File.join(@options.server_path, @options.package_name)}"
        end
      end
    end

    def copy_license
      orig = File.expand_path(File.join("../data/licenses", @options.license.to_s), __FILE__)
      dest = File.join(@debian_dir, "copyright")
      FileUtils.cp(orig, dest)
    end

    def mkdir
      unless File.exists?(@debian_dir) && File.directory?(@debian_dir)
        FileUtils.mkdir_p(@debian_dir)
      end
    end
  end
end
