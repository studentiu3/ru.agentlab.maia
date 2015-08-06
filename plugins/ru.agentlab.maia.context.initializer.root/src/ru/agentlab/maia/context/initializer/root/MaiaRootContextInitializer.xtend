package ru.agentlab.maia.context.initializer.root

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

class MaiaRootContextInitializer {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
//			val injector = get(IMaiaContextInjector)
//
//			val lifecycleScheme = injector.make(FipaLifecycleScheme, it)
//			injector.invoke(lifecycleScheme, PostConstruct, it)
//
//			val lifecycleService = injector.make(LifecycleService, it)
//			injector.invoke(lifecycleService, PostConstruct, it)
//
//			val sequenceContextScheduler = injector.make(SequenceContextScheduler, it)
//			injector.invoke(sequenceContextScheduler, PostConstruct, it)
//
//			val maiaExecutorService = injector.make(MaiaExecutorService, it)
//			injector.invoke(maiaExecutorService, PostConstruct, it)
//
			set(IMaiaContext.KEY_TYPE, "root")
			set(ExecutorService, Executors.newFixedThreadPool(2))
			
//			set(IMaiaContextLifecycleScheme, lifecycleScheme)
//			set(IMaiaContextLifecycleService, lifecycleService)
//			set(IMaiaExecutorScheduler, sequenceContextScheduler)
//			set(IMaiaExecutorService, maiaExecutorService)
//			set(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}
}