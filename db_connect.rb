#!/usr/bin/env ruby
require "thor"
require "json"

class DbConnect < Thor

	option :project, :required => true, :desc => "Project Name", :aliases => :p
	option :context, :default => "dev", :desc => "Context", :aliases => :c
	option :instance, :default => "master", :desc => "Master/Slave", :aliases => :i
	desc "connect ", "Connects to a MySQL Instance"
	def connect
		@context = options[:context]
		@project = options[:project]
		@instance = options[:instance]

		cmd = "mysql -h#{self.get_db_host} -P#{self.get_db_port} -u#{self.get_db_user} -p#{self.get_db_pass} #{self.get_db_name}"
		if self.get_db_pass == nil
			p "Error: #{cmd}"
			exit 1
		end

		p "Running #{cmd}"
		exec(cmd)
	end

	no_commands {
		def get_db_host
			config = self.get_config
			return config[@instance][0] if config
		end

		def get_db_port
			config = self.get_config
			return config[@instance][1] if config
		end

		def get_db_user
			config = self.get_config
			return config[@instance][2] if config
		end

		def get_db_pass
			config = self.get_config
			return config[@instance][3] if config
		end

		def get_db_name
			config = self.get_config
			if !config then return nil end

			if config.key?("db")
				return config["db"]
			end

			return "#{@context.to_s}_#{@project.to_s}"
		end

		def get_config
			file = File.read("#{Dir.home}/.db_connect/config.json")
			hosts = JSON.parse(file)

			return nil unless hosts.key?(@context)

			if @context == "dev"
				return hosts[@context]["default"] unless hosts[@context].key?(@project)
			elsif  @context == "prod"
				return nil unless hosts[@context].key?(@project)
			end

			return hosts[@context][@project]
		end
	}
end

DbConnect.start