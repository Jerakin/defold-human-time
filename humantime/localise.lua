local M = {}

M.LANGUAGE = "en-US"

function M.format_distance(key, count)
	local translation_data = sys.load_resource("/humantime/translations/" .. M.LANGUAGE .. ".json")
	assert(translation_data, "Language not found")

	local translation_value = json.decode(translation_data)[key]
	local result
	if type(translation_value) == "string" then
		result = translation_value
	elseif count == 1 then
		result = translation_value['one']
	else
		result = translation_value['other']:format(count)
	end
	return result
end

return M