#Requires AutoHotkey v2.0
#Include JSON.ahk
#SingleInstance Force

; Target process name for the official Steam client
TargetExe := "ahk_exe BlueArchive.exe"
CoordMode("Mouse", "Client")

;----------------------------------------------------------------

cafe() {
    ClickClient(150, 975)  ; Open Cafe from lobby
    VerifyStep("Starting Cafe")
    Sleep(5000)            ; Wait for load

    ClickClient(980, 980) ;clear visiting students notice
    Sleep(1000)

    ClickClient(1750, 990)  ; Earnings button
    Sleep(1200)
    ClickClient(960, 800)   ; Collect
    Sleep(2000)
    ClickClient(960, 800)   ; confirm
    Sleep(1200)

    ClickClient(75, 75)     ; exit earnings
    Sleep(1000)
    ClickClient(75, 75)     ; exit cafe
    VerifyStep("Cafe Complete")
    Sleep(4500)             ; wait for load
}

lesson(locations, ammounts) {
    ClickClient(315, 980) ; lesson
    VerifyStep("Starting Lessons")
    Sleep(2500)

    ClickClient(1450, 300) ; schale office (loop check init)
    Sleep(2000)
    currentLesson := 1

    loop locations.Length {
        if ammounts.Get(A_Index) == 0 {
            continue
        }
        location := locations.Get(A_Index)
        loop { ; loop until requested lesson is selected
            distance := GetClosest(location, currentLesson)
            if distance == 1 {
                ClickClient(1870, 540) ; right
            } else if distance == -1 {
                ClickClient(50, 540) ; left
            }
            Sleep(2000)

            currentLesson += GetClosest(location, currentLesson) ; update currentLesson
            if currentLesson == 13 {
                currentLesson := 1
            } else if currentLesson == 0 {
                currentLesson := 12
            }

        } until location == currentLesson
        
        ClickClient(1750, 1000) ; all locations
        Sleep(1000)

        loop ammounts.Get(A_Index) { ; loops ammount per lesson
            if A_Index == 1 {
                ClickClient(500, 380)
            } else if A_Index == 2 {
                ClickClient(1000, 380)
            } else if A_Index == 3 {
                ClickClient(1500, 380)                    
            } else if A_Index == 4 {
               ClickClient(500, 600) 
            } else if A_Index == 5 {
               ClickClient(1000, 600) 
            } else if A_Index == 6 {
               ClickClient(1500, 600) 
            } else if A_Index == 7 {
               ClickClient(500, 830) 
            }
            Sleep(1000)

            ClickClient(960, 840) ; start lesson
            Sleep(4000)
            ClickClient(960, 540) ; potential relationship rankup
            Sleep(1500)
            ClickClient(960, 540) ; potential rank title reward(20, 50, 100) 
            Sleep(1000)
            ClickClient(960, 840) ; confirm
            Sleep(1000)
        }

        ClickClient(75, 75) ; exit sublocations
        Sleep(1000)
    }

    ClickClient(75, 75) ; exit location
    Sleep(1200)

    ClickClient(75, 75) ; exit lessons
    VerifyStep("Lessons Complete")
    Sleep(3000)
}

club() {
    ClickClient(815, 975)   ; social
    VerifyStep("Starting Club")
    Sleep(1000)
    ClickClient(450, 550)   ; club
    Sleep(2000)             

    ClickClient(75, 75)     ; exit popup
    Sleep(1000)
    ClickClient(75, 75)     ; exit club
    VerifyStep("Club Complete")
    Sleep(4000)    
}

dailyPack() {
    ClickClient(200, 333)
    VerifyStep("Starting Daily Pack")
    Sleep(5000)
    ClickClient(1350, 270)  ; packs
    Sleep(1200)
    ClickClient(575, 725)   ; purchase
    Sleep(1200)
    ClickClient(1125, 890)   ; confirm
    Sleep(2000)
    
    ClickClient(1125, 890)     ; exit popup
    Sleep(1000)
    ClickClient(75, 75)     ; exit 
    VerifyStep("Daily Pack Complete")
    Sleep(3000)
}

