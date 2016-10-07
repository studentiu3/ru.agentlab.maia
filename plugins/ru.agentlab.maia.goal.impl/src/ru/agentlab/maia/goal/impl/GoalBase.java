package ru.agentlab.maia.goal.impl;

import java.util.Queue;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.IEvent;
import ru.agentlab.maia.goal.IGoalBase;
import ru.agentlab.maia.goal.event.GoalAddedEvent;

public class GoalBase implements IGoalBase {

	@Inject
	private Queue<IEvent<?>> eventQueue;

	@Override
	public boolean addGoal(OWLAxiom axiom) {
		// TODO: implement this
		eventQueue.offer(new GoalAddedEvent(axiom));
		return false;
	}

	@Override
	public boolean removeGoal(OWLAxiom axiom) {
		// TODO Auto-generated method stub
		// eventQueue.offer(new GoalClassificationRemovedEvent(axiom));
		return false;
	}

	@Override
	public boolean addGoal(Object event) {
		eventQueue.offer(new GoalAddedEvent(event));
		return false;
	}

	@Override
	public boolean removeGoal(Object event) {
		// TODO Auto-generated method stub
		return false;
	}

}
