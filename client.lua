local config = require 'config'

local function setLimit(veh)
    if not veh then return end
    Wait(100)

    local vehModel = GetEntityModel(veh)
    local limits = config.limitCustom[vehModel] or config.limitDefault
    CreateThread(function ()
        while cache.vehicle do
            local entitySpeed = GetEntitySpeed(cache.vehicle)
            local kmhspeed = entitySpeed * 3.6 --- KMH
            -- local kmhspeed = entitySpeed * 2.23694 --- MPH

            if math.floor(kmhspeed) >= limits then
                SetEntityMaxSpeed(cache.vehicle, entitySpeed)
            end
            
            Wait(50)
        end
    end)
end

lib.onCache('vehicle', setLimit)
