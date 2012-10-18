module Prop2env
    class CLI
        include Mixlib::CLI
        
        option :properties_file,
            :short => "-p CONFIG",
            :long  => "--properties CONFIG",
            :description => "The properties file to convert to",
            :required => true
        
        option :dotenv_file,
            :short => "-e CONFIG",
            :long  => "--env CONFIG",
            :description => "The .env file to feed to foreman",
            :required => true
        
        option :help,
            :short => "-h",
            :long  => "--help",
            :description => "Help message",
            :on => :tail,
            :boolean => true
        
        def self.start 
            cli = CLI.new
            cli.parse_options
            Parser.convert(cli.config)
        end
    end
end
