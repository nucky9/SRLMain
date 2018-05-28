import
  blt,
  ../types/crewtypes,
  ../crew/crew

type
  PanelRect = ref object
    x: cint
    y: cint
    w: cint
    h: cint
  
let
  statusBarPanel = PanelRect(
    x: 1,
    y: 0,
    w: 14,
    h: 5
  ) 
  crewPanel = PanelRect(
    x: 110,
    y: 0,
    w: 40,
    h: 60  
  )

const
  windowSize = "window: size = 160x100"
  title = "title = SpaceRL"
  cellSize = "cellsize=8x8"
  statusFont = ("statusFont font: ../assets/fonts/SpaceMono-Regular.ttf, size=12, spacing=1.8x1")
  crewFont = ("crewFont font: ../assets/fonts/SpaceMono-Regular.ttf, size=12, spacing=1.8x1")
  titleFont = ("titleFont font: ../assets/fonts/SpaceMono-Bold.ttf, size=14, spacing=1.9x1")

proc printTextInPanel(panelRect: PanelRect, xPos, yPos: cint, message: string, font: string) =
  discard terminalPrint(panelRect.x + xPos, panelRect.y + yPos, "[font=" & font & "]" & message)


proc renderStatus() =
  printTextInPanel(statusBarPanel, 1, 0, "Prestige: ", "statusFont")
  printTextInPanel(statusBarPanel, 1, 3, "Stardate: ", "statusFont")
  

proc renderCrew*() =
  var currentLine = 0
  let
    crew = getCrew()
    newSectionRowOffset = 4
    newLineRowOffset = 3
  
  let crewText = "Crew [[HAR: " & $crew.crewHarmony & "]]"
  printTextInPanel(crewPanel, 1, currentLine.cint, crewText, "titleFont")
  currentLine += newSectionRowOffset + 1

  let captainSecondary = secondaryAbilityToText(crew.captain.secondaryAbility.ability)
  let captainTextTop = "1]] CPT " & crew.captain.baseInfo.lastName & ", " & crew.captain.baseInfo.firstName.substr(0, 0) & "." & " [[CPT: " & $crew.captain.captainAbility & " /" & captainSecondary & ": " & $crew.captain.secondaryAbility.level & "]]"
  let captainTextBottom = "[[LVL: " & $crew.captain.baseInfo.level & " /" & "XP: " & $crew.captain.baseInfo.experience & " /" & "HAP: " & $crew.captain.baseInfo.happiness & "]]"

  printTextInPanel(crewPanel, 1, currentLine.cint, captainTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, captainTextBottom, "crewFont")
  currentLine += newSectionRowOffset


  let scienceOffTextTop = "2]] SCI " & crew.science.baseInfo.lastName & ", " & crew.science.baseInfo.firstName.substr(0, 0) & "." & " [[XPL: " & $crew.science.exploration & " /SLV: " & $crew.science.problemSolving & "]]"
  let scienceOffTextBottom = "[[LVL: " & $crew.science.baseInfo.level & " /" & "XP: " & $crew.captain.baseInfo.experience & " /" & "HAP: " & $crew.science.baseInfo.happiness & "]]"

  printTextInPanel(crewPanel, 1, currentLine.cint, scienceOffTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, scienceOffTextBottom, "crewFont")
  currentLine += newSectionRowOffset


  let commsOffTextTop = "3]] COM " & crew.communications.baseInfo.lastName & ", " & crew.communications.baseInfo.firstName.substr(0, 0) & "." & " [[DIP: " & $crew.communications.diplomacy & " /LNG: " & $crew.communications.linguisticAbility & "]]"
  let commsOffTextBottom = "[[LVL: " & $crew.communications.baseInfo.level & " /" & "XP: " & $crew.communications.baseInfo.experience & " /" & "HAP: " & $crew.communications.baseInfo.happiness & "]]"
  
  printTextInPanel(crewPanel, 1, currentLine.cint, commsOffTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, commsOffTextBottom, "crewFont")
  currentLine += newSectionRowOffset


  let engOffTextTop = "3]] ENG " & crew.engineer.baseInfo.lastName & ", " & crew.engineer.baseInfo.firstName.substr(0, 0) & "." & " [[POW: " & $crew.engineer.powerManagement & " /RPR: " & $crew.engineer.repair & " /IMP: " & $crew.engineer.shipImprovements & "]]"
  let engOffTextBottom = "[[LVL: " & $crew.engineer.baseInfo.level & " /" & "XP: " & $crew.engineer.baseInfo.experience & " /" & "HAP: " & $crew.engineer.baseInfo.happiness & "]]"
  
  printTextInPanel(crewPanel, 1, currentLine.cint, engOffTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, engOffTextBottom, "crewFont")
  currentLine += newSectionRowOffset


  let medOffTextTop = "4]] MED " & crew.medical.baseInfo.lastName & ", " & crew.medical.baseInfo.firstName.substr(0, 0) & "." & " [[SUR: " & $crew.medical.surgicalAbility & " /DIS: " & $crew.medical.diseaseAnalysis & " /SCI: " & $crew.medical.scienceBonus & "]]"
  let medOffTextBottom = "[[LVL: " & $crew.medical.baseInfo.level & " /" & "XP: " & $crew.medical.baseInfo.experience & " /" & "HAP: " & $crew.medical.baseInfo.happiness & "]]"
  
  printTextInPanel(crewPanel, 1, currentLine.cint, medOffTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, medOffTextBottom, "crewFont")
  currentLine += newSectionRowOffset
  

  let navOffTextTop = "5]] NAV " & crew.navigation.baseInfo.lastName & ", " & crew.navigation.baseInfo.firstName.substr(0, 0) & "." & " [[MAN: " & $crew.navigation.maneuvering & " /CRS: " & $crew.navigation.coursePlotting & " /SPD: " & $crew.navigation.sublightSpeedModifier & "]]"
  let navOffTextBottom = "[[LVL: " & $crew.navigation.baseInfo.level & " /" & "XP: " & $crew.navigation.baseInfo.experience & " /" & "HAP: " & $crew.navigation.baseInfo.happiness & "]]"
  
  printTextInPanel(crewPanel, 1, currentLine.cint, navOffTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, navOffTextBottom, "crewFont")
  currentLine += newSectionRowOffset


  let tacOffTextTop = "6]] TAC " & crew.tactical.baseInfo.lastName & ", " & crew.tactical.baseInfo.firstName.substr(0, 0) & "." & " [[TRG: " & $crew.tactical.targetting & " /SHD: " & $crew.tactical.shieldModulation & " /SEC: " & $crew.tactical.security & "]]"
  let tacOffTextBottom = "[[LVL: " & $crew.tactical.baseInfo.level & " /" & "XP: " & $crew.tactical.baseInfo.experience & " /" & "HAP: " & $crew.tactical.baseInfo.happiness & "]]"
  
  printTextInPanel(crewPanel, 1, currentLine.cint, tacOffTextTop, "crewFont")
  currentLine += newLineRowOffset
  printTextInPanel(crewPanel, 4, currentLine.cint, tacOffTextBottom, "crewFont")
  currentLine += newSectionRowOffset
proc initTerminal*() =
  let windowSettings = windowSize & "," & title & "," & cellSize 
  discard terminalOpen()
  discard terminalSet(windowSettings)
  discard terminalSet(statusFont)
  discard terminalSet(crewFont)
  discard terminalSet(titleFont)
  

proc updateMainGUI*() =
  renderStatus()
  renderCrew()
  terminalRefresh()
  while terminalRead() != TK_ESCAPE:
    discard