shop() {
    ClickClient(1150, 980) ; shop
    VerifyStep("Starting Shop")
    Sleep(2500)

    ClickClient(1500, 360) ; advanced activity report
    Sleep(500)
    ClickClient(1725, 360) ; superior actiivty report
    Sleep(500)
    ClickClient(1500, 740) ; advanced enhancement stone
    Sleep(500)
    ClickClient(1725, 740) ; superior enhancement stone
    Sleep(1000)

    ClickClient(1750, 1000) ; purchase selected
    Sleep(1000)
    ClickClient(1150, 860) ; confirm
    Sleep(2000)
    ClickClient(960, 890) ; claim
    Sleep(1000)

    MouseMove(180, 800, 5)
    Sleep(100)
    Click("Down")
    Sleep(100)
    MouseMove(180, 180, 5)
    Sleep(100)
    Click("up")
    Sleep(1000)

    ClickClient(180, 425) ; tactical shop
    Sleep(500)

    ClickClient(1050, 360) ; lesser energy drink
    Sleep(500)
    ClickClient(1270, 360) ; normal energy drink
    Sleep(1000)

    ClickClient(1750, 1000) ; purchase selected
    Sleep(1000)
    ClickClient(1150, 860) ; confirm
    Sleep(2000)
    ClickClient(960, 890) ; claim
    Sleep(1000)

    ClickClient(75, 75)     ; exit 
    VerifyStep("Shop Complete")
    Sleep(3000)
}

recharge(ammount) {
    ClickClient(945, 50)
    VerifyStep("Starting AP Recharge")
    Sleep(1200)

    if ammount >= 3 {
        ClickClient(1625, 450) ; select max
        Sleep(500)
    } else if 0 < ammount < 3 {
        loop (ammount - 1) {
            ClickClient(1320, 520) ; +
            Sleep(200)
        }
    } else {
        MsgBox(("Invalid AP recharge ammount! (" . ammount . ")"), "Error", 64)
        return
    }
    Sleep(500)

    ClickClient(1150, 760) ; confirm
    Sleep(2000)
    ClickClient(960, 890) ; claim
    VerifyStep("AP Recharge Complete")
    Sleep(2500)
}

tasks() {
    ClickClient(70, 350)  ; tasks
    VerifyStep("Starting Tasks")
    Sleep(2500)

    ClickClient(1725, 1000) ; claim(1)
    Sleep(1200)
    ClickClient(960, 890) ; skip
    Sleep(500)
    ClickClient(960, 890) ; claim
    Sleep(1000)
    ClickClient(960, 890) ; claim
    Sleep(1000)
    ClickClient(1725, 1000) ; claim(2)
    Sleep(1000)
    ClickClient(960, 890) ; skip
    Sleep(500)
    ClickClient(960, 890) ; claim
    Sleep(1000)
    ClickClient(960, 890) ; claim
    Sleep(1000)
    ClickClient(1450, 1000) ; daily pyro
    Sleep(1200)
    ClickClient(960, 890) ; skip
    Sleep(1000)
    ClickClient(960, 890) ; claim
    Sleep(1000)

    ClickClient(75, 75) ; exit tasks
    VerifyStep("Tasks Complete")
    Sleep(3000)
}

mail() {
    ClickClient(1725, 50)  ; mail
    VerifyStep("Starting Mail")
    Sleep(2500)

    ClickClient(1700, 1000) ; claim
    Sleep(1000)
    ClickClient(960, 890) ; skip
    Sleep(500)
    ClickClient(960, 890) ; claim
    Sleep(1000)

    ClickClient(75, 75) ; exit mail
    VerifyStep("Mail Complete")
    Sleep(3000)
}

event(ammount) {
    ClickClient(1780, 300)
    VerifyStep("Starting Event")
    Sleep(3500)

    ClickClient(1400, 160) ; quest
    Sleep(1000)
    ClickClient(1700, 940) ; highest
    Sleep(1000)

    if ammount >= 99 {
        ClickClient(1625, 450) ; select max
        Sleep(500)
    } else if 0 < ammount < 99 {
        loop (ammount - 1) {
            ClickClient(1520, 450) ; +
            Sleep(200)
        }
    } else {
        MsgBox("Invalid events ammount!", "Error", 64)
        return
    }
    Sleep(500)

    ClickClient(1400, 600) ; sweep
    Sleep(1000)
    ClickClient(1150, 750) ; confirm
    Sleep(3000)
    if ammount >= 3 {
        ClickClient(960, 750) ; skip
    }
    Sleep(1000)
    ClickClient(960, 875) ; confirm rewards
    Sleep(1000)
    ClickClient(75, 75) ; exit popup
    Sleep(1000)

    ClickClient(75, 75) ; exit event
    VerifyStep("Event Complete")
    Sleep(3500)
}

