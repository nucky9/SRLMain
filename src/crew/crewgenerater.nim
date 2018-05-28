import
  os,
  parsecsv,
  streams,
  random,
  ../helpers/settings,
  ../types/crewtypes

const
  maleNamesFile = "../assets/names/maleNames.csv"
  femaleNamesFile = "../assets/names/femaleNames.csv"
  lastNamesFile = "../assets/names/lastNames.csv"


proc generateGender*(): Gender =
  let randomRoll = rand(0..1)
  if randomRoll == 0:
    return female
  else:
    return male


proc generateFirstName*(gender: Gender): string =
  var
    p: CsvParser
    nameFile: string
  if gender == male:
    nameFile = maleNamesFile
  else:
    nameFile = femaleNamesFile

  p.open(nameFile)
  var numRows = 0
  while p.readRow():
    inc numRows
  p.close()
  p.open(nameFile)
  let randomRow = rand(0..<numRows)
  var i = 0
  while p.readRow():
    if i == (randomRow):
      p.close()
      return p.row[0]
    else:
      inc i

  p.close()


proc generateLastName*(): string =
  var
    p: CsvParser

  p.open(lastNamesFile)
  var numRows = 0
  while p.readRow():
    inc numRows
  p.close()
  p.open(lastNamesFile)
  let randomRow = rand(0..<numRows)
  var i = 0
  while p.readRow():
    if i == (randomRow):
      p.close()
      return p.row[0]
    else:
      inc i

  p.close()


proc generatePersonalityModifiers*(settings: GameSettings): seq[PersonalityModifier] =
  result = @[]
  for personality in PersonalityType:
    var
      modifier: int
      newPersonalityModifier: PersonalityModifier
      totalModifiers: int
    let randomRoll = rand(1..100)
    for entry in settings.personalityModifiers:
      if randomRoll <= entry[0]:
        modifier = entry[1]
        break
    newPersonalityModifier.personality = personality
    newPersonalityModifier.modifier = modifier
    totalModifiers += modifier # TODO: give penalties/bonuses depending total personality modifiers (so that characters that work well with others, may not be as talented, and vice versa)

    result.add(newPersonalityModifier)
         

proc generatePersonalityType*(): PersonalityType =
  let personalities = @[ptA, ptB, ptC, ptD, ptE]
  return rand(personalities)


proc generateSkillLevel*(): int =
  let 
    settings = getSettings()
    randomRoll = rand(1..100)
  
  var 
    modifier: int
  for entry in settings.abilityModifiers:
    if randomRoll <= entry[0]:
      modifier = entry[1]
      return modifier

proc generateSecondaryAbility*(): tuple[ability: SecondaryAbility, level: int] =
  var abilities: seq[SecondaryAbility] = @[]
  for ability in SecondaryAbility:
    abilities.add(ability)
  let 
    randomRoll = rand(0..abilities.high)
    abilityChosen = abilities[randomRoll]
    value = generateSkillLevel()

  result = (abilityChosen, value) 

proc generateBaseCrewInfo*(): BaseCrewInfo =
  let
    gender = generateGender()
    settings = getSettings()
  result = BaseCrewInfo(
    gender: gender,
    firstName: generateFirstName(gender),
    lastName: generateLastName(),
    experience: 0,
    level: 1,
    personalityType: generatePersonalityType(),
    personalityModifiers: generatePersonalityModifiers(settings)
  )