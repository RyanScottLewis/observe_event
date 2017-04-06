# frozen_string_literal: true

if File.exist?("#{File.basename(__dir__)}.gemspec")
  require 'bundler/gem_tasks'

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
end

require 'rake/version_task'
Rake::VersionTask.new

require 'rubocop/rake_task'
RuboCop::RakeTask.new
# --

require 'erb'
require 'yaml'

# Renders templates
class TemplateRenderer
  def initialize
    @variables = YAML.load_file('.templates.yml')
    @variables.each { |key, value| @variables[key] = value.strip }
  end

  def method_missing(name)
    @variables[name.to_s] || super
  end

  def respond_to_missing?(name, include_private = false)
    @variables.key?(name.to_s) || super
  end

  def file(path)
    File.read(path).chomp
  end

  def render(path)
    contents = File.read(path)
    document = ERB.new(contents)

    document.result(binding)
  end
end

TEMPLATE_RENDERER     = TemplateRenderer.new
TEMPLATE_INPUT_PATHS  = FileList['templates/*.erb']
TEMPLATE_OUTPUT_PATHS = TEMPLATE_INPUT_PATHS.map { |path| File.basename(path, '.erb') }
TEMPLATE_PATHS        = Hash[TEMPLATE_INPUT_PATHS.zip(TEMPLATE_OUTPUT_PATHS)]

TEMPLATE_PATHS.each do |input_path, output_path|
  file output_path => input_path do
    puts "Rendering `#{output_path}`"

    contents = TEMPLATE_RENDERER.render(input_path)
    File.open(output_path, 'w+') { |file| file.write(contents) }
  end
end

desc 'Render templates'
task 'templates:build' => TEMPLATE_OUTPUT_PATHS

desc 'Clean templates'
task 'templates:clean' do
  TEMPLATE_OUTPUT_PATHS.each do |path|
    rm_f path
  end
end

# --

task default: %w[spec templates:build rubocop:auto_correct]
