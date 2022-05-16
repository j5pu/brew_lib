# frozen_string_literal: true

require "optparse"
require "ostruct"
require "pathname"

require_relative "brew_lib/version"

# BrewLib
module BrewLib
  NAME = Pathname.new(__FILE__).basename.sub_ext("").to_s
  class Error < StandardError; end

  def self.pre_install
    # noinspection RubyNilAnalysis
    puts "Running #{__method__} => #{NAME} (#{BrewLib::VERSION})"
  end

  def self.pre_uninstall
    # noinspection RubyNilAnalysis
    puts "Running #{__method__} => #{NAME} (#{BrewLib::VERSION})"
  end

  def self.post_build
    # noinspection RubyNilAnalysis
    puts "Running #{__method__} => #{NAME} (#{BrewLib::VERSION})"
  end

  def self.post_install
    # noinspection RubyNilAnalysis
    puts "Running #{__method__} => #{NAME} (#{BrewLib::VERSION})"
  end

  def self.post_uninstall
    # noinspection RubyNilAnalysis
    puts "Running #{__method__} => #{NAME} (#{BrewLib::VERSION})"
  end

  # BrewLib::CLI
  class CLI
    def initialize(argv = ARGV)
      exception_handling do
        options_set_default
        OptionParser.new do |opts|
          # noinspection RubyNilAnalysis
          opts.banner = "#{NAME} {options}"
          opts.separator ""
          opts.separator "Options:"

          opts.on_tail("-h", "--help", "-H", "Display this help message.") do
            puts opts
            exit
          end

          options_spec.each { |args| opts.on(*args) }
        end.parse(argv)
      end
      BrewLib.post if options.post
    end

    # A list of all the standard options used in rake, suitable for
    # passing to OptionParser.
    def options_spec # :nodoc:
      [
        ["--post", "-p", "Post install ", ->(_) { options.post = true }],
        ["--silent", "-s", "Like --quiet, but also suppresses the 'in directory' announcement.",
         ->(_) { options.silent = true }],
        ["--verbose", "-v", "Log message to standard output.", ->(_) { options.verbose = true }],
        ["--version", "-V", "Display the program version.",
         lambda { |_|
           puts BrewLib::VERSION
           exit
         }]
      ]
    end

    # Application options from the command line
    def options
      @options ||= OpenStruct.new
    end

    # set default values for options
    def options_set_default
      options.post = false
      options.silent = false
      options.verbose = false
    end

    # Provide standard exception handling for the given block.
    def exception_handling
      yield
    rescue SystemExit
      # Exit silently with current status
      raise
    rescue OptionParser::InvalidOption => e
      warn e.message
      exit(false)
    rescue StandardError => e
      # Exit with error message
      puts e
      puts e.backtrace unless e.backtrace.nil?
      puts e.cause unless e.cause.nil?
      puts e.chain unless e.chain.nil?
      exit(false)
    end
  end
  # Your code goes here...
end
