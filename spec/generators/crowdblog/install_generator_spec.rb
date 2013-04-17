require 'spec_helper'
require 'find'
require File.join(Crowdblog::Engine.root, "lib", "generators","crowdblog", "install_generator")

describe Crowdblog::InstallGenerator do

  before do
    backup_files!
  end

  after do
    restore_files!
  end

  it 'sets wrapper methods on the application_controller file' do
    cleanup!
    capture(:stdout) do

      Crowdblog::InstallGenerator.start([
        "--user-class= Publisher ", 
        "--current-user-helper= current_publisher",
        "--authenticate-user-helper= authenticate_publisher!"
      ], destination: Rails.root)
   end 

    application_controller_file = File.open("#{Rails.root}/app/controllers/application_controller.rb", "rb") { |io| io.read }
    application_controller_file.gsub!(/\s/,'')

    application_controller_file.should match(/defcrowdblog_current_usercurrent_publisher/)
    application_controller_file.should match(/defcrowdblog_authenticate_user!authenticate_publisher!/
    )
    cleanup!
  end

  it 'creates the crowdblog initializer file' do
    cleanup!
    capture(:stdout) do
      Crowdblog::InstallGenerator.start([
        "--user-class= Publisher ", 
        "--current-user-helper= current_publisher",
        "--authenticate-user-helper= authenticate_publisher!"
      ], destination: Rails.root)
    end
    crowdblog_initializer_file = "#{Rails.root}/config/initializers/crowdblog.rb"
    File.exist?(crowdblog_initializer_file).should be_true
    cleanup!
  end

  it 'copies over migrations' do
    cleanup!
    size = migrations.size

    capture(:stdout) do
      Crowdblog::InstallGenerator.start([
        "--user-class= Publisher ", 
        "--current-user-helper= current_publisher",
        "--authenticate-user-helper= authenticate_publisher!"
        ], destination: Rails.root)
    end

    migrations.size.should be > size
    cleanup!
  end

  it 'doesnt copy over migrations' do
    size = migrations.size

    capture(:stdout) do
      Crowdblog::InstallGenerator.start([
        "--user-class= Publisher ", 
        "--current-user-helper= current_publisher",
        "--authenticate-user-helper= authenticate_publisher!",
        "--no-migrate"
        ], destination: Rails.root)
    end

    migrations.size.should equal(size)
  end

  it 'mounts the engine on the config/routes.rb file' do
    routes_file_name = "#{Rails.root}/config/routes.rb"

    capture(:stdout) do
      Crowdblog::InstallGenerator.start([
        "--user-class= Publisher ", 
        "--current-user-helper= current_publisher",
        "--authenticate-user-helper= authenticate_publisher!",
        "--no-migrate"
        ], destination: Rails.root)
    end

    routes_file = File.open(routes_file_name, 'rb') { |io| io.read }
    routes_file.should match(/mount Crowdblog/)
  end

  def files
    @files ||= [{
      name: :routes,
      path: "#{Rails.root}/config/routes.rb",
      content: "Rails.application.routes.draw do\nend",
      }, {
        name: :application_controller,
        path: "#{Rails.root}/app/controllers/application_controller.rb",
        content: "class ApplicationController < ActionController::Base\n  protect_from_forgery\nend",
      }]
  end

  def migrations
    Dir["#{Rails.root}/db/migrate/*.rb"].sort
  end

  def backup_files!   
    files.each do |file|
      backup_file file[:path], file[:content]
    end
  end

  def backup_file(file_name, content)
    File.rename file_name, "#{file_name}.bak" if File.exist?(file_name)
    File.open(file_name, 'w') {|f| f.write content}
  end

  def restore_files!
    files.each do |file|
      restore_file file[:path]
    end
  end

  def restore_file(file_name)
    FileUtils.rm file_name if File.exist?(file_name)

    if File.exist?("#{file_name}.bak")
      File.rename "#{file_name}.bak", file_name
    end
  end

  def cleanup!
    Dir.chdir(Rails.root) do
      Find.find('db/migrate') do |path|
        FileUtils.rm("db/migrate/#{File.basename(path)}") if File.basename(path) =~ /crowdblog/
      end 
    end
  end
end
