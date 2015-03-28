package ru.agentlab.maia.internal.platform

import java.util.ArrayList
import java.util.List
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.IServiceManagementService
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.context.ContextExtension
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.INameGenerator
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformId
import ru.agentlab.maia.platform.IPlatformIdFactory

class PlatformFactory implements IPlatformFactory {

	val static LOGGER = LoggerFactory.getLogger(PlatformFactory)

	extension ContextExtension = new ContextExtension(LOGGER)

	/**
	 * Create new Platform-Context with required platform-specific services:
	 * <ul>
	 * <li><code>IMessageFactory</code></li>
	 * <li><code>IMessageDeliveryService</code></li>
	 * </ul>
	 * and platform-specific configurations:
	 * <ul>
	 * <li><code>Name</code></li>
	 * <li><code>Contributor</code></li>
	 * <li><code>Context Type</code></li>
	 * </ul>
	 */
	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Default Platform...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	platform Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Create Platform-specific Services...")
		context.parent.get(IServiceManagementService) => [
			// Everybody can create messages
			copyFromRoot(context, IMessageFactory)
			// Everybody can create agents
			copyFromRoot(context, IAgentFactory)
			// Everybody can create containers
			copyFromRoot(context, IContainerFactory)
			// Everybody can create behaviours
			copyFromRoot(context, IBehaviourFactory)
			// Everybody can create schedulers
			copyFromRoot(context, ISchedulerFactory)
			// Everybody can create message queues
			copyFromRoot(context, IMessageQueueFactory)
		]

//		LOGGER.debug("	Put [{}] Service to context...", IMessageDeliveryService.simpleName)
//		val mtsFactory = context.parent.get(IMessageDeliveryServiceFactory)
//		ContextInjectionFactory.invoke(mtsFactory, PostConstruct, platformContext, null)
//		val mts = mtsFactory.create
//		platformContext.set(IMessageDeliveryService, mts)
		LOGGER.info("Create Platform ID...")
		val platformIdFactory = context.parent.get(IPlatformIdFactory)
		val platformId = platformIdFactory.create(context.get(KEY_NAME) as String)
		LOGGER.debug("	Put [{}] to context...", platformId)
		context.set(IPlatformId, platformId)

		LOGGER.info("Platform successfully created!")
		return context
	}

	/**
	 * Create empty context as child of root.
	 * Fill name and type properties
	 */
	override IEclipseContext createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Empty Platform...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	platform Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Platform successfully created!")
		return context
	}

	private def internalCreateEmpty(IEclipseContext root, String id) {
		val rootContext = if (root != null) {
				root
			} else {
				LOGGER.warn("Root context is null, get it from OSGI services...")
				EclipseContextFactory.getServiceContext(MaiaActivator.context)
			}

		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Platform Name...")
				val nameGenerator = rootContext.get(INameGenerator)
				val n = nameGenerator.generate(rootContext)
				LOGGER.debug("	Platform Name is [{}]", n)
				n
			}

		LOGGER.info("Create Platform Context...")
		val context = rootContext.createChild("Context for Platform: " + name) => [
			declareModifiable(KEY_CONTAINERS)
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, TYPE_PLATFORM)
		]

		LOGGER.info("Add link for parent Context...")
		var platforms = rootContext.get(KEY_PLATFORMS) as List<IEclipseContext>
		if (platforms == null) {
			LOGGER.debug("	Parent Context [{}] have no platforms link, create new list...", rootContext)
			platforms = new ArrayList<IEclipseContext>
			rootContext.set(KEY_PLATFORMS, platforms)
		}
		platforms += context
		return context
	}

}