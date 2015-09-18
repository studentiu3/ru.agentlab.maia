package ru.agentlab.maia.execution.scheduler.fsm.test

import javax.annotation.PostConstruct
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.node.AbstractNode
import ru.agentlab.maia.execution.scheduler.fsm.IFsmScheduler
import ru.agentlab.maia.execution.scheduler.fsm.impl.FsmScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class FsmSchedulerStateTests {

	@Mock
	IMaiaContext context

	@Mock
	IMaiaContextInjector injector

	@Spy @InjectMocks
	IFsmScheduler scheduler = new FsmScheduler

	@Test
	def void shouldBeUnknownWhenConstructed() {
		assertThat(scheduler.state, equalTo(IExecutionNode.UNKNOWN))
	}

	@Test
	def void shouldBeInstalledWhenDeployToContext() {
		when(context.getServiceLocal(IMaiaContextInjector)).thenReturn(injector)
		when(injector.invoke(scheduler, PostConstruct, null)).thenAnswer [
			(scheduler as AbstractNode).init
			return null
		]
		when(injector.deploy(scheduler)).thenAnswer [
			(scheduler as AbstractNode).init
			return null
		]

		injector.deploy(scheduler)

		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))
	}

	@Test @Ignore
	def void shouldBeActiveWhenHaveTransitionChain() {
		val child = mock(IExecutionNode)
		(scheduler as AbstractNode).init
		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))

		scheduler.addChild(child)
		scheduler.addDefaultTransition(null, child)
		scheduler.addDefaultTransition(child, null)

		assertThat(scheduler.state, equalTo(IExecutionNode.ACTIVE))
	}

	@Test @Ignore
	def void shouldNotChangeStateWhenAddTransition() {
		val child = mock(IExecutionNode)
		(scheduler as AbstractNode).init
		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))

		scheduler.addChild(child)
		scheduler.addDefaultTransition(null, child)

		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))
	}

	@Test @Ignore
	def void shouldNotIncreaseStateWhenAddChild() {
		val child = mock(IExecutionNode)
		(scheduler as AbstractNode).init
		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))

		scheduler.addChild(child)

		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))
	}
}