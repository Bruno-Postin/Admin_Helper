require "lib.moonloader"

local hook = require 'lib.samp.events'
local keys = require "vkeys"

-------------------| Переменные
local tag = "{0066FF}[AUTOREPORT]{FFFFFF}" 
local act = false
--------------------------------------------

function main()
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(tag .. " - Cкрипт Авторепорт {00FF00}успешно запущен{FFFFFF}. {FF00FF}Приятного использования! ", -1) 
    sampAddChatMessage(tag .. " -{00ff0d} ВКЛ{ffffff}/{FF0000}ВЫКЛ{FFFFFF} авторепорт - '{eeff00}END{FFFFFF}'", -1)
	sampAddChatMessage(tag .. " - Версия - {20B2AA}1.1{FFFFFF}. Версия ревизии - {20B2AA}BT, от 20.03.2022{FFFFFF} ", -1)
	sampAddChatMessage(tag .. " -{00FF00} B.U - Postin | Nikita_Wilman | Vecher ", -1)
	sampAddChatMessage(tag .. " -{00FFFF} Иди лучше чай попей, отдохни от намальска и этих админских штук! ", -1)
    
	while true do
        wait(0)
		if isKeyJustPressed(VK_END) then
            act = not act
			sampAddChatMessage(act and '{FF00FF} [Автуха!] {00FF00}Включил автуху брат!' or '{FF00FF} [Автуха!] {FF0000}Выключил автуху брат!', -1)
		end
	end
end


function hook.onServerMessage(color, text)
    if act and not sampIsDialogActive() and not isGamePaused() and not sampIsChatInputActive() then
        if text:find('%[R] <ВОПРОС> (.*)') or text:find('%[R] <ЖАЛОБА> (.*)') then
            lua_thread.create(function() 
                sampSendChat('/ot')
            end)
        end
    end
    return {color, text}
end

