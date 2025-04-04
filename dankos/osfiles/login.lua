function pos(...) return term.setCursorPos(...) end
function cls(...) return term.clear() end
function tCol(...) return term.setTextColor(...) end
function bCol(...) return term.setBackgroundColor(...) end
function box(...) return paintutils.drawFilledBox(...) end
function line(...) return paintutils.drawLine(...) end

x,y = term.getSize()
arg = {...}
------------------------------------------------------------

function drawMenu() --Draw GUI function
    cls()
    pos(1,1)
    box(1,1,x,y,colors.lightBlue) --Background
    box(12,6,40,13,colors.gray) --Login Menu
    line(12,6,40,6,colors.lightGray) -- Top Bar
    line(38,6,40,6,colors.red) --Exit
    line(23,8,38,8,colors.black) --User Field
    line(23,10,38,10,colors.black) -- Pass Field
    line(14,12,21,12,colors.green) --Create
    line(32,12,38,12,colors.green) --Login
    
    tCol(colors.black)
    bCol(colors.red)
    pos(39,6)
    write("X")
    
    tCol(colors.yellow)
    bCol(colors.gray)
    pos(14,8)
    write("USERNAME")
    pos(14,10)
    write("PASSWORD")
    
    tCol(colors.black)
    bCol(colors.green)
    pos(15,12)
    write("CREATE")
    pos(33,12)
    write("LOGIN")
    
    tCol(colors.white)
    bCol(colors.black)
end

function drawMenuPocket()
    cls()
    pos(1,1)
    box(1,1,x,y,colors.lightBlue) --Background
    box(1,6,26,13,colors.gray) --Login Menu
    line(1,6,26,6,colors.lightGray) -- Top Bar
    line(24,6,26,6,colors.red) --Exit
    line(11,8,25,8,colors.black) --User Field
    line(11,10,25,10,colors.black) -- Pass Field
    line(19,12,25,12,colors.green) --Login
    line(2,12,9,12,colors.green) --Create
    
    tCol(colors.black)
    bCol(colors.red)
    pos(25,6)
    write("X")
    
    tCol(colors.yellow)
    bCol(colors.gray)
    pos(2,8)
    write("USERNAME")
    pos(2,10)
    write("PASSWORD")
    
    tCol(colors.black)
    bCol(colors.green)
    pos(20,12)
    write("LOGIN")
    pos(3,12)
    write("CREATE")
    
    tCol(colors.white)
    bCol(colors.black)
end

function drawTimedMsg(message,sec,msgx,msgy) --Pop up message with custom message, time, and message coords
	box(10,5,45,11,colors.black) --Window
	paintutils.drawBox(10,5,45,11,colors.red) --Top Bar
	
	tCol(colors.red)
	bCol(colors.black)
	pos(26,5)
	write("Alert!")
	
	tCol(colors.white)
	pos(msgx,msgy)
	write(message)
	sleep(sec)
end

function drawTimedMsgPocket(message,sec,msgx,msgy)
	box(3,5,25,11,colors.black) --Window
	paintutils.drawBox(3,5,25,11,colors.red) --Top Bar
	
	tCol(colors.red)
	bCol(colors.black)
	pos(11,5)
	write("Alert!")
	
	tCol(colors.white)
	pos(msgx,msgy)
	write(message)
	sleep(sec)
end

function login() --Authenticate users
	if user == nil or #user <= 1 then
		drawTimedMsg("Must enter username!",2,18,8)
		shell.run("login.lua")
	elseif pass == nil or #pass <= 1 then
		drawTimedMsg("Must enter password!",2,18,8)
		shell.run("/osfiles/login.lua")
	end
	
	if fs.exists("account/"..user..".dat") then
		file = fs.open("account/"..user..".dat","r")
		password = file.readAll()
		file.close()
		
		if pass == password then
			cls()
			pos(1,1)
			shell.run(".menu.lua")
			return
		else
			drawTimedMsg("Incorrect password!",2,19,8)
			shell.run("/osfiles/login.lua")
		end
	else
		drawTimedMsg("No user found!",2,21,8)
		shell.run("/osfiles/login.lua")
	end
	
