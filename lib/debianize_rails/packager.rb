module DebianizeRails
  class Packager

    attr_reader :errors

    def initialize(options)
      @options = options
      validate!
    end

    def valid?
      @errors.nil? || @errors.empty?
    end

    def run!
      raise "Packager is not in a valid state!" unless valid?
      Dir.chdir(@options.path)
    end

    private
    def validate!
      @options.send(:table).keys.each do |key|
        value = @options.instance_eval key.to_s
        (@errors ||= []) << "Invalid value for #{key}" if value.nil? || value == ""
      end
      (@errors ||= []) << "Invalid path given for target application!" unless File.exists?(@options.path) && File.directory?(@options.path)
    end
  end
end
