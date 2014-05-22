#!/usr/bin/ruby
require 'json'
JSON.parse(%x[i3-msg -t get_workspaces]).each do |workspace|
	if (workspace['focused']) then
		number = workspace['name'].split(/:/)[0]
		name = %x[echo  | dmenu -p 'Rename workspace #{number}:']
		if(!name.empty?) then
			name = name.strip
			if(!name.empty?) then 
				name = ":#{name}"
			end
			%x[i3-msg 'rename workspace to "#{number}#{name}"']
		end 
	end
end
