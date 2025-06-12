# Stage0 Design Thinking

Stage0 Design Thinking is heavily influenced by IBM enterprise design thinking. [Fran](./bots/FRAN.md) supports a design process that uses human centered techniques to help your team capture a system design. See [this article](https://www.surroundsightconsulting.com/blog/design-thinking) for deeper look into Design Thinking. If you have a few hours, take this [free IBM course](https://www.ibm.com/design/thinking/page/courses/Practitioner) on Enterprise Design Thinking.

Stage0 design thinking workshops are conducted in an on-line group text channel on Discord, rather than in person or virtually with stickies and sharpies. Each workshop consists of a series of stage0 design exercises. Each exercise consists of three parts: Observe (where we capture individual observations from the team), Reflect (where the team discusses observations to identify themes and patterns), and Make (where the team identifies actions to take based on the reflections).

## Exercises

- [Stakeholders](#stakeholders)
- [Empathy Mapping](#empathy-mapping)
- [Hills Ideation](#hills-ideation)
- [Prioritization](#prioritization)
- [Retrospectives](#retrospective)

---

## Stakeholders

The stakeholders exercise helps us to remain user focused by identifying all of the potential stakeholders in a platform. 

### Observations
Stakeholder observations are relatively simple—just a name or a title. During reflection, the team should work to identify who are hands-on users, and what type of RBAC roles are needed. 

### Outcomes
After reflection, the team should identify personas for all of the hands-on users, and schedule empathy mapping exercises for each of them. 

---

## Empathy Mapping

The purpose of an empathy mapping exercise is to help develop empathy for a user of the system, and inspire ideas about how a system can improve their life.

### Observations
Empathy observations identify things that the user does, says, feels, or thinks. During reflection, the team will identify key events in the user's work experience that drive positive or negative outcomes.

### Outcomes
After reflection, the team should be able to schedule Hills Ideation exercises to explore ways to improve the work experience.

---

## Hills Ideation

Hills Ideation exercises allow the team to identify the meaningful outcomes that the system should accomplish. 

### Observations
Hills observations are focused on identifying the who, what, and wow of a meaningful outcome. During reflection, the team should have common understandings about the different ideas for features in the system. 

### Outcomes
After reflection, the team should be able to schedule a prioritization exercise to help identify the most valuable hills.

---

## Prioritization

The prioritization exercise is designed to help the team identify the most valuable hills. 

### Observations
Prioritization observations consist of each member of the team individually ranking a collection of hills first by impact, then by feasibility.

### Outcomes
After the individual observations, the system will compute rankings *[schema](./specifications/dictionaries/observation_ranking.yaml)*:
- No-brainers: high feasibility and high impact
- Big-bets: low feasibility and high impact
- Utilities: high feasibility and low impact
- Unwise: low impact and low feasibility

The team can then place them in an appropriate location on the product roadmap.

---

## Retrospective

The retrospective exercise is designed to look back on work that's been done and identify ways to improve the process.

### Observations
Individual observations identify remaining **questions**, things that **worked well**, things that **didn't work so well**, and **new ideas to try** the next time.

### Outcomes
After reflection to establish common understanding, all items identified as **new ideas to try** should be assigned to someone to update documentation or revise processes and plans.

---

## Observation Schemas 
Observations collected during an exercise Will conform to a scheme a specific to that exercise. See the scheme is below for additional details.

| Exercise         | Observation Schema                                                                 |
|------------------|-----------------------------------------------------------------------------------|
| Stakeholders     | [observation_stakeholder.yaml](./specifications/dictionaries/observation_stakeholder.yaml) |
| Empathy Mapping  | [observation_empathy.yaml](./specifications/dictionaries/observation_empathy.yaml)         |
| Hills Ideation   | [observation_hills.yaml](./specifications/dictionaries/observation_hills.yaml)             |
| Prioritization   | [observation_priority.yaml](./specifications/dictionaries/observation_priority.yaml)       |
| Retrospective    | [observation_retrospective.yaml](./specifications/dictionaries/observation_retrospective.yaml) |

## Glossary

- **Hill**: A meaningful outcome of the system, expressed as "who does what and then WOW"
- **Persona**: A fictional character representing a user type, used to guide design decisions
- **RBAC**: Role-Based Access Control, a method of regulating access to resources based on user roles
- **Reflection**: The process of discussing and synthesizing observations to identify patterns and insights
- **Empathy Mapping**: An exercise to understand what a user does, says, thinks, and feels
- **Stakeholder**: Any person or group with an interest in the system
- **Prioritization**: The process of ranking features or outcomes by impact and feasibility
- **Retrospective**: A review of completed work to identify improvements for future processes
- **Observation**: A captured data point or insight from a participant during an exercise