campaign() {
    ClickClient(1775, 940)  ; campaign
    VerifyStep("Entering Campaign")
    Sleep(3500)
}

mission(presets, ammounts) {
    ClickClient(1230, 300) ;mission
    VerifyStep("Starting Missions")
    Sleep(2000)
    ClickClient(800, 880) ; multi-sweep
    Sleep(1000)

    loop presets.Length {
        if ammounts.Get(A_Index) == 0 {
            continue
        }
        ClickClient((presets.Get(A_Index) * 240) - 55, 240)
        Sleep(1000)

        if ammounts.Get(A_Index) >= 99 {
            ClickClient(1225, 890) ; select max
            Sleep(500)
        } else if 0 < ammounts.Get(A_Index) < 99 {
            loop (ammounts.Get(A_Index) - 1) {
                ClickClient(1125, 890) ; +
                Sleep(200)
            }
        }
        Sleep(500)

        ClickClient(1675, 890) ; multi-sweep
        Sleep(1000)
        ClickClient(1150, 880) ; confirm
        Sleep(3000)
        if ammounts.Get(A_Index) >= 3 {
            ClickClient(960, 750) ; skip
        }
        Sleep(1000)
        ClickClient(960, 875) ; confirm rewards
        Sleep(1000)
    }

    ClickClient(75, 75) ; exit multi-sweep
    Sleep(1000)

    ClickClient(75, 75) ; exit mission
    VerifyStep("Missions Complete")
    Sleep(1500)

}

bounty(bounties, ammounts) {
    ClickClient(1125, 560) ; bounty
    VerifyStep("Starting Bounty")
    sleep(2000)

    loop bounties.Length {
        if ammounts.Get(A_Index) == 0 {
            continue
        }
        if bounties.Get(A_Index) == "Overpass" {
            ClickClient(1500, 310)
        } else if bounties.Get(A_Index) == "Desert Railroad" {
            ClickClient(1500, 480)
        } else if bounties.Get(A_Index) == "Classroom" {
            ClickClient(1500, 650)
        } else {
            MsgBox(("Invalid bounty! (" . bounties.Get(A_Index) . ")"), "Error", 64)
            return
        }
        Sleep(1200)

        ClickClient(1680, 950) ; enter highest
        Sleep(1000)

        if ammounts.Get(A_Index) >= 6 {
            ClickClient(1625, 450) ; select max
            Sleep(500)
        } else if 0 < ammounts.Get(A_Index) < 6 {
            loop (ammounts.Get(A_Index) - 1) {
                ClickClient(1520, 450) ; +
                Sleep(200)
            }
        }
        Sleep(500)

        ClickClient(1400, 600) ; sweep
        Sleep(1000)
        ClickClient(1150, 750) ; confirm
        Sleep(3000)
        if ammounts.Get(A_Index) >= 3 {
            ClickClient(960, 750) ; skip
        }
        Sleep(1000)
        ClickClient(960, 875) ; confirm rewards
        Sleep(1000)

        ClickClient(75, 75) ; exit popup
        Sleep(1000)
        ClickClient(75, 75) ; exit selected bounty
        Sleep(1200)
    }

    ClickClient(75, 75) ; exit bounty
    VerifyStep("Bounties Complete")
    Sleep(1500)
}

