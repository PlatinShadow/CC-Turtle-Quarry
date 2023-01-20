require("MSTP_Protocol")

local tArgs = {...}

local MiningServer = {
    Name = "",
    Clients = {},
}

local Monitor = nil

function Init() 
    -- Setup Hostname
    assert(#tArgs == 1, "Invalid Syntax: Please provide a name for the host")
    MiningServer.Name = MSTP.SERVER_TAG .. tArgs[1]
    os.setComputerLabel(MiningServer.Name)

    -- Setup Packet Handlers
    MSTP.Packets["Register"] = Packet_Register
    
    --Setup Monitor
    Monitor = peripheral.find("monitor")
    term.redirect(Monitor)
    term.clear()
    
    -- Setup RedNet
    peripheral.find("modem", rednet.open)
    assert(rednet.isOpen(), "Could not find a wireless modem")
    
    rednet.host(MSTP.PROTOCOL_NAME, MiningServer.Name)
    
    print("Hostname: " .. tArgs[1])
    print("Hosting " .. MSTP.PROTOCOL_NAME .. " Protocol")
    
    while true do
        Update()
    end
end

function Packet_Register(id, name)
    print("New turtle registerd: #" .. id .. " - " .. name)
    MSTP.SendPacket(id, "Register", "The cake is a lie")
end

function Draw()

    local width, height = Monitor.getSize()
    term.clear()
    term.setCursorPos(1,1)
    paintutils.drawBox(2, 3, 30, 7, colors.red)


end

function Update() 
    Draw()
    
    local event, param1, param2, param3 = os.pullEvent()

    if event == "rednet_message" then
        MSTP.HandlePacket(param1, param2, param3)
    end
end

Init()