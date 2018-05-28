# enums
type
  SpecialAbility* = enum
    asNone
  
  SecondaryAbility* = enum
    saEngineering,
    saScience,
    saWeapons,
    saHelm,
    saMedical,
    saCommunications

  PersonalityType* = enum
    ptA,
    ptB,
    ptC,
    ptD,
    ptE
  
  Gender* = enum
    male,
    female

type

  PersonalityModifier* = tuple[
    personality: PersonalityType,
    modifier: int
  ]

  BaseCrewInfo* = object
    gender*: Gender 
    firstName*: string
    lastName*: string
    experience*: int
    level*: int
    personalityType*: PersonalityType
    personalityModifiers*: seq[PersonalityModifier]
    happiness*: int
    
  Captain* = ref object
    baseInfo*: BaseCrewInfo
    captainAbility*: int
    secondaryAbility*: tuple[ability: SecondaryAbility, level: int]
    specialAbility*: SpecialAbility

  ScienceOfficer* = ref object
    baseInfo*: BaseCrewInfo
    exploration*: int
    problemSolving*: int
    specialAbility*: SpecialAbility
    
  CommunicationsOfficer* = ref object
    baseInfo*: BaseCrewInfo
    diplomacy*: int
    linguisticAbility*: int
    specialAbility*: SpecialAbility

  EngineeringOfficer* = ref object
    baseInfo*: BaseCrewInfo
    powerManagement*: int
    repair*: int
    shipImprovements*: int
    specialAbility*: SpecialAbility 

  MedicalOfficer* = ref object
    baseInfo*: BaseCrewInfo
    surgicalAbility*: int
    diseaseAnalysis*: int
    scienceBonus*: int
    specialAbility*: SpecialAbility

  NavigationOfficer* = ref object
    baseInfo*: BaseCrewInfo
    maneuvering*: int
    coursePlotting*: int
    sublightSpeedModifier*: int
    specialAbility*: SpecialAbility

  TacticalOfficer* = ref object
    baseInfo*: BaseCrewInfo
    targetting*: int
    shieldModulation*: int
    security*: int
    specialAbility*: SpecialAbility

  ShipCrew* = ref object
    captain*: Captain
    communications*: CommunicationsOfficer
    engineer*: EngineeringOfficer
    medical*: MedicalOfficer
    navigation*: NavigationOfficer
    science*: ScienceOfficer
    tactical*: TacticalOfficer
    personalitiesPresent*: seq[PersonalityType]
    crewHarmony*: int

