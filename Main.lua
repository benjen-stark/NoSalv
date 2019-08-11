local _, core = ...; -- Namespace
local events = CreateFrame("Frame");

function core:Init(event, name)	
	if (event == "ADDON_LOADED") then
		if (name == "NoSalv") then
			events:UnregisterEvent("ADDON_LOADED");
			events:RegisterEvent("UNIT_AURA");
		end
	elseif (event == "UNIT_AURA") then
		core.CancelSalvationBuff();
	end
end

function core:CancelSalvationBuff()
	local salv = "Blessing of Salvation"
	local counter = 1
	while UnitBuff("player", counter) do
		local name = UnitBuff("player", counter)
		if string.find(name, salv) then
			CancelUnitBuff("player", counter);
			UIErrorsFrame:Clear();
			UIErrorsFrame:AddMessage("Salvation Removed");
			return
		end
		counter = counter + 1
	end
end

events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.Init);