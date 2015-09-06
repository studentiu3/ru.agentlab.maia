package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class ContextGetLocalByClassAbstractTests extends ContextAbstractTests {

	@Test
	def void shouldRetrieveServiceWhenInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.getLocal(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldNotRetrieveServiceWhenInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.getLocal(DummyService)

		assertThat(stored, nullValue)
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.getLocal(null as Class<?>)
	}

}