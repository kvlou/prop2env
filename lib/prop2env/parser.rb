module Prop2env
    class Parser
        def self.convert(conf)
            unless File.exists? conf[:properties_file] then
                raise ParserException, "Properties file #{conf[:properties_file]} does not exist"
            end
            
            vars = {}
            File.open(conf[:properties_file]) do |f|
                lines = f.readlines.select { |l| l.strip.length != 0 }
                lines.each do |line|
                    k,v = line.split('=', 2)
                    vkey = k.gsub(/[\.\-]/, '_').upcase
                    vars[vkey] = v.strip
                end
            end
            
            if File.exists? conf[:dotenv_file] then
                puts "WARNING: #{conf[:dotenv_file]} is going to be overwritten"
            end
            File.open(conf[:dotenv_file], 'w') do |f|
                vars.each do |k,v|
                    f.write("#{k}=\"#{v}\"\n")
                end
            end
        end
    end
    
    class ParserException < Exception
    end
end
