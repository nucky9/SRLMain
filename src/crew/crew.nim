import
  os,
  sequtils,
  parsecsv,
  streams,
  random,
  ../helpers/settings,
  ../types/crewtypes,
  crewgenerater,
  crewhappiness

var currentCrew: ShipCrew


proc generateCaptain*(): Captain =
  result = Captain(
    baseInfo: generateBaseCrewInfo(),
    captainAbility: generateSkillLevel(),
    secondaryAbility: generateSecondaryAbility(),
    specialAbility: asNone
  )


proc generateCommunicationsOfficer*(): CommunicationsOfficer =
  result = CommunicationsOfficer(
    baseInfo: generateBaseCrewInfo(),
    diplomacy: generateSkillLevel(),
    linguisticAbility: generateSkillLevel(),
    specialAbility: asNone
  )


proc generateEngineeringOfficer*(): EngineeringOfficer =
  result = EngineeringOfficer(
    baseInfo: generateBaseCrewInfo(),
    powerManagement: generateSkillLevel(),
    repair: generateSkillLevel(),
    shipImprovements: generateSkillLevel(),
    specialAbility: asNone
  )


proc generateMedicalOfficer*(): MedicalOfficer =
  result = MedicalOfficer(
    baseInfo: generateBaseCrewInfo(),
    surgicalAbility: generateSkillLevel(),
    diseaseAnalysis: generateSkillLevel(),
    scienceBonus: generateSkillLevel(),
    specialAbility: asNone
  )


proc generateNavigationOfficer*(): NavigationOfficer =
  result = NavigationOfficer(
    baseInfo: generateBaseCrewInfo(),
    maneuvering: generateSkillLevel(),
    coursePlotting: generateSkillLevel(),
    sublightSpeedModifier: generateSkillLevel(),
    specialAbility: asNone
  )


proc generateScienceOfficer*(): ScienceOfficer =
  result = ScienceOfficer(
    baseInfo: generateBaseCrewInfo(),
    exploration: generateSkillLevel(),
    problemSolving: generateSkillLevel(),
    specialAbility: asNone
  )


proc generateTacticalOfficer*(): TacticalOfficer =
  result = TacticalOfficer(
    baseInfo: generateBaseCrewInfo(),
    targetting: generateSkillLevel(),
    shieldModulation: generateSkillLevel(),
    security: generateSkillLevel(),
    specialAbility: asNone
  )


proc setCrew*(crew: ShipCrew) =
  currentCrew = crew

proc getCrew*(): ShipCrew =
  return currentCrew

proc secondaryAbilityToText*(ability: SecondaryAbility): string =
  case ability
    of saCommunications:
      return "COM"
    of saEngineering:
      return "ENG"
    of saHelm:
      return "NAV"
    of saMedical:
      return "MED"
    of saScience:
      return "SCI"
    of saWeapons:
      return "TAC"
    

proc generateCrew*(): ShipCrew =
  var newCrew = ShipCrew(
    captain: generateCaptain(),
    communications: generateCommunicationsOfficer(),
    engineer: generateEngineeringOfficer(),
    medical: generateMedicalOfficer(),
    navigation: generateNavigationOfficer(),
    science: generateScienceOfficer(),
    tactical: generateTacticalOfficer(),
  )
  newCrew.personalitiesPresent = getPersonalitiesPresent(newCrew)
  return newCrew

proc updateCrewHappiness*(crew: ShipCrew): ShipCrew =
  ## Calculates and returns individual crew happiness, as well as the overall happiness of the crew.
  var
    newCrew = ShipCrew()
    crewHappiness = 0
  newCrew = crew
  if not newCrew.captain.isNil:
    let happiness = getCrewMemberHappiness(newCrew.captain.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.captain.baseInfo.happiness = happiness
  if not newCrew.communications.isNil:
    let happiness = getCrewMemberHappiness(newCrew.communications.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.communications.baseInfo.happiness = happiness
  if not newCrew.engineer.isNil:
    let happiness = getCrewMemberHappiness(newCrew.engineer.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.engineer.baseInfo.happiness = happiness
  if not newCrew.medical.isNil:
    let happiness = getCrewMemberHappiness(newCrew.medical.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.medical.baseInfo.happiness = happiness
  if not newCrew.navigation.isNil:
    let happiness = getCrewMemberHappiness(newCrew.navigation.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.navigation.baseInfo.happiness = happiness
  if not newCrew.science.isNil:
    let happiness = getCrewMemberHappiness(newCrew.science.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.science.baseInfo.happiness = happiness
  if not newCrew.tactical.isNil:
    let happiness = getCrewMemberHappiness(newCrew.tactical.baseInfo, newCrew.personalitiesPresent)
    crewHappiness += happiness
    newCrew.tactical.baseInfo.happiness = happiness

  newCrew.crewHarmony = crewHappiness
  
  return newCrew

# TODO: need functions to add/remove officers from crew and update personalities present/happiness etc.

