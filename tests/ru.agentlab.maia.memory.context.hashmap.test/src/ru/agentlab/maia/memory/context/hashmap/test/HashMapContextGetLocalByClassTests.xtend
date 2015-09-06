package ru.agentlab.maia.memory.context.hashmap.test

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.test.ContextGetLocalByClassAbstractTests
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.hashmap.HashMapContext

import static org.mockito.Mockito.*

class HashMapContextGetLocalByClassTests extends ContextGetLocalByClassAbstractTests {

	@Accessors
	IMaiaContext context = spy(new HashMapContext)

}