commission(commissions, ammounts) {
    ClickClient(1125, 720) ; commission
    VerifyStep("Starting Commissions")
    Sleep(2000)

    loop commissions.Length {
        if ammounts.Get(A_Index) == 0 {
            continue
        }
        if commissions.Get(A_Index) == "Base Defence" {
            ClickClient(1500, 310)
        } else if commissions.Get(A_Index) == "Item Retrieval" {
            ClickClient(1500, 480)
        } else {
            MsgBox(("Invalid comission! (" . commissions.Get(A_Index) . ")"), "Error", 64)
            return
        }
        Sleep(1000)

        ClickClient(1680, 950) ; enter highest
        Sleep(1000)

        if ammounts.Get(A_Index) >= 99 {
            ClickClient(1625, 450) ; select max
            Sleep(500)
        } else if 0 < ammounts.Get(A_Index) < 99 {
            loop (ammounts.Get(A_Index) - 1) {
                ClickClient(1520, 450) ; +
                Sleep(200)
            }
        }
        Sleep(500)

        ClickClient(1400, 600) ; sweep
        Sleep(1000)
        ClickClient(1150, 750) ; confirm
        Sleep(3000)
        if ammounts.Get(A_Index) >= 3 {
            ClickClient(960, 750) ; skip
        }
        Sleep(1000)
        ClickClient(960, 875) ; confirm rewards
        Sleep(1000)

        ClickClient(75, 75) ; exit popup
        Sleep(1000)
        ClickClient(75, 75) ; exit selected commission
        Sleep(1200)
    }

    ClickClient(75, 75) ; exit commission
    VerifyStep("Commissions Complete")
    Sleep(1500)
}

scrimmage(scrimmages, ammounts) {
    ClickClient(1125, 870) ; scrimmage
    VerifyStep("Starting Scrimmage")
    sleep(2000)

    loop scrimmages.Length {
        if ammounts.Get(A_Index) == 0 {
            continue
        }
        if scrimmages.Get(A_Index) == "None" {
            continue
        } else if scrimmages.Get(A_Index) == "Trinity" {
            ClickClient(1500, 310)
            Sleep(2000)
        } else if scrimmages.Get(A_Index) == "Gehenna" {
            ClickClient(1500, 480)
            Sleep(2000)
        } else if scrimmages.Get(A_Index) == "Millennium" {
            ClickClient(1500, 650)
            Sleep(2000)
        } else {
            MsgBox(("Invalid srcimmage! (" . scrimmages.Get(A_Index) . ")"), "Error", 64)
            return
        }

        ClickClient(1680, 725) ; enter highest
        Sleep(1000)

        if ammounts.Get(A_Index) >= 6 {
            ClickClient(1625, 450) ; select max
            Sleep(500)
        } else if 0 < ammounts.Get(A_Index) < 6 {
            loop (ammounts.Get(A_Index) - 1) {
                ClickClient(1520, 450) ; +
                Sleep(200)
            }
        }
        Sleep(500)

        ClickClient(1400, 600) ; sweep
        Sleep(1000)
        ClickClient(1150, 750) ; confirm
        Sleep(3000)
        if ammounts.Get(A_Index) >= 3 {
            ClickClient(960, 750) ; skip
        }
        Sleep(1000)
        ClickClient(960, 875) ; confirm rewards
        Sleep(1000)

        ClickClient(75, 75) ; exit popup
        Sleep(1000)
        ClickClient(75, 75) ; exit selected scrimmage
        Sleep(1200)
    }

    ClickClient(75, 75) ; exit scrimmage
    VerifyStep("Scrimmages Complete")
    Sleep(2000)
}

tactical() {
    ClickClient(1325, 825) ; tactical
    VerifyStep("Starting Tactical Assault")
    Sleep(2000)

    loop 5 {
        ClickClient(930, 375) ; battle
        Sleep(1000)
        ClickClient(960, 860) ; attack
        Sleep(1500)
        ClickClient(1750, 1000) ; mobilize
        Sleep(4000)
        ClickClient(960, 1020) ; exit popup
        Sleep(1000)
        ClickClient(960, 1020) ; potential pyro milestone reward
        Sleep(1000)
        ClickClient(960, 1020) ; potential pyro milestone reward
        Sleep(1000)

        if A_Index == 5 {
            break
        } else {
            Sleep(22000) ; standby
        }
    }
    
    ClickClient(530, 575) ; time reward
    Sleep(1500)
    ClickClient(960, 790) ; claim
    Sleep(1000)
    ClickClient(530, 700) ; daily reward
    Sleep(1500)
    ClickClient(960, 790) ; claim
    Sleep(1200)

    ClickClient(75, 75) ; exit tactical
    VerifyStep("Tactical Assault Complete")
    Sleep(2500)
}

