import
  random,
  /crew/crew,
  /helpers/settings,
  /types/crewtypes,
  /gui/mainscreengui


randomize()
initSettings()

var currentCrew = generateCrew()
currentCrew = updateCrewHappiness(currentCrew)
setCrew(currentCrew)

initTerminal()
updateMainGUI()

