
--- Creates a link to a webpage.
-- @arg url A string with the webpage address.
-- @arg text A string with the text to be shown with the link in the Application.
-- @usage link("www.wikipedia.org", "wikipedia")
function link(url, text)
	mandatoryArgument(1, "string", url)
	mandatoryArgument(2, "string", text)

	if string.sub(url, 1, 4) ~= "http" then
		url = "http://"..url
	end

	return "<a target=\"_blank\" href=\""..url.."\">"..text.."</a>"
end

