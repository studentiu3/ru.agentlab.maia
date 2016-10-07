/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.goal;

import org.semanticweb.owlapi.model.OWLAxiom;

public interface IGoalBase {

	boolean addGoal(Object event);

	boolean addGoal(OWLAxiom axiom);

	boolean removeGoal(Object event);

	boolean removeGoal(OWLAxiom axiom);

	default void addGoals(OWLAxiom... axioms) {
		for (OWLAxiom axiom : axioms) {
			addGoal(axiom);
		}
	}

	default void addGoals(Iterable<OWLAxiom> axioms) {
		for (OWLAxiom axiom : axioms) {
			addGoal(axiom);
		}
	}

	default void removeGoals(OWLAxiom... axioms) {
		for (OWLAxiom axiom : axioms) {
			removeGoal(axiom);
		}
	}

	default void removeGoals(Iterable<OWLAxiom> axioms) {
		for (OWLAxiom axiom : axioms) {
			removeGoal(axiom);
		}
	}

}
