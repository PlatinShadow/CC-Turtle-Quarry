MSTP = {
    PROTOCOL_NAME = "MSTP",
    SERVER_TAG = "MiningServer",
    CLIENT_TAG = "MiningClient",

    Packets = {        
        ["Register"] = nil
    },

    HandlePacket = function (sender, message, protocol)
        -- Only listen to packets from our Protocol
        if(protocol ~= MSTP.PROTOCOL_NAME) then return end
        
        -- Ignore message if its not in the correct format
        if(type(message) ~= "table") then
            print("Unknown packet format: " .. tostring(message))
            return
        end
    
        -- If the message is a table, try to parse it as a Packet
        local packetHandler = MSTP.Packets[message.PacketId]
        if (packetHandler == nil) then
            print("Recieved Unknown Packet: " .. tostring(message))
            return
        end
    
        packetHandler(sender, message.Data)
    end,

    SendPacket = function(host, packetId, data)
        local packet = {
            PacketId = packetId,
            Data = data
        }

        rednet.send(host, packet, MSTP.PROTOCOL_NAME)
    end
}
