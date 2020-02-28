--local pullEvent = os.pullEvent
-- os.pullEvent = os.pullEventRaw
local sPass = false
-- Windows --
local Map = window.create(term.current(),1,1,51,22)
local Sap = window.create(term.current(),12,8,28,9)
local R = {}
local Apass = "Admin"
-- Functions --

local function screen()
  Map.setBackgroundColor(colors.cyan)
  Map.setTextColor(colors.white)
  Map.clear()
  Map.setCursorPos(20,6)
  Map.write("True Security")
  Map.setCursorPos(1,19)
  Map.write("Computer:")
  Map.setTextColor(colors.gray)
  Map.setCursorPos(10,19)
  Map.write(os.computerLabel())
  Sap.setBackgroundColor(colors.white)
  Map.setCursorPos(51,1)
  Map.setTextColor(colors.red)
  Map.write("x")
  Sap.setTextColor(colors.gray)
  Sap.clear()
  Sap.setCursorPos(8,2)
  Sap.write("Current Users")
end




local function load()
  local file = fs.open("/Tsecure/TiD","r")
  local R = textutils.unserialise(file.readAll())
  file.close()
  return (R)
end

function Remove(R, Ruser)
  for ID, Tuser in pairs(R) do
    --print(textutils.serialise(R[ID]))
    --print(ID)
    --print(Ruser)
    --print(Tuser[2])
    if Ruser == Tuser[1] then
      R[ID] = nil
      --print(textutils.serialise(R))
    else
        --print("unsuccessful")
    end
  end
end

function save(R)
  local file = fs.open("/Tsecure/TiD","w")
  file.write(textutils.serialise(R))
  file.close()
end

-- script --
local R = load()
if fs.exists("/Tsecure/Tempuser","r") then
  local check = fs.open("/Tsecure/TiD","r")
  local checkTable = textutils.unserialise(check.readAll())
  check.close()
  --local tempCheck = fs.open("/Tsecure/Tempuser","r")
  --local tempCheckTable = textutils.unserialise(tempCheck.readAll())
  --tempCheck.close()
  for tUserID, tUsername in pairs(checkTable) do
    --print(tUserID)
    --print(tUsername[1])
    --sleep(1)
    if checkTable[tUserID][1] == tUsername[1] then
      tPass = checkTable[tUserID][2]
      tUser = checkTable[tUserID][1]
    end
  end
  repeat
    local x = 2 + 5

    screen()
    Sap.setCursorPos(1,4)
    Sap.write(">")
    for k, v in pairs(R) do
      local x, y = Sap.getCursorPos()
      Sap.setCursorPos(x + 3,4)
      Sap.write(v[1])
    end

    paintutils.drawLine(16, 15, 34, 15,colors.lightGray)
    term.setCursorPos(20,15)
    print(" Input User ")
	event, param1, x,y = os.pullEvent()
	if event == "mouse_click" and x>=16 and x<=34 and y == 15 then
		term.setCursorPos(16,15)
		Ruser = read()
		term.setCursorPos(1,2)
		--print(tUser)
		term.setCursorPos(16,15)
		print(" Input Password ")
		term.setCursorPos(16, 15)
		rPass = read()
			if tUser == Ruser and rPass == Apass then
				sPass = true
			else
				term.setCursorPos(16,15)
				print("Unknown Input/Error")
				sleep(1)
			end
	elseif event == "mouse_click" and x>=50 and x<=51 and y == 1 then
		sPass = true
	end
  until sPass == true
end

if rPass == Apass then
	Remove(R, Ruser)
	save(R)
end
