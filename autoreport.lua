require "lib.moonloader"

local hook = require 'lib.samp.events'
local keys = require "vkeys"

-------------------| ����������
local tag = "{0066FF}[AUTOREPORT]{FFFFFF}" 
local act = false
--------------------------------------------

function main()
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(tag .. " - C����� ���������� {00FF00}������� �������{FFFFFF}. {FF00FF}��������� �������������! ", -1) 
    sampAddChatMessage(tag .. " -{00ff0d} ���{ffffff}/{FF0000}����{FFFFFF} ���������� - '{eeff00}END{FFFFFF}'", -1)
	sampAddChatMessage(tag .. " - ������ - {20B2AA}1.1{FFFFFF}. ������ ������� - {20B2AA}BT, �� 20.03.2022{FFFFFF} ", -1)
	sampAddChatMessage(tag .. " -{00FF00} B.U - Postin | Nikita_Wilman | Vecher ", -1)
	sampAddChatMessage(tag .. " -{00FFFF} ��� ����� ��� �����, ������� �� ��������� � ���� ��������� ����! ", -1)
    
	while true do
        wait(0)
		if isKeyJustPressed(VK_END) then
            act = not act
			sampAddChatMessage(act and '{FF00FF} [������!] {00FF00}������� ������ ����!' or '{FF00FF} [������!] {FF0000}�������� ������ ����!', -1)
		end
	end
end


function hook.onServerMessage(color, text)
    if act and not sampIsDialogActive() and not isGamePaused() and not sampIsChatInputActive() then
        if text:find('%[R] <������> (.*)') or text:find('%[R] <������> (.*)') then
            lua_thread.create(function() 
                sampSendChat('/ot')
            end)
        end
    end
    return {color, text}
end

