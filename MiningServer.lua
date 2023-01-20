
local MiningServer = {
    Protocol = "MSTP"
}

function Init() 
    local name = "MiningServer" .. os.getComputerID()
    os.setComputerLabel(name)

    peripheral.find("modem", rednet.open)
    assert(rednet.isOpen(), "Could not find a wireless modem")
    
    rednet.host(MiningServer.Protocol, name)
    
    print(name .. " hosting " .. MiningServer.Protocol)

    rednet.receive(MiningServer.Protocol)
end


Init()