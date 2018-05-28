import
  sequtils,
  ../types/crewtypes


proc getCrewMemberHappiness*(crewInfo: BaseCrewInfo, personalitiesPresent: seq[PersonalityType]): int =
  for personalityModifier in crewInfo.personalityModifiers:
    var numOfPersonalities = count(personalitiesPresent, personalityModifier.personality)
    # do not give a bonus or penalty for the crew members interaction with themselves
    # so, disregard one personality present that matches the current crew member's
    if personalityModifier.personality == crewInfo.personalityType:
      numOfPersonalities -= 1
    
    # if at least one other person with the personality current personality type from the modifiers list is present, multiply that personality's modifier, by the num of individuals in the crew with that type
    if numOfPersonalities >= 1:
      result += (numOfPersonalities * personalityModifier.modifier)

proc getPersonalitiesPresent*(crew: ShipCrew): seq[PersonalityType] =
  result = @[]
  result.add(crew.captain.baseInfo.personalityType)
  result.add(crew.captain.baseInfo.personalityType)
  result.add(crew.captain.baseInfo.personalityType)
  result.add(crew.communications.baseInfo.personalityType)
  result.add(crew.engineer.baseInfo.personalityType)
  result.add(crew.medical.baseInfo.personalityType)
  result.add(crew.navigation.baseInfo.personalityType)
  result.add(crew.science.baseInfo.personalityType)
  result.add(crew.tactical.baseInfo.personalityType)

  