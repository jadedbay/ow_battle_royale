rule "follow player":
    @Event eachPlayer
    @Team 2
    if distance(eventPlayer, getPlayersInSlot(0, Team.1)) >= 1:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), getPlayersInSlot(0, Team.1).getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    if distance(eventPlayer, getPlayersInSlot(0, Team.1)) < 1:
        eventPlayer.stopThrottleInDirection()