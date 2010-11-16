require 'rubygems'
require 'trollop'
require 'terminal-table/import'
require 'zencoder'
require 'zencoder/cli/helpers'
require 'zencoder/cli/auth'
require 'zencoder/cli/plugin'
require 'zencoder/cli/command'
ZencoderCLI::Plugin.load!


global_options = Trollop::options do
  version "Zencoder #{Zencoder::GEM_VERSION}"
  banner <<-EOS
#{"-" * (14 + Zencoder::GEM_VERSION.length)}
Zencoder CLI v#{Zencoder::GEM_VERSION}
#{"-" * (14 + Zencoder::GEM_VERSION.length)}

== Usage

zencoder command [options]

== Available Commands

#{
  ZencoderCLI::Command.commands.sort.map{|group, commands|
    commands.map{|command, description|
      command.ljust(18)+" # "+description
    }.join("\n")
  }.join("\n\n")
}

== Options
EOS
  stop_on ZencoderCLI::Command.commands.map{|k, v| v.keys }.flatten
end

if ARGV.empty?
  puts "You must specify a command. Use --help for more information."
  exit(1)
end

command = ARGV.shift.strip
args = ARGV

command_banner = <<-EOS
== Usage

zencoder #{command} [options]

== Options
EOS
command_options = case command
  when "jobs"
    Trollop::options do
      banner command_banner
      opt :number, "Number of jobs returned per page. Default 10.", :type => Integer
      opt :page,   "Jobs page number. Default 1.", :type => Integer
    end
  else
    Trollop::options do
      banner command_banner
    end
  end


ZencoderCLI::Command.run(command, args, global_options, command_options)