end

function loginPocket()
	if user == nil or #user <= 1 then
		drawTimedMsgPocket("Must enter user!",2,6,8)
		shell.run("login.lua")
	elseif pass == nil or #pass <= 1 then
		drawTimedMsgPocket("Must enter pass!",2,6,8)
		shell.run("login.lua")
	end
	
	if fs.exists("account/"..user..".dat") then
		file = fs.open("account/"..user..".dat","r")
		password = file.readAll()
		file.close()
		
		if pass == password then
			cls()
			pos(1,1)
			print("UNLOCKED")
		else
			drawTimedMsgPocket("Incorrect password!",2,5,8)
			shell.run("login.lua")
		end
	else
		drawTimedMsgPocket("No user found!",2,8,8)
		shell.run("login.lua")
	end
end

function create() --Create user accounts
	box(1,1,x,y,colors.lightBlue)
	box(12,5,40,18,colors.lightGray) --Window
	line(12,5,40,5,colors.gray) --Top Bar
	line(38,5,40,5,colors.red) --X Button
	line(24,11,35,11,colors.gray) --Username Field
	line(24,13,35,13,colors.gray) --Password Field
	line(24,15,35,15,colors.gray) --Confirm Password Field
	box(12,6,40,9,colors.black) --Text Box
	line(28,17,35,17,colors.green) --Create Button
	pos(39,5)
	tCol(colors.white)
	bCol(colors.red)
	write("X")
	
	tCol(colors.blue)
	bCol(colors.black)
	pos(16,7)
	write("Welcome to AeroOS!")
	pos(14,8)
	write("Lars's OS!")
	
	pos(14,11)
	tCol(colors.yellow)
	bCol(colors.lightGray)
	write("USERNAME")
	pos(14,13)
	write("PASSWORD")
	pos(14,15)
	write("CONFIRM")
	
	pos(29,17)
	tCol(colors.white)
	bCol(colors.green)
	write("CREATE")
	
	tCol(colors.white)
	bCol(colors.gray)
	pos(24,11)
	user = read()
	pos(24,13)
	pass = read("*")
	pos(24,15)
	confirm = read("*")
	
	while true do
    local event, button, mx, my = os.pullEvent()
	
        if event == "mouse_click" then
            if mx >= 28 and mx < 35 and my == 17 then --Create Button
				break
            elseif mx >= 38 and mx < 40 and my == 5 then --Exit button
            end
        end
	end

	if user == nil or #user <= 1 then
		drawTimedMsg("Must enter username!",2,18,8)
		shell.run("login.lua","create")
	elseif pass == nil or #pass <= 1 then
		drawTimedMsg("Must enter password!",2,18,8)
		shell.run("login.lua","create")
	elseif pass ~= confirm then
		drawTimedMsg("Password don't match!",2,17,8)
		shell.run("login.lua","create")
	end
	
	if fs.exists("account/"..user..".dat") then
		drawTimedMsg("Username taken!",2,21,8)
		shell.run("login.lua","create")
	else
		file = fs.open("account/"..user..".dat","w")
		file.write(pass)
		file.close()
		drawTimedMsg("Account created!",2,21,8)
		shell.run("login.lua")
	end
end

