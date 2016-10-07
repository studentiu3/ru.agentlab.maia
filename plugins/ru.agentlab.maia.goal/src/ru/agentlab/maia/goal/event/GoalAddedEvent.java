package ru.agentlab.maia.goal.event;

import ru.agentlab.maia.agent.Event;

public class GoalAddedEvent extends Event<Object> {

	public GoalAddedEvent(Object goal) {
		super(goal);
	}

}
