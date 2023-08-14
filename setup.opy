rule "disable collision":
    @Event eachPlayer
    @Team 1
    eventPlayer.disablePlayerCollision()