function createPocket()
	box(1,1,x,y,colors.lightBlue)
	box(1,5,26,18,colors.lightGray) --Window
	line(1,5,26,5,colors.gray) --Top Bar
	line(24,5,26,5,colors.red) --X Button
	line(12,11,25,11,colors.gray) --Username Field
	line(12,13,25,13,colors.gray) --Password Field
	line(12,15,25,15,colors.gray) --Confirm Password Field
	box(1,6,26,9,colors.black) --Text Box
	line(18,17,25,17,colors.green) --Create Button
	pos(25,5)
	tCol(colors.white)
	bCol(colors.red)
	write("X")
	
	tCol(colors.blue)
	bCol(colors.black)
	pos(3,7)
	write("Please note that-")
	pos(2,8)
	write("Pocket computers no support.")
	
	pos(2,11)
	tCol(colors.yellow)
	bCol(colors.lightGray)
	write("USERNAME")
	pos(2,13)
	write("PASSWORD")
	pos(2,15)
	write("CONFIRM")
	
	pos(19,17)
	tCol(colors.white)
	bCol(colors.green)
	write("CREATE")
	
	tCol(colors.white)
	bCol(colors.gray)
	pos(12,11)
	user = read()
	pos(12,13)
	pass = read("*")
	pos(12,15)
	confirm = read("*")
	
	while true do
    local event, button, mx, my = os.pullEvent()
	
        if event == "mouse_click" then
            if mx >= 18 and mx < 25 and my == 17 then --Create Button
				break
            elseif mx >= 24 and mx < 26 and my == 5 then --Exit button
				shell.run("login.lua")
            end
        end
	end

	if user == nil or #user <= 1 then
		drawTimedMsgPocket("Must enter user!",2,6,8)
		shell.run("login.lua","create")
	elseif pass == nil or #pass <= 1 then
		drawTimedMsgPocket("Must enter pass!",2,6,8)
		shell.run("login.lua","create")
	elseif pass ~= confirm then
		drawTimedMsgPocket("Pass doesn't match!",2,5,8)
		shell.run("login.lua","create")
	end
	
	if fs.exists("account/"..user..".dat") then
		drawTimedMsgPocket("Username taken!",2,6,8)
		shell.run("login.lua","create")
	else
		file = fs.open("account/"..user..".dat","w")
		file.write(pass)
		file.close()
		drawTimedMsgPocket("Account created!",2,6,8)
		shell.run("login.lua")
	end
end

function main() --Main program logic for 51,19 resolution computers
    drawMenu()
    
    while true do
    
        local event, button, mx, my = os.pullEvent()
        if event == "mouse_click" then
        
            if mx >= 23 and mx <= 38 and my == 8 and button == 1 then
                pos(23,8)
                user = read()
                pos(23,10)
                pass = read("*")
            
            elseif mx >= 23 and mx <= 38 and my == 10 and button == 1 then
                pos(23,10)
                pass = read("*")
                
            elseif mx >= 14 and mx <= 21 and my == 12 and button == 1 then
                create()
                break
                
            elseif mx >= 32 and mx <= 38 and my == 12 and button == 1 then
                login()
                break
                
            elseif mx >= 38 and mx <= 40 and my == 6 and button == 1 then
                os.reboot()
                
            end
        end
    end 
end

function mainPocket() --Main program logic for 26,20 resolution computers
	drawMenuPocket()
	
    while true do
    
        local event, button, mx, my = os.pullEvent()
        if event == "mouse_click" then
        
            if mx >= 11 and mx <= 25 and my == 8 and button == 1 then
                pos(11,8)
                user = read()
                pos(11,10)
                pass = read("*")
            
            elseif mx >= 11 and mx <= 25 and my == 10 and button == 1 then
                pos(11,10)
                pass = read("*")
                
            elseif mx >= 19 and mx <= 25 and my == 12 and button == 1 then
                loginPocket()
                break
                
            elseif mx >= 2 and mx <= 9 and my == 12 and button == 1 then
                createPocket()
                break
                
            elseif mx >= 24 and mx <= 26 and my == 6 and button == 1 then
                os.reboot()
                
            end
        end
    end 
end

--------------------------------------------------------------
if arg[1] == "create" and pocket then
elseif arg[1] == "create" then
	create()
elseif pocket then
else
	main()
end

