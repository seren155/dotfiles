local seren = {}

seren.bind = function(keybind, program)
	return hl.bind(keybind, hl.dsp.exec_cmd("runapp " .. program))
end

return seren
