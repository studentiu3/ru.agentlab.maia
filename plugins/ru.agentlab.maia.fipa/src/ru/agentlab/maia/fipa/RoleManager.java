package ru.agentlab.maia.fipa;

import javax.inject.Inject;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.IRoleBase;
<<<<<<< develop
import ru.agentlab.maia.agent.annotation.trigger.AddedExternalEvent;
import ru.agentlab.maia.agent.event.GoalAddedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;

public class RoleManager {

	@Inject
	protected IRoleBase roleBase;

	@AddedExternalEvent(GoalAddedEvent.class)
=======
import ru.agentlab.maia.agent.annotation.OnEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.goal.event.GoalAddedEvent;

public class RoleManager {

	@Inject
	protected IRoleBase roleBase;

	@OnEvent(GoalAddedEvent.class)
>>>>>>> e9ddd18 Implement FIPA protocols
	public void onRoleRemoveGoal(GoalAddedEvent event) {
		Object removeRole = event.getPayload();
		if (removeRole instanceof RoleRemovedEvent) {
			IRole role = ((RoleRemovedEvent) removeRole).getPayload();
			roleBase.remove(role);
		}
	}

}
