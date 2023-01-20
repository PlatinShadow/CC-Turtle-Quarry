require("MSTP_Protocol")

local tArgs = {...}

local MiningClient = {
    Pos = {x=0, y=0, z=0},
    Dir = 0,
    CurrentJob = nil,
    Name = "",
    Server = ""
}

function Init() 
    --Setup Hostname and Clientname
    assert(#tArgs == 1, "Invalid Syntax: Please provide a host")
    local host = MSTP.SERVER_TAG .. tArgs[1]
    MiningClient.Name = MSTP.CLIENT_TAG .. os.getComputerID()
    os.setComputerLabel(MiningClient.Name)

    -- Setup Packet Handlers
    MSTP.Packets["Register"] = Packet_Register

    -- Setup RedNet
    print("Connecting to " .. host .. " using " .. MSTP.PROTOCOL_NAME .. " Protocol")
    rednet.open("left");
    MiningClient.Server = rednet.lookup(MSTP.PROTOCOL_NAME, host)
    
    assert(MiningClient.Server ~= nil, "Server not found")

    MSTP.SendPacket(MiningClient.Server, "Register", MiningClient.Name)

    while true do
        Update()
    end

end

function Packet_Register(id, data)
    print("Got registerd by server: " .. data)
end

function Update()
    local event, param1, param2, param3 = os.pullEvent()

    if event == "rednet_message" then
        MSTP.HandlePacket(param1, param2, param3)
    end
end

Init()