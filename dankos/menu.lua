os.pullEvent = os.pullEventRaw
local file = fs.open("osfiles/version.dat","r") -- Open Version Number.
		local versiontext = file.readLine(1)
      local version = tonumber(file.readLine(2))
      local versionname = file.readLine(3)
file.close()


local w,h = term.getSize()
 
function printCentered( y,s )
   local x = math.floor((w - string.len(s)) / 2)
   term.setCursorPos(x,y)
   term.clearLine()
   term.write( s )
end
 
local nOption = 1
 
local function drawMenu()
   term.setBackgroundColor(colors.green)
   term.setTextColor(colors.white)
   term.clear()
   term.setCursorPos(1,1)
   term.write("DankOS Version: ".. versiontext)
term.setCursorPos(1,2)
shell.run("id")
 
   term.setCursorPos(w-11,1)
   if nOption == 1 then
   term.write("Command")
elseif nOption == 2 then
   term.write("Programs")
elseif nOption == 3 then
   term.write("Shutdown")
elseif nOption == 4 then
   term.write("LogOff")
else
end
   term.setBackgroundColor(colors.black)
   term.setTextColor(colors.yellow)
end
 
--GUI
term.clear()
local function drawFrontend()
   term.setBackgroundColor(colors.green)
   term.setTextColor(colors.white)
   printCentered( math.floor(h/2) - 3, "")
   printCentered( math.floor(h/2) - 2, "Main Menu" )
   printCentered( math.floor(h/2) - 1, "")
   printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Command  ]") or "Command " )
   printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Programs ]") or "Programs" )
   printCentered( math.floor(h/2) + 2, ((nOption == 3) and "[ Shutdown ]") or "Shutdown" )
   printCentered( math.floor(h/2) + 3, ((nOption == 4) and "[ LogOff   ]") or "LogOff  " )
   printCentered( math.floor(h/2) + 4, "")
   term.setBackgroundColor(colors.black)
   term.setTextColor(colors.yellow)
end
 
--Display
drawMenu()
drawFrontend()
 
while true do
	local e,p = os.pullEvent("key")
		if p == keys.up then
			if nOption > 1 then
				nOption = nOption - 1
				drawMenu()
				drawFrontend()
			end
		elseif p == keys.down then
			if nOption < 4 then
				nOption = nOption + 1
				drawMenu()
				drawFrontend()
			end
		elseif p == keys.enter then
			break
		end
end
term.clear()
 
--Conditions
if nOption  == 1 then
   shell.run("osfiles/command")
elseif nOption == 2 then
   shell.run("osfiles/programs")
elseif nOption == 3 then
   os.shutdown()
elseif nOption == 4 then
   term.setCursorPos(1,1)
   print("are you sure you want to log off? Y/N")
   local input = read()
   local logoffanswer = false
   if input == "Y" then
      logoffanswer = true
   elseif input == "y" then
      logoffanswer = true
   elseif input == "N" then
      logoffanswer = false
   elseif input == "n" then
      logoffanswer = false
   else
      print("Not valid!")
      sleep(1)
      shell.run("/menu")
   end
   if logoffanswer == true then
      print("Logging off...")
   sleep(0.5)
   term.clear()
   term.setCursorPos(1,1)
   shell.run("/osfiles/login.lua")
   else
      shell.run("/menu")
   end
else
   term.clear()
   term.setCursorPos(1,1)
   term.write("Error Code 1, nOption Value Surpassed max value, nOption value is: ".. nOption)
end
