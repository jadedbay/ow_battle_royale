playervar previous_ammo
playervar previous_max_ammo

rule "add ammo":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    eventPlayer.setMaxAmmo(0, eventPlayer.getMaxAmmo(0) + 30)

rule "reload < max":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) and eventPlayer.getMaxAmmo(0) < 30 and eventPlayer.getMaxAmmo(0) != 0
    eventPlayer.previous_max_ammo = eventPlayer.getMaxAmmo(0)
    eventPlayer.setMaxAmmo(0, 30)
    eventPlayer.forceButtonPress(Button.RELOAD)
    

rule "get ammo before reload":
    @Event eachPlayer
    @Condition eventPlayer.isReloading()
    if eventPlayer.getMaxAmmo(0) < 30 and eventPlayer.getMaxAmmo(0) != 0:
        eventPlayer.previous_max_ammo = eventPlayer.getMaxAmmo(0)
    eventPlayer.previous_ammo = eventPlayer.getAmmo(0)

rule "reload":
    @Event eachPlayer
    @Condition eventPlayer.getAmmo(0) > eventPlayer.previous_ammo
    if eventPlayer.previous_max_ammo != 0:
        eventPlayer.setMaxAmmo(0, eventPlayer.previous_max_ammo) 
    if eventPlayer.getMaxAmmo(0) < 30:
        if eventPlayer.getMaxAmmo(0) + eventPlayer.previous_ammo < 30:
            eventPlayer.setAmmo(0, eventPlayer.getMaxAmmo(0) + eventPlayer.previous_ammo)
        if eventPlayer.getMaxAmmo(0) + eventPlayer.previous_ammo >= 30:
            eventPlayer.setAmmo(0, 30)
    if eventPlayer.getMaxAmmo(0) >= 30:
        eventPlayer.setAmmo(0, 30)
    eventPlayer.setMaxAmmo(0, eventPlayer.getMaxAmmo(0) - (30 - eventPlayer.previous_ammo))
    eventPlayer.previous_max_ammo = 0
    eventPlayer.previous_ammo = 100