mainMenu() {
    ClickClient(75, 75)  ; main menu
    VerifyStep("Entering Main Menu")
    Sleep(3500)
}

;-----------load config.json---------------

config := "config.json"
if !FileExist(config) {
    MsgBox("missing config.json! check for the default config.json file in the selected release: https://github.com/Treason255/Blue-Archive-Macro/releases")
} else {
    data := JSON.Parse(FileRead(config))
}

;------------------ui----------------------

ui := Gui("+AlwaysOnTop +Owner", "BA macro")
tabs := ui.Add("Tab3","w600 h300", ["Cafe", "Lesson", "Club", "Daily Pack", "Missions", "Bounty", "Commission", "Scrimmage", "Tactical Challenge", "Shop", "Recharge", "Event", "Tasks", "Mail"])

;run
tabs.UseTab(0)
ui.Add("Button", "default Section", "Run").OnEvent("Click", runMacro)
ui.Add("Button", "default x+525 ys", "Save").OnEvent("Click", saveData)
;cafe
tabs.UseTab(1)
cafeInput := ui.Add("Checkbox",, "Enabled")
cafeInput.Value := data["Cafe"]["enabled"]

;lesson
tabs.UseTab(2)
lessonInput := ui.Add("Checkbox",, "Enabled")
lessonInput.Value := data["Lesson"]["enabled"]

lessonObjs := []
lessoncountObjs := []

ui.Add("Text", "Section", "Location: ")
lesson1 := ui.Add("DropDownList", "x+10", ["Schale Office", "Schale Residence Hall", "Gehhenna Hub", "Abydos Main Building", "Millennium Study Center", "Trinity Plaza Area", "Red Winter Federal Academy", "Hyakkiyako Central Area", "D.U. Shiratori City", "Shanhaijing Main Special Zone", "Haruhabara Electric Town", "Wildhunt Integrated Arts District"])
lesson1.Choose(data["Lesson"]["locations"][1]["location"])
ui.Add("Text", "x+40", "Lessons: ")
lesson1count := ui.Add("Edit", "x+10 Number" , data["Lesson"]["locations"][1]["amount"])
ui.Add("UpDown","Range1-7", 7)


lessonObjs.Push(lesson1)
lessoncountObjs.Push(lesson1count)
loop 6 {
    ui.Add("Text", "xs", "Location: ")
    lessonn := ui.Add("DropDownList","x+10", ["None", "Schale Office", "Schale Residence Hall", "Gehhenna Hub", "Abydos Main Building", "Millennium Study Center", "Trinity Plaza Area", "Red Winter Federal Academy", "Hyakkiyako Central Area", "D.U. Shiratori City", "Shanhaijing Main Special Zone", "Haruhabara Electric Town", "Wildhunt Integrated Arts District"])
    lessonn.Choose(data["Lesson"]["locations"][A_Index + 1]["location"])
    ui.Add("Text", "x+40", "Lessons: ")
    lessonncount := ui.Add("Edit", "x+10 Number" , data["Lesson"]["locations"][A_Index + 1]["amount"])
    ui.Add("UpDown","Range0-6", 0)

    lessonObjs.Push(lessonn)
    lessoncountObjs.Push(lessonncount)
}

;club
tabs.UseTab(3)
clubInput := ui.Add("Checkbox",, "Enabled")
clubInput.Value := data["Club"]["enabled"]

;pack
tabs.UseTab(4)
packInput := ui.Add("Checkbox",, "Enabled")
packInput.Value := data["Daily Pack"]["enabled"]

;mission
tabs.UseTab(5)
missionInput := ui.Add("Checkbox",, "Enabled")
missionInput.Value := data["Missions"]["enabled"]

missionObjs := []
ui.Add("Text", "Section", "Preset 1: ")
mission1 := ui.Add("Edit", "x+10 Number" , 99)
ui.Add("UpDown","Range1-99", data["Missions"]["presets"][1]["amount"])

