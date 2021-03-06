Mission = { }

Mission.MissionOver = function(winners, losers, setWinStates)
	World:SetLocalPauseState(true)
	World:set_PauseStateLocked(true)
	if winners then
		for i, player in ipairs(winners) do
			Media.PlaySpeechNotification("Win", player)
			if setWinStates then
				OpenRA.SetWinState(player, "Won")
			end
		end
	end
	if losers then
		for i, player in ipairs(losers) do
			Media.PlaySpeechNotification("Lose", player)
			if setWinStates then
				OpenRA.SetWinState(player, "Lost")
			end
		end
	end
	Mission.MissionIsOver = true
end

Mission.GetGroundAttackersOf = function(player)
	return Utils.EnumerableWhere(World.Actors, function(actor)
		return not Actor.IsDead(actor) and Actor.IsInWorld(actor) and Actor.Owner(actor) == player and Actor.HasTrait(actor, "AttackBase") and Actor.HasTrait(actor, "Mobile")
	end)
end

Mission.TickTakeOre = function(player)
	OpenRA.TakeOre(player, 0.01 * OpenRA.GetOreCapacity(player) / 25)
end

Mission.RequiredUnitsAreDestroyed = function(player)
	return Internal.RequiredUnitsAreDestroyed(player)
end