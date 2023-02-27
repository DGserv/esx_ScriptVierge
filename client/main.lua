ESX = nil
ESX = exports["es_extended"]:getSharedObject()



-- BLIPS
CreateThread(function()
    local blip = AddBlipForCoord(-396.1692, 1156.1654, 325.8522)

    SetBlipSprite(blip, 61)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 3)
  --  SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('~b~Laboratoire')
    EndTextCommandSetBlipName(blip)


end)





---------------------------------------------------------------------------------------------------------------                    
-- MARKER
---------------------------------------------------------------------------------------------------------------                    
Citizen.CreateThread(function()
    local interactZone = vector3(-396.1203, 1156.0670, 325.8521)
    local helpText = "Appuyez sur ~INPUT_CONTEXT~ pour utiliser le laboratoire."
    while true do
        local interval = 250
        local playerPos = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(interactZone, playerPos, true)
        if distance <= 10.0 then
            -- On réduit l'intervalle à 0 (soit 1 frame)
            interval = 0
            -- On affiche la zone
            DrawMarker(0, interactZone, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 0,108,118, 255, 55555, false, true, 2, false, false, false, false)
            if distance <= 1.0 then
                -- On initialise le texte d'aide
                AddTextEntry("monTexte", helpText)
                DisplayHelpTextThisFrame("monTexte", 0)
                if IsControlJustPressed(0, 51) then
--------------------------------------------------------------------------------------------------------------- 
-- FIN MARKER
                end
            end 
        end
        Wait(interval)
    end
end)
---------------------------------------------------------------------------------------------------------------  
---------------------------------------------------------------------------------------------------------------  


