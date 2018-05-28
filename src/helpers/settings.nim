import
  json

type
  GameSettings* = ref object
    personalityModifiers*: seq[tuple[chance:int, modifier: int]]
    abilityModifiers*: seq[tuple[chance:int, modifier: int]]

const
  jsonConfigFile = "../settings.json"

var
  gameSettings = GameSettings()

proc initSettings*() =
  gameSettings.personalityModifiers = @[]
  gameSettings.abilityModifiers = @[]
  
  var jsonConfig = parseFile(jsonConfigFile)
  let abilityModsJson = (jsonConfig["abilityModifiers"])
  for ability in abilityModsJson:
    let 
      chance = ability[0].getInt
      modifier = ability[1].getInt
      combo = (chance, modifier)
    gameSettings.abilityModifiers.add(combo) 

  let personalityModsJson = (jsonConfig["personalityModifiers"])
  for personality in personalityModsJson:
    let 
      chance = personality[0].getInt
      modifier = personality[1].getInt
      combo = (chance, modifier)
    gameSettings.personalityModifiers.add(combo) 
    

proc getSettings*(): GameSettings =
  return gameSettings
  


