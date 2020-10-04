Enumeration
  #MainForm
EndEnumeration

Enumeration Sprite
  #Mouse2D
EndEnumeration

Procedure ScreenFocus(Window)
  Protected Focus.b, WMouseX, WMouseY
  
  WMouseX = WindowMouseX(Window)
  WMouseY = WindowMouseY(Window)
       
  MouseLocate(WMouseX, WMouseY)
  If WMouseX > 0 And WMouseX < ScreenWidth() - 1 And  
     WMouseY > 0 And WmouseY < ScreenHeight() -1
    ReleaseMouse(#False)      
    Focus = #True
  Else
    Focus = #False
    ReleaseMouse(#True)        
  EndIf
    
  ProcedureReturn Focus
EndProcedure


Procedure GamePreload()
  UsePNGImageDecoder()
  LoadSprite(#Mouse2D, "mousepointerred.png")
EndProcedure

Procedure GameUpdate()
  If ScreenFocus(#Mainform)
    DisplayTransparentSprite(#Mouse2D, MouseX(), MouseY())
  EndIf
EndProcedure    

Procedure GameStart()
  Protected cr.b = #True
  Protected Width = 800
  Protected Height = 600
  
  If InitSprite() = 0 Or InitKeyboard() = 0 Or InitMouse() = 0 And InitSound() = 0
    MessageRequester("Error", "Sprite system can't be initialized", 0)
    End
  EndIf
 
  If OpenWindow(#mainform, 0, 0, Width, Height, "New Game", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
    If OpenWindowedScreen(WindowID(#mainform), 0, 0, Width-100, Height-100)
      GamePreload()
    EndIf
  EndIf

  ;-Loop
  Repeat  
    Repeat
      Event = WindowEvent()
     
      Select event    
        Case #PB_Event_CloseWindow
          End
      EndSelect  
    Until event=0
    
    FlipBuffers()
    ClearScreen(RGB(245, 245, 220))
                
    ExamineKeyboard()
    ExamineMouse()
    GameUpdate()
  
  Until KeyboardPushed(#PB_Key_Escape)
EndProcedure

GameStart()
; IDE Options = PureBasic 5.71 LTS (Windows - x64)
; CursorPosition = 8
; FirstLine = 5
; Folding = -
; EnableXP