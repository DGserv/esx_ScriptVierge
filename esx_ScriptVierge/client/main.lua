local HasAlreadyEnteredMarker
    CurrentActionData = false, false, false, false, false, {}
local   LastZone, CurrentAction, CurrentActionMsg



AddEventHandler('esx_ScriptVierge:hasEnteredMarker', function(zone)
    if zone == 'VehicleSpawner' then
        CurrentAction = 'vehicle_spawner'
        CurrentActionMsg = TranslateCap('spawner_prompt')
        CurrentActionData = {}
     end
end)

AddEventHandler('esx_ScriptVierge:hasExitedMarker', function(zone)
    ESX.CloseContext()
    CurrentAction = nil
end)

-- Enter / Exit marker events, and draw markers
CreateThread(function()
    while true do
        local sleep = 1500


            local coords = GetEntityCoords(PlayerPedId())
            local isInMarker, currentZone = false

            for k, v in pairs(Config.Zones) do
                local zonePos = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
                local distance = #(coords - zonePos)

                if v.Type ~= -1 and distance < Config.DrawDistance then
                    sleep = 0
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
                        v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
                end

                if distance < v.Size.x then
                    isInMarker, currentZone = true, k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                TriggerEvent('esx_ScriptVierge:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('esx_ScriptVierge:hasExitedMarker', LastZone)
            end
      
        Wait(sleep)
    end
end)

-- Key Controls
CreateThread(function()
    while true do
        local sleep = 1500
        if CurrentAction and not ESX.PlayerData.dead then
            sleep = 0
            ESX.ShowHelpNotification(CurrentActionMsg)


                if CurrentAction == 'taxi_actions_menu' then
                    OpenTaxiActionsMenu()
                end

                CurrentAction = nil
           
        end
        Wait(sleep)
    end
end)
