local Map = window.create(term.current(),1,1,51,22)
local Sap = window.create(term.current(),12,8,28,9)
local slide = false
local app = "urAppHere" -- gui text
local App = "/Tsecure/urAppHere.txt" -- program folder

function Mdisplay()
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
end
 
function Sdisplay()
    term.setCursorBlink(false)
   Sap.setBackgroundColor(colors.white)
   Sap.setTextColor(colors.gray)
   Sap.clear()
   Sap.setCursorPos(12,2)
   Sap.write("Options")
   paintutils.drawLine(13,11,24,11,colors.lightBlue)
   Sap.setCursorPos(5,4)
   write("Add user")
   paintutils.drawLine(13,13,24,13,colors.lightBlue)
   Sap.setCursorPos(3,6)
   write("Remove user")
   paintutils.drawLine(13,15,24,15,colors.lightBlue)
   Sap.setCursorPos(5,8)
   write("Console")
   paintutils.drawLine(27,11,38,11,colors.lightBlue)
   Sap.setCursorPos(19,4)
   write("Config")
   paintutils.drawLine(27,13,38,13,colors.lightBlue)
   Sap.setCursorPos(18,6)
   write(app)
   paintutils.drawLine(27,15,38,15,colors.red)
   Sap.setCursorPos(20,8)
   write("Reset")
   term.setBackgroundColor(colors.white)
end

function boot()
    local plus = true
    Sdisplay()
    paintutils.drawBox(3,1,10,2,colors.lightBlue)
    Map.setCursorPos(3,1)
    write("Restart")
    Map.setCursorPos(3,2)
    write("Shutdown")
    while plus do
	    local event1, param1, x,y = os.pullEvent() 
        if event1 == "mouse_click" and x>=3 and x<=10 and y == 1 then
            plus = false
            os.reboot()
        elseif event1 == "mouse_click" and x>=3 and x<=10 and y == 2 then
            plus = false
            os.shutdown()
        elseif event1 == "mouse_click" and x>=1 and x<=2 and y == 1 then
           slide = false
           plus = false
           return
        end
    end
end
function system()
    if slide == true then
         Map.setCursorPos(1,1)
         Map.setBackgroundColor(colors.cyan)
         Map.write("|<")
         boot()
     else
         Map.setCursorPos(1,1)
         Map.setBackgroundColor(colors.cyan)
         Map.write(">|")
     end
end

function block()
    Map.setCursorPos(14,3)
    Map.write("Higher Permissions needed.")
    sleep(1)
end

while true do
    Mdisplay()
    system()
    Sdisplay()
    local file = fs.open("/Tsecure/Tempuser","r")
    local tmp = textutils.unserialise(file.readAll())
    file.close()
        for ID, data in pairs(tmp) do
            clearance = tmp[ID][2]
        end
        tonumber(clearance)
        Map.setCursorPos(2,3)
        event, param1, x,y = os.pullEvent()
            if event == "mouse_click" and x>=13 and x<=24 and y == 11 then
                if clearance >= "8" then
                    shell.run("/Tsecure/regist")
                else
                    block()
                end
            elseif event == "mouse_click" and x>=13 and x<=24 and y == 13 then
               if clearance >= "8" then
                   shell.run("/Tsecure/Remove.lua")
               else
                   block()
               end
            elseif event == "mouse_click" and x>=13 and x<=24 and y == 15 then
                if clearance == "9" then
                    term.setBackgroundColor(colors.black)
                    term.setTextColor(colors.white)
                    term.setCursorPos(1,1)
                    term.clear()
                    break
                else
                    block()
                end
            elseif event == "mouse_click" and x>=27 and x<=38 and y == 11 then
                if clearance >= "8" then
                    shell.run("Tsecure/config")
                else
                    block()
                end
            elseif event == "mouse_click" and x>=27 and x<=38 and y == 13 then
                if clearance >= "1" then
                    shell.run(App)
                else
                    block()
                end
            elseif event == "mouse_click" and x>=27 and x<=38 and y == 15 then
                if clearance >= "9" then
                 local reset = true
                 while reset do
                    term.setBackgroundColor(colors.black)
                    term.setTextColor(colors.white)
                    term.clear()
                    term.setCursorPos(1,1)
                    print("You are about to remove True Security.")
                    print("Are you sure? : (Y/N)")
                    print("|>")
                    term.setCursorPos(3,3)
                    result = read()
                    if result == "y" then
                         term.setCursorPos(1,1)
                         term.clear()
                         print("Removing User files.")
                         fs.delete("/Tsecure/TiD")
                         sleep(0.2)
                         term.clear()
                         term.setCursorPos(1,1)
                         print("Removing User files..")
                         fs.delete("/Tsecure/tData")
                         sleep(0.2)
                         term.clear()
                         term.setCursorPos(1,1)
                         print("Removing remaining files...")
                         fs.delete("/Tsecure/")
                         fs.delete("startup")
                         term.clear()
                         term.setCursorPos(1,1)
                         print("Finished Removing True Security")
                         sleep(1)
                         os.reboot()
                   elseif result == "n" then
                        reset = false
                   else
                        term.clear()
                        print("That is an incorrect input")
                        sleep(1)
                   end 
                end
              end      
            elseif event == "mouse_click" and x>=0 and x<=2 and y == 1 then
                if slide == false then
                    slide = true
                else
                    slide = false
                end
            end
end