missionObjs.Push(mission1)
loop 6 {
    ui.Add("Text", "xs", "Preset " . (A_Index + 1) . ": ")
    missionn := ui.Add("Edit", "x+10 Number" , 99)
    ui.Add("UpDown","Range0-99", data["Missions"]["presets"][A_Index + 1]["amount"])


    missionObjs.Push(missionn)
}

;bounty
tabs.UseTab(6)
bountyInput := ui.Add("Checkbox",, "Enabled")
bountyInput.Value := data["Bounty"]["enabled"]

bountyObjs := []

ui.Add("Text", "Section", "Overpass: ")
overpass := ui.Add("Edit", "x+10 Number" , 1)
ui.Add("UpDown"," Range0-6", data["Bounty"]["Overpass"])

ui.Add("Text", "xs", "Desert Railroad: ")
desertrailroad := ui.Add("Edit", "x+10 Number" , 1)
ui.Add("UpDown"," Range0-6", data["Bounty"]["Desert Railroad"])

ui.Add("Text", "xs", "Classroom: ")
classroom := ui.Add("Edit", "x+10 Number" , 1)
ui.Add("UpDown"," Range0-6", data["Bounty"]["Classroom"])

bountyObjs.Push(overpass, desertrailroad, classroom)

;commission
tabs.UseTab(7)
commissionInput := ui.Add("Checkbox",, "Enabled")
commissionInput.Value := data["Commission"]["enabled"]

commissionObjs := []

ui.Add("Text","Section", "Base Defence: ")
basedefence := ui.Add("Edit", "x+10 Number" , 99)
ui.Add("UpDown"," Range0-99", data["Commission"]["Base Defence"])

ui.Add("Text","xs", "Item Retrieval: ")
itemretrieval := ui.Add("Edit", "x+10 Number" , 99)
ui.Add("UpDown"," Range0-99", data["Commission"]["Item Retrieval"])

commissionObjs.Push(basedefence, itemretrieval)

;scrimmage
tabs.UseTab(8)
scrimmageInput := ui.Add("Checkbox",, "Enabled")
scrimmageInput.Value := data["Scrimmage"]["enabled"]

scrimmageObjs := []

ui.Add("Text","Section", "Trinity: ")
trinity := ui.Add("Edit", "x+30 Number" , 1)
ui.Add("UpDown"," Range0-6", data["Scrimmage"]["Trinity"])

ui.Add("Text","xs", "Gehenna: ")
gehenna := ui.Add("Edit", "x+30 Number" , 1)
ui.Add("UpDown"," Range0-6", data["Scrimmage"]["Gehenna"])

ui.Add("Text","xs", "Millennium: ")
millennium := ui.Add("Edit", "x+30 Number" , 1)
ui.Add("UpDown"," Range0-6", data["Scrimmage"]["Millennium"])

scrimmageObjs.Push(trinity, gehenna, millennium)

;tactical
tabs.UseTab(9)
tacticalInput := ui.Add("Checkbox",, "Enabled")
tacticalInput.Value := data["Tactical Challenge"]["enabled"]

;shop
tabs.UseTab(10)
shopInput := ui.Add("Checkbox",, "Enabled")
shopInput.Value := data["Shop"]["enabled"]

;recharge
tabs.UseTab(11)
rechargeInput := ui.Add("Checkbox",, "Enabled")
rechargeInput.Value := data["Recharge"]["enabled"]

ui.Add("Text", "Section", "Recharges: ")
recharges := ui.Add("Edit", "x+30 Number" , 1)
ui.Add("UpDown"," Range1-3", data["Recharge"]["amount"])

;event
tabs.UseTab(12)
eventInput := ui.Add("Checkbox",, "Enabled")
eventInput.Value := data["Event"]["enabled"]

ui.Add("Text", "Section", "Sweeps:")
events := ui.Add("Edit", "x+30 Number" , 10)
ui.Add("UpDown"," Range1-99", data["Event"]["amount"])

;tasks
tabs.UseTab(13)
tasksInput := ui.Add("Checkbox",, "Enabled")
tasksInput.Value := data["Tasks"]["enabled"]

;mail
tabs.UseTab(14)
mailInput := ui.Add("Checkbox",, "Enabled")
mailInput.Value := data["Mail"]["enabled"]

ui.Show("NoActivate")

