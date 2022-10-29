
require "lib.moonloader" -- ����������� ����������
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
local hook = require 'lib.samp.events'
encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local tag = "{0066FF}[AUTOREPORT]{FFFFFF}" 
local act = false

local script_vers = 7
local script_vers_text = "1.04"

local update_url = "https://raw.githubusercontent.com/Bruno-Postin/Admin_Helper/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://github.com/Bruno-Postin/Admin_Helper/blob/main/Admin_Helper.luac?raw=true" -- ��� ���� ������
local script_path = thisScript().path


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    
    sampRegisterChatCommand("update", cmd_update)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(id)
	
	sampAddChatMessage(tag .. " - C����� ���������� {00FF00}������� �������{FFFFFF}. {FF00FF}��������� �������������! ", -1) 
    sampAddChatMessage(tag .. " -{00ff0d} ���{ffffff}/{FF0000}����{FFFFFF} ���������� - '{eeff00}END{FFFFFF}'", -1)
	sampAddChatMessage(tag .. " - ������ - {20B2AA}1.10{FFFFFF}. ������ ������� - {20B2AA}R, �� 29.10.2022{FFFFFF} ", -1)
	sampAddChatMessage(tag .. " -{00FF00} B.U - Postin | Nikita_Wilman | Vecher ", -1)
	sampAddChatMessage(tag .. " -{00FFFF} ��� ����� ��� �����, ������� �� ��������� � ���� ��������� ����! ", -1)
	
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
    
	while true do
        wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� ��������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end
		
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

function cmd_update(arg)
    sampShowDialog(1000, "Admin_Helper v1.10", "{FFFFFF}���������� ������� ���������.\n{FFF000}����� ������", "�������", "", 0)
end