;---------------save config----------------

saveData(*) {
    MsgBox("fake save")
}

;----------------run macro-----------------

runMacro(*) {
    global TargetExe
    if !WinExist(TargetExe) {
        MsgBox("Blue Archive PC client is not running!", "Error", 48)
        return
    }
    
    ; bring client to front
    WinActivate(TargetExe)
    WinWaitActive(TargetExe, , 3)

    ui.Hide

    Sleep(1000)

    location := "main"

    ; Coordinates are mapped for a 1920x1080 windowed client

    if cafeInput.Value == 1 {
        cafe() ; no invite or student relation click yet
    }

    if lessonInput.Value == 1 {
        lessons := []
        lessoncounts := []
        loop 7 {
            lessons.Push(lessonObjs.Get(A_Index).Value)
            lessoncounts.Push(lessoncountObjs.Get(A_Index).Value)
        }

        lesson(lessons, lessoncounts) ; ** accounts for relationship rankup but only 1 per lesson, really bandaid fix
    }

    if clubInput.Value == 1 {
        club()
    }

    if packInput.Value == 1 {
        dailyPack()
    }

    if missionInput.Value == 1 {
        if location == "main" {
            campaign()
            location := "campaign"
        }
        missions := []
        loop 7 {
            missions.Push(missionObjs.Get(A_Index).Value)
        }

        mission([1,2,3,4,5,6,7], missions)
    }

    if bountyInput.Value == 1 {
        if location == "main" {
            campaign()
            location := "campaign"
        }
        bounties := []
        loop 3 {
            bounties.Push(bountyObjs.Get(A_Index).Value)
        }

        bounty(["Overpass", "Desert Railroad", "Classroom"], bounties)
    }

    if commissionInput.Value == 1 {
        if location == "main" {
            campaign()
            location := "campaign"
        }
        commissions := []
        loop 2 {
            commissions.Push(commissionObjs.Get(A_Index).Value)
        }

        commission(["Base Defence", "Item Retrieval"], commissions)
    }

    if scrimmageInput.Value == 1 {
        if location == "main" {
            campaign()
            location := "campaign"
        }
        scrimmages := []
        scrimmagecounts := []
        loop 3 {
            scrimmages.Push(scrimmageObjs.Get(A_Index).Value)
        }

        scrimmage(["Trinity", "Gehenna", "Millennium"], scrimmages)
    }

    if tacticalInput.Value == 1 {
        if location == "main" {
            campaign()
            location := "campaign"
        }
        tactical()
    }

    if shopInput.Value == 1 {
        if location == "campaign" {
            mainmenu()
            location := "main"
        }
        shop() ; no selection system yet
    }

    if rechargeInput.Value == 1 {
        if location == "campaign" {
            mainmenu()
            location := "main"
        }

        recharge(recharges.Value)
    }

    if eventInput.Value == 1 {
        if location == "campaign" {
            mainmenu()
            location := "main"
        } else if location == "main" {
            campaign()
            mainMenu()
        }

        event(events.Value)
    }

    if tasksInput.Value == 1 {
        if location == "campaign" {
            mainmenu()
            location := "main"
        }
        tasks()
    }

    if mailInput.Value == 1 {
        if location == "campaign" {
            mainmenu()
            location := "main"
        }
        mail()
    }

    MsgBox("Loop completed!", "Success", 64)
    ExitApp()
}

GetClosest(a, b) { 
    if (a == b)
        return 0

    dist_add := Mod(a - b + 12, 12)
    
    dist_sub := Mod(b - a + 12, 12)

    if (dist_add <= dist_sub) {
        return 1
    } else if (dist_sub < dist_add) {
        return -1
    }
}

; Function to click relative to the inner game window (ignoring window title bar/borders)
ClickClient(x, y) {
    global TargetExe
    CoordMode("Mouse", "Client") ; Coordinates relative to the active game window
    
    ; Physically move cursor to position, pause briefly, then click
    MouseMove(x, y, 5)          ; 5 = speed (lower is faster)
    Sleep(100)
    Click("Left")
}

VerifyStep(stepName) {
    ToolTip(stepName)
    SetTimer(() => ToolTip(), -2000)
}

Esc::ExitApp()