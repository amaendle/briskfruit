' #############################################################################
' #############################################################################
'
' Deutsch:
' =========
' Dieser Quellcode ist von Folke Rinneberg
' Webseite: http://www.Rinneberg.de/programming/gfa.htm
' E-Mail:   Folke_R@gmx.de
'
' Du kannst diesen Quellcode frei nutzen, Veraendern und Erweitern.
' Es waehre nett, wenn du mir mitteilen wuerdest, wenn du diesen Quellcode
' benutzt/veraenderst oder erweiterst. Verbesserungen/Erweiterung wuerde 
' ich vielleicht gerne uebernehmen, Nutzung wuerde ich vielleicht gerne an
' dieser Stelle verlinken.
'
' Die Softwarequalitaet ist vermutlich nicht besonders hoch, da ich noch
' jung und unerfahren war, als ich ihn schrieb. Eine UEberarbeitung ist
' nicht geplant.
'
'
' English:
' =========
' This source code was written by Folke Rinneberg
' Web Site: http://www.Rinneberg.de/programming/gfa.htm#english
' e-mail:  Folke_R@gmx.de
'
' You are free to use, modify and extend this source code.
' It would be nice, if you contact me (e.g. by e-mail) when you 
' use/modify or extend this source code. Perhaps I would 
' put Improvements or extensions to this web site.
' Usage of this source code may be linked here.
'
' The quality of this source code may be quite low, because I was young and 
' had few experiences with programming when I wrote this source code. 
' I have no plans to improve this source code by myself.
'
' #############################################################################
' #############################################################################
'
'
PRINT "Working Directory:"
PRINT DIR$(0)
PRINT ENV$("PWD")
PRINT param$(1) 
'CHDIR "C:/Users/maendle.FASERINSTITUT/OneDrive/workingr/BASIC/brisk/"
'CHDIR "C:/Users/andem/OneDrive/workingr/BASIC/brisk/"
PRINT DIR$(0)
KEYUP%=273
KEYDOWN%=274
KEYRIGHT%=275
KEYLEFT%=276
KEYSPACE%=32
dim kb%(357)
dim mb$(10)
dim BachmA$(6)

  yellow=COLOR_RGB(1,1,0)
  blue=COLOR_RGB(0,0,1)
  black=COLOR_RGB(0,0,0)
  COLOR yellow,blue ! VG gelb, HG blau

Graphmode 1             !Grafikmodus=Repleace
Randomize Timer         !Zufallsgenerator mit Timer
Boundary 0              !Pboxen ohne Rand (Schneller)
'Defwrd "a-z"            !Alle Vareabeln sind anfangs Word-Voreabeln
'Deflist 3               !Spezielle Listart
Deffill 1,1             !F"+Chr$(129)+"llmuster=schwarz
clearw ! Pbox 0,0,639,399        !Bildschirm=schwarz
@Dims
@Prufen
Vsync
'Bmove Scr1%,Scr2%,32000
' Void Xbios(5,L:Scr1%,L:Scr2%,-1)
@Werte
@Werte2
@Anfangs
@Vorspann
@Level
@Anf_b_aufbau
@Main
Procedure Main
  ' Diese Procedure ist die hauptprocedur.Von hier aus werden die anderen
  ' Proceduren direkt oder indirekt angesprungen
  @put_pic(0,0,Hil$) !Put 0,0,Hil$                !Anzeigebalken Putten
'  SHOWPAGE !Bmove Scr1%,Scr2%,3200      !2.Screen auf den Anzeigescreen kopieren(Anzeigeleiste)
  Get A%,Y%,40,64,Back$ !Hintergrund der Frucht in back$ retten
  Aalt%=A%
  Yalt%=Y%
  Get 40,40,640,400,Scr1t$ ! HIntergrund mit allem!!!
  Do                          !Unendlichschleifenbeginn
    @handle_events()
    @Monster
    If A%>400                 !Wenn die Frucht zu weit rechts ist ,dann scrollen
	  @Hinter
    Endif
    If Bew%=10                !Figur bewegt sich nicht(man steht)!
      Ap%=1                   !letzte Richtung der Frucht ermitteln
      If Ri%=4
        Ap%=4
      Endif
      @put_back1 ! Put A%,Y%,Back$                         !Hintergrund der Frucht putten
	  Get A%,Y%,40,64,Back$
	  Aalt%=A%
      Yalt%=Y%
    '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&)) !put A%,Y%,S$(Ap%,Zu&+Skeletti&),4       !ausmaskiren
	  COLOR yellow,blue
      @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&)) !@put A%,Y%,Fig$(Ap%,Zu&+Skeletti&),6     !Frucht einsetzen
	  GRAPHMODE 1
      'Rc_copy Scr1%,A%,Y%,40,63 To Scr2%,A%,Y% !Bildausschnitt auf den anzeigescreen kopieren
    '  Put A%,Y%,Back$                        !Hintergrund der Frucht putten
	@show_wait
    Endif
	'@show_wait
    @Fall
    @Stones
    @Abfrage
    'If Inp(-2)                !Wenn eine Taste gedr"+Chr$(129)+"ckt wird, dann
    '  @Keyselect              !kontroliere welchen.
    '  Lpoke Xbios(14,1)+6,0
    'Endif
	'@show_wait
	
	'showpage
	'While Timer<Ts%+0.3
    'Wend
	'	Ts%=Timer ! ----------------
	'print "mainloop ende"
  Loop                        !Ende der Unendlichschleife
Return
Procedure Vsp
  ' Diese Procedure ist f"+Chr$(129)+"r den Sprung (nach oben)zust"+Chr$(132)+"ndig
  If Dielf%<>7            !Wenn man springen kann
    If HBew%=10             !Wenn man aus dem stand abspringt
      If Dielf%=0             !Wenn man auf keinem Magneten steht
        Hdauer|=16              !,dann darf man 16 Einheiten springen
      Else                    !Wenn man auf einem magneten steht
        Hdauer|=6               !,dann darf man 6 Einheiten springen
      Endif
    Else                    !Wenn man aus der Bewegung Springt
      If Dielf%=0             !Wenn man auf keinem Magnetem steht
        Hdauer|=21              !,dann darf man 21 Einheiten springen
      Else                    !Wenn man auf einem Magneten steht
        Hdauer|=11              !,dann darf man 11 Einheiten springen
      Endif
    Endif
  Else                    !Wenn man nicht springen darf,dann goto Nojump
    Goto Nojump
  Endif
  Dauer|=0                !bisherige Sprungdauer=0
  If (A% Mod 40)=0          !Wenn an in der Mitte eines Steines steht
    Select C|(CX%-15+(A%-1)/40+1,Y%/40+2)
    Case 13,14,57  !13 To 14,57      !Drehsteine beim Absprung um eine Sequenz erh"+Chr$(148)+"hen
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)+1
      @put_pic(A%,Y%+63,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2))) !Put A%,Y%+63,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2)) !Putten
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63  !R"+Chr$(129)+"ber kopieren
    Case 59,15            !Drehsteine beim absprung von der letzten auf die erste Sequenz
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)-3
      @put_pic(A%,Y%+63,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2))) !Put A%,Y%+63,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2)) !Putten
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63  !R"+Chr$(129)+"ber kopieren
    Endselect
  Else                    !Wenn man nicht in der mitte eines Steines steht
    '                      Man steht also auf zwei Steinen
    Select C|(CX%-15+(A%+1)/40,Y%/40+2)  !linker Stein selectieren
    Case 13,14,57 !13 To 14,57  !Beim Absprung die Drehsteine um eine Sequenz erh"+Chr$(148)+"hen
      C|(CX%-15+(A%+1)/40,Y%/40+2)=C|(CX%-15+(A%+1)/40,Y%/40+2)+1
      HilA%=(A%+1)/40                   !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      HilY%=Y%/40+2                     !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      @put_pic(HilA%*40,HilY%*40,B$(C|(CX%-15+(A%+1)/40,Y%/40+2))) !Put HilA%*40,HilY%*40,B$(C|(CX%-15+(A%+1)/40,Y%/40+2)) !putten
      'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40 !R"+Chr$(129)+"ber kopieren
    Case 15,59        !Beim Absprung von der letzten Sequenz zur ersten Sequenz ders Drehsteines
      C|(CX%-15+(A%+1)/40,Y%/40+2)=C|(CX%-15+(A%+1)/40,Y%/40+2)-3
      HilA%=(A%+1)/40                   !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      HilY%=Y%/40+2                     !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      @put_pic(HilA%*40,HilY%*40,B$(C|(CX%-15+(A%+1)/40,Y%/40+2))) !Put HilA%*40,HilY%*40,B$(C|(CX%-15+(A%+1)/40,Y%/40+2)) !putten
      'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40 !R"+Chr$(129)+"ber kopieren
    Endselect
    Select C|(CX%-15+(A%-1)/40+1,Y%/40+2) !rechter Stein selectieren
    Case 13,14,57 !13 To 14,57  !Beim Absprung die Drehsteine um eine Sequenz erh"+Chr$(148)+"hen
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)+1
      HilA%=(A%-1)/40+1                 !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      HilY%=Y%/40+2                     !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      @put_pic(HilA%*40,HilY%*40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2))) !Put HilA%*40,HilY%*40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2))
      'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
    Case 15,59        !Beim Absprung von der letzten Sequenz zur ersten Sequenz ders Drehsteines
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)-3
      HilA%=(A%-1)/40+1                 !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      HilY%=Y%/40+2                     !zur Verk"+Chr$(129)+"rzung der n"+Chr$(132)+"chsten Zeilen
      @put_pic(HilA%*40,HilY%*40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2))) !Put HilA%*40,HilY%*40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+2)) !putten
      'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40 !r"+Chr$(129)+"ber kopieren
    Endselect
  Endif
  Repeat
  '---
    @handle_events()
	'---
    @Monster
    'Spieler2|=Stick(1)  !Spieler2|=Joy-Stick-Wert
    Add Dauer|,1        !Erh"+Chr$(148)+"hung der Dauer des sprunges
    'Select Spieler2|    !Auswertung des Vom Joy_Stick gelieferten Wertes
	Spieler2|=0
    If kb%(KEYRIGHT%)=1 and kb%(KEYLEFT%)=0 and kb%(KEYUP%)=1 !Case 9              !Rechts-Hoch
      Endf%=8           !Die X-Koordinate wird um 8 erh"+Chr$(148)+"ht werden
      Ap%=1             !Zu puttende Frucht-Richtung "+Chr$(132)+"ndern
      Ri%=3
	  Spieler2|=9
    Else If kb%(KEYRIGHT%)=0 and kb%(KEYLEFT%)=1 and kb%(KEYUP%)=1  !Case 5              !Links-Hoch
      Endf%=-8          !Die x-Koordinate wird um 8 gesenkt werden
      Ap%=4             !Zu puttende Frucht-Richtung "+Chr$(132)+"ndern
      Ri%=4
	  Spieler2|=5
    Else If kb%(KEYUP%)=1 !Case 1              !Senkrecht-Hoch
      Ap%=1
      If Ri%=4
        Ap%=4
      Endif
      Endf%=0           !Die X-Koordinate wird gleich bleiben
	  Spieler2|=1
	ENDIF
    Endselect
    Ends|=8             !Die Y-koordinate wird um 8 gesenkt werden
    Hhs&=0
    If Y%>=-71 !Y%>7        !Wenn die Frucht nicht oben aus dem Bildschirm gesprungen ist
      @put_back1 ! Put A%,max(Y%,0),Back$                     !,dann putte den Hinrtergrund
      Get A%,max(Y%,0),40,64+min(0,Y%),Back$         !Gette den Hintergrund
	  Aalt%=A%
      Yalt%=max(Y%,0)
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&)) !Put A%,Y%,S$(Ap%,Zu&+Skeletti&),4   !Aus dem Hintergrund die Frucht ausmaskiren
	  COLOR yellow,blue
      @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&)) !Put A%,Y%,Fig$(Ap%,Zu&+Skeletti&),6 !Die Frucht einsetzen
	  GRAPHMODE 1
	 ' @show_wait
	  '---
      'If A%>1                             !Wenn die Frucht nicht am linken Blidschirmrand setht
        'Rc_copy Scr1%,A%-8,Y%,56,72 To Scr2%,A%-8,Y%!Kopiere sie R"+Chr$(129)+"ber
      'Else                                   !Andenfalls
        'Rc_copy Scr1%,A%,Y%,48,72 To Scr2%,A%,Y%    !Kopiere nicht ganz so viel r"+Chr$(129)+"ber
      'Endif
      @put_back1  !Put A%,max(Y%,0),Back$                     !Hintergrund Putten
	'  Back$ =""
    '  Ahvsp&=A%                           !X-Wert in ahvsp$ merken
    '  Yhvsp&=Y%                           !Y-Wert in yhvsp$ merken
    Endif
    If Y%<-71 !Y%<0
      'Rc_copy Scr1%,Ahvsp&,Yhvsp&,40,72 To Scr2%,Ahvsp&,Yhvsp&
	  print "obenrausA",Y%
	 ' @show_wait
    Endif
    If Y%>7 !Y%>-71 !Y%>7  ???                                !Wenn die Frucht den oberen Bildschirmrand nicht verlassen hat
      If ((Y%-14) Mod 40)<=3  !40=<3                     !Wenn die Frucht den unteren Bildschirmrand nicht verlassen hat
        If (A% Mod 40)=0        !             *1*  Wenn die Frucht sich genau senkrecht "+Chr$(129)+"ber ** einem ** Stein befindet
          If C|(CX%-15+(A%-1)/40+1,Y%/40)>0        !Wenn ein Stein auf Kopfh"+Chr$(148)+"he der Frucht ist
            If C|(CX%-15+(A%-1)/40+1,Y%/40)=60       !Wenn der Stein zertr"+Chr$(129)+"mmerbar ist
              C|(CX%-15+(A%-1)/40+1,Y%/40)=0         !,dann l"+Chr$(148)+"sche den Stein aus dem Feld
			  COLOR blue,yellow
              'Deffill 0,0,0                          !F"+Chr$(129)+"llmuster=Wei"+Chr$(158)+"
              Pbox A%,Int(Y%/40)*40,A%+39,Int(Y%/40)*40+39 !Male an der Stelle des Steines eine wei"+Chr$(158)+"e pbox
			     COLOR yellow,blue
              Get A%,max(Y%,0),40,64+min(Y%,0),Back$            !Gette den Hinterhrund der Frucht neu
			  Aalt%=A%
              Yalt%=max(Y%,0) !Y%
              'Rc_copy Scr1%,A%,Int(Y%/40)*40,40,40 To Scr2%,A%,Int(Y%/40)*40  !Kopiere den wei"+Chr$(158)+"en Kasten r"+Chr$(129)+"ber
              Add Punkte%,7                          !Erh"+Chr$(148)+"he die Punktzahl des Spielers um 7
              @Fall
              @Stones
            Else if C|(CX%-15+(A%-1)/40+1,Y%/40)=8   !Wenn Der Stein "+Chr$(129)+"ber der Frucht ein Aufwind-Stein ist
              For I%=0 To 14                         !15 Durch l"+Chr$(132)+"ufe !I&
                If Y%>7                                !Wenn die Frucht im Sichtbereich ist
                  Ap%=1
                  If Ri%=4                             !Richtung f"+Chr$(129)+"r das malen der Frucht ermitteln
                    Ap%=4
                  Endif
				  @put_back1
                  'Put A%,Y%,Back$                      !Hintergrund putten
	  			  '---
	              GRAPHMODE 2
	              COLOR blue,yellow
                  @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&))  !Put A%,Y%,S$(Ap%,Zu&+Skeletti&),4    !Frucht ausmaskieren
				  COLOR yellow,blue
                  @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&))  !Put A%,Y%,Fig$(Ap%,Zu&+Skeletti&),6  !Frucht putten
				  GRAPHMODE 1
				 ' @show_fig_wait() !@show_wait
				  print "vsp mess2b"
                  'Rc_copy Scr1%,A%,Y%,40,71 To Scr2%,A%,Y% !R"+Chr$(129)+"ber kopieren
                  @put_back1 !Put A%,Y%,Back$                      !Hintergrund malen
                  Sub Y%,8                             !Y-Koordinate um 8 senken
                  Get A%,max(Y%,0),40,64+min(Y%,0),Back$          !Hintergrund neu Getten
				  Aalt%=A%
                  Yalt%=max(Y%,0) !Y%
                Endif
              Next I%                                !Ende der 15 Durchl"+Chr$(132)+"ufe
            Else if C|(CX%-15+(A%-1)/40+1,Y%/40)<>100 !wenn es sich nicht um den Stengel einer Pflanze handelt
              @Fall
              @Stones
			  'mache showfigure funktion?
				'  @show_fig_wait() !@show_wait
				  print "vsp mess2c frucht sonst unsichtbar"
            Endif
          Endif
        Else                   !Wenn "+Chr$(129)+"ber der Frucht 2 Steine sein k"+Chr$(148)+"nnten
          If C|(CX%-15+(A%+1)/40,Y%/40)+C|(CX%-15+(A%-1)/40+1,Y%/40)>0
            If C|(CX%-15+(A%+1)/40,Y%/40)=60
              C|(CX%-15+(A%+1)/40,Y%/40)=0
              HilA%=(A%+1)/40
              HilY%=Y%/40
              Add Punkte%,7 !Das selbe Verfahren, wie oben bei *1* nur f"+Chr$(129)+"r beide m"+Chr$(148)+"glichen Steine
              COLOR blue,yellow 
			  'Deffill 0,0,0
              Pbox HilA%*40,HilY%*40,HilA%*40+39,HilY%*40+39
			  COLOR yellow,blue
              Get A%,max(Y%,0),40,64+min(Y%,0),Back$
			  Aalt%=A%
              Yalt%=max(Y%,0) !Y%
				 ' @show_fig_wait() !@show_wait
              'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
            Endif
            If C|(CX%-15+(A%-1)/40+1,Y%/40)=60
              C|(CX%-15+(A%-1)/40+1,Y%/40)=0
              HilA%=(A%-1)/40+1
              HilY%=Y%/40
              Add Punkte%,7
              Deffill 0,0,0
			  COLOR blue,yellow 
              Pbox HilA%*40,HilY%*40,HilA%*40+39,HilY%*40+39
			  COLOR yellow,blue
				'  @show_fig_wait() !@show_wait
              Get A%,max(Y%,0),40,64+min(Y%,0),Back$
			  Aalt%=A%
              Yalt%=max(Y%,0) !Y%
              'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
            Endif
            If C|(CX%-15+(A%+1)/40,Y%/40)=8 Or C|(CX%-15+(A%-1)/40+1,Y%/40)=8
              For I%=0 To 14 !I&
                If Y%>7
                  Ap%=1
                  If Ri%=4
                    Ap%=4
                  Endif
                  @put_back1 !Put A%,Y%,Back$
				  '---
	              GRAPHMODE 2
	              COLOR blue,yellow
                  @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&))  !Put A%,Y%,S$(Ap%,Zu&+Skeletti&),4
				  COLOR yellow,blue
                  @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&))  !Put A%,Y%,Fig$(Ap%,Zu&+Skeletti&),6
				  GRAPHMODE 1
				 ' @show_fig_wait() !@show_wait
			''	  print "vsp mess3c"
			'	  pause 4
				 ' @put_back
			'	  print "vorfehler"
                  'Rc_copy Scr1%,A%,Y%,40,71 To Scr2%,A%,Y%
                  @put_back1 !Put A%,Y%,Back$
		'		  print "nachfehler?"
                  Sub Y%,8
                  Get A%,max(Y%,0),40,64+min(Y%,0),Back$
				  Aalt%=A%
                  Yalt%=max(Y%,0) !Y%
                Endif
              Next I%
            Else if C|(CX%-15+(A%+1)/40,Y%/40)=0 And C|(CX%-15+(A%-1)/40+1,Y%/40)=100
				  '@show_fig_wait() !@show_wait
				  print "stengela"
            Else if C|(CX%-15+(A%+1)/40,Y%/40)=100 And C|(CX%-15+(A%-1)/40+1,Y%/40)=0
				 ' @show_fig_wait() !@show_wait
				  print "stengelb"
            Else if C|(CX%-15+(A%+1)/40,Y%/40)=100 And C|(CX%-15+(A%-1)/40+1,Y%/40)=100
				 ' @show_fig_wait() !@show_wait
				  print "stengelc"
              ' es ist ein Pflanzenstengel und Luft oder es sind zwei Pflanzenstengel
            Else
              @Fall
              @Stones
				'  @show_fig_wait() !@show_wait
				  print "vsp mess4d"
            Endif
          Endif
        Endif
      Endif
      If (A% Mod 40)=0   !Wenn die Frucht senkrecht "+Chr$(129)+"ber einem Stein ist, dann mu"+Chr$(158)+" abgefragt werden, ob der Frucht ein Hindernis im Weg steht
        @Forn_abfrage_o
      Endif
    Else  ! ueber oberem Bildschirmrand... pause/show_wait fuer timing
      If (A% Mod 40)=0   !Wenn die Frucht genau "+Chr$(129)+"ber einem Stein ist
        If Endf%>0       !Wenn sie nach rechts oben springs
          If C|(CX%-15+(A%-1)/40+2,0)>0 !Wenn ihr ein Hindernis im weg ist
            Endf%=0                     !,dann springt sie senkrecht weiter
          Endif
        Else if Endf%<0  !Wenn sie nach links oben springt
          If C|(CX%-15+(A%-1)/40,0)>0   !Wenn ihr ein Hindernis im weg ist
            Endf%=0                     !,dann springt sie senkrecht weiter
          Endif
        Endif
      Endif
				  '@show_wait
				  print "vsp obenrausB"
    Endif
	@show_fig_wait() !@show_wait!nurhier und oben auskommentieren
    A%=A%+Endf%                         !X-Wert wird um endf erh"+Chr$(148)+"ht (+8/-8/0)
    Y%=Y%-Ends|                         !Y-wert wird um ends| ernidrigt (8/0)
    If A%<0                             !Wenn die Frucht links raus ist
      A%=0                              !,dann ist sie am linken Rand
    Endif
    If A%>400                           !Wenn die Frucht zu weit rechts ist
      @Hinter                           !,dann wird weiter gescreollt
'	  pause 4
    Endif
    If Y%>-71   !Y%>7                          !Wenn sie im Sichtbereich ist
      Get A%,max(Y%,0),40,64+min(Y%,0),Back$         !Hintergrund getten
	  Aalt%=A%
      Yalt%=max(Y%,0) !Y%
    Endif
    Nojump:            !Hier gehts weiter falls die Frucht nicht springen durfte
  Until Spieler2|<>1 And Spieler2|<>9 And Spieler2|<>5 Or Dauer|>Hdauer| !Wenn der Joy-Stick nicht mehr nach oben gerichtet ist oder die maximale Sprungdauer erreicht ist, dann ist der Sprung zu ende
Return
Procedure Vor
  @put_back1 ! Put A%,Y%,Back$ !Hintergrund putten
  If (A% Mod 40)=0 !Wenn die Frucht genau auf einem Stein steht
    If C|(CX%-15+(A%-1)/40+2,Y%/40+1)+C|(CX%-15+(A%-1)/40+2,Y%/40)=0 !Wenn beide Stellen, an denen ein Stein St"+Chr$(148)+"ren w"+Chr$(129)+"rde keiner ist
      A%=A%+8                               !lasse die Frucht um 8 Pixel vorr"+Chr$(129)+"cken
    Else if C|(CX%-15+(A%-1)/40+2,Y%/40+1)=100 !Wenn der Stein vor der Frucht auch nicht der Stiel einer Kletterpflanze ist
      A%=A%+8                               !lasse die Frucht um 8 Pixel vorr"+Chr$(129)+"cken
    Else if C|(CX%-15+(A%-1)/40+2,Y%/40+1)=47!Wenn der Stein vor der Frucht eine Rollkiste ist
      If C|(CX%-15+(A%-1)/40+2,Y%/40)=0        !Wenn "+Chr$(129)+"ber der Kiste kein Stein ist(nur dann kann sie geschoben werden!)
        If C|(CX%-15+(A%-1)/40+3,Y%/40+1)=0      !Wenn der Kiste kein Stein im Weg ist
          C|(CX%-15+(A%-1)/40+2,Y%/40+1)=0         !lasse die Kiste rollen
          C|(CX%-15+(A%-1)/40+3,Y%/40+1)=47        !lasse die Kiste rollen
          @put_pic(Int((A%-1)/40+3)*40,Int(Y%/40+1)*40,B$(47)) !Put Int((A%-1)/40+3)*40,Int(Y%/40+1)*40,B$(47)!lasse die Kiste rollen
		  COLOR black,yellow 
          Pbox Int((A%-1)/40+2)*40,Int(Y%/40+1)*40,Int((A%-1)/40+2)*40+39,Int(Y%/40+1)*40+39!lasse die Kiste rollen
		  COLOR yellow,blue
		  @show_wait
		  pause 3
          'Rc_copy Scr1%,Int((A%-1)/40+2)*40,Int(Y%/40+1)*40,80,40 To Scr2%,Int((A%-1)/40+2)*40,Int(Y%/40+1)*40!lasse die Kiste rollen
          Kh&=0                                  !Falltiefe=0
          While C|(CX%-15+(A%-1)/40+3,Y%/40+2+Kh&)=0 And Y%/40+Kh&<=8 !solange unter dem neuen Standpunkt der Kiste kein Stein ist
            C|(CX%-15+(A%-1)/40+3,Y%/40+1+Kh&)=0      !lasse die Kiste fallen
            C|(CX%-15+(A%-1)/40+3,Y%/40+2+Kh&)=47     !lasse die Kiste fallen
            @put_pic(Int((A%-1)/40+3)*40,Int(Y%/40+2+Kh&)*40,B$(47)) !Put Int((A%-1)/40+3)*40,Int(Y%/40+2+Kh&)*40,B$(47)!lasse die Kiste fallen
			COLOR black,yellow 
            Pbox Int((A%-1)/40+3)*40,Int(Y%/40+1+Kh&)*40,Int((A%-1)/40+3)*40+39,Int(Y%/40+1+Kh&)*40+39!lasse die Kiste fallen
			COLOR yellow,blue
			@show_wait
			pause 3
            'Rc_copy Scr1%,Int((A%-1)/40+3)*40,Int(Y%/40+1+Kh&)*40,40,80 To Scr2%,Int((A%-1)/40+3)*40,Int(Y%/40+1+Kh&)*40!lasse die Kiste fallen
            Inc Kh&                                !erh"+Chr$(148)+"he die Falltiefe
          Wend
        Endif
      Endif
    Else !wenn ein stein im Weg ist
      O|=((O|+1) Mod 3)                     !"+Chr$(142)+"ndere die Gehsequenz
      '------
	  GRAPHMODE 2
      COLOR blue,yellow
      @put_pic(A%,Y%,S$(O|,Zu&+Skeletti&)) !Put A%,Y%,S$(O|,Zu&+Skeletti&),4        !Maskiere sie aus dem Hintergrund aus
	  COLOR yellow,blue
      @put_pic(A%,Y%,Fig$(O|,Zu&+Skeletti&)) !Put A%,Y%,Fig$(O|,Zu&+Skeletti&),6      !Male sie hin
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,A%,Y%,40,63 To Scr2%,A%,Y% !Kopiere sie r"+Chr$(129)+"ber (auf den anzeige screen)
      Goto Hilf1
    Endif
  Else                                 !Wenn die Frucht nicht genau auf einem Stein steht, dann lasse sie weiter gehen.
    A%=A%+8
  Endif
  Get A%,Y%,40,64,Back$              !Rette den hintergrund
  Aalt%=A%
  Yalt%=Y%
  O|=((O|+1) Mod 3)                      !"+Chr$(142)+"ndere die Gehsequenz
  '------
  GRAPHMODE 2
  COLOR blue,yellow
  @put_pic(A%,Y%,S$(O|,Zu&+Skeletti&)) ! Put A%,Y%,S$(O|,Zu&+Skeletti&),4         !Maskiere sie aus
  COLOR yellow,blue
  @put_pic(A%,Y%,Fig$(O|,Zu&+Skeletti&)) ! Put A%,Y%,Fig$(O|,Zu&+Skeletti&),6       !male sie hin
  GRAPHMODE 1
  '---
  'Rc_copy Scr1%,A%-8,Y%,48,63 To Scr2%,A%-8,Y% !kopiere sie r"+Chr$(129)+"ber
  'Put A%,Y%,Back$                        !Restaurire den Hintergrund
  Hilf1:
  @show_wait
Return
Procedure Zur
  @put_back1 ! Put A%,Y%,Back$                              !Hintergrund malen
  If (A% Mod 40)=0                               !Wenn die Frucht auf nur einem Stein
    If C|(CX%-15+(A%-1)/40,Y%/40+1)+C|(CX%-15+(A%-1)/40,Y%/40)=0!Wenn Ihr nichts im Weg ist
      A%=A%-8                                  !lass Sie gehen
    Else if C|(CX%-15+(A%-1)/40,Y%/40+1)=100   !Wenn der Stamm einer Kletterpflanze im Weg ist
      Sub A%,8                                 !dann lasse die Frucht weiter gehen
    Else if C|(CX%-15+(A%-1)/40,Y%/40+1)=47    !Wenn ein Rollkasten vor ihr ist
      If A%>60
        If C|(CX%-15+(A%-1)/40,Y%/40)=0
          If C|(CX%-15+(A%-1)/40-1,Y%/40+1)=0
            C|(CX%-15+(A%-1)/40,Y%/40+1)=0
            C|(CX%-15+(A%-1)/40-1,Y%/40+1)=47
            @put_pic(Int((A%-1)/40-1)*40,Int(Y%/40+1)*40,B$(47)) !Put Int((A%-1)/40-1)*40,Int(Y%/40+1)*40,B$(47)
			COLOR black,yellow 
            Pbox Int((A%-1)/40)*40,Int(Y%/40+1)*40,Int((A%-1)/40)*40+39,Int(Y%/40+1)*40+39
			COLOR yellow,blue
			@show_wait
			pause 3
            'Rc_copy Scr1%,Int((A%-1)/40-1)*40,Int(Y%/40+1)*40,80,40 To Scr2%,Int((A%-1)/40-1)*40,Int(Y%/40+1)*40
            Kh&=0
            While C|(CX%-15+(A%-1)/40-1,Y%/40+2+Kh&)=0 And Y%/40+Kh&<=8
              C|(CX%-15+(A%-1)/40-1,Y%/40+1+Kh&)=0
              C|(CX%-15+(A%-1)/40-1,Y%/40+2+Kh&)=47
              @put_pic(Int((A%-1)/40-1)*40,Int(Y%/40+2+Kh&)*40,B$(47)) !Put Int((A%-1)/40-1)*40,Int(Y%/40+2+Kh&)*40,B$(47)
			  COLOR black,yellow 
              Pbox Int((A%-1)/40-1)*40,Int(Y%/40+1+Kh&)*40,Int((A%-1)/40-1)*40+39,Int(Y%/40+1+Kh&)*40+39
			  COLOR yellow,blue
			  @show_wait
			  pause 3
              'Rc_copy Scr1%,Int((A%-1)/40-1)*40,Int(Y%/40+1+Kh&)*40,40,80 To Scr2%,Int((A%-1)/40-1)*40,Int(Y%/40+1+Kh&)*40
              Inc Kh&
            Wend
          Endif
        Endif
      Endif
    Endif
  Else                      !wenn sie auf zwei Steinen steht
    A%=A%-8                 !lasse Sie gehen
  Endif
  If A%<0                   !Wenn sie links rausgehen will
    A%=0                    !Lasse Sie nicht raus gehen
  Endif
  Get A%,Y%,40,64,Back$  !Get A%,Y%,A%+39,Y%+62,Back$   !sichere den Hintergrund
  Aalt%=A%
  Yalt%=Y%
  If Bewhil&=0
    O2|=((O2|+1) Mod 3)
    '------
	GRAPHMODE 2
    COLOR blue,yellow
    @put_pic(A%,Y%,S$(O2|+3,Zu&+Skeletti&)) !Put A%,Y%,S$(O2|+3,Zu&+Skeletti&),4
	COLOR yellow,blue
    @put_pic(A%,Y%,Fig$(O2|+3,Zu&+Skeletti&)) !Put A%,Y%,Fig$(O2|+3,Zu&+Skeletti&),6
	GRAPHMODE 1
	'---
  Else
    '------
	GRAPHMODE 2
    COLOR blue,yellow
    @put_pic(A%,Y%,S$(Ri%-1,Zu&+Skeletti&)) !Put A%,Y%,S$(Ri%-1,Zu&+Skeletti&),4
	COLOR yellow,blue
    @put_pic(A%,Y%,Fig$(Ri%-1,Zu&+Skeletti&)) !Put A%,Y%,Fig$(Ri%-1,Zu&+Skeletti&),6
	GRAPHMODE 1
	'---
  Endif                                    !Frucht wurde gemalt
  'Rc_copy Scr1%,A%,Y%,48,63 To Scr2%,A%,Y% !r"+Chr$(129)+"ber kopieren
  'Put A%,Y%,Back$                          !Hintergrund malen
  @show_wait
Return
Procedure Fall
  If As%>0           !Frucht ist bereits ein St"+Chr$(129)+"ck gefallen ! % statt &
    If Y%>7          !Frucht ist auf dem Bildschirm
      As%=C|(CX%-15+(A%+1)/40,(Y%-15)/40+2)+C|(CX%-15+(A%-1)/40+1,(Y%-15)/40+2)
    Else             !Frucht ist nicht auf dem Bildschirm
      As%=0
    Endif  !Wenn As%>0 ist befindet sich unter der Frucht ein oder zwei Stein(e)
  Endif
  If As%=0 Or ((Y%+63) Mod 40)>0!Wenn sich keine Steine unter ihr befinden ODER die Frucht nicht genau auf einem Stein ist
  print "nichtaufstein"
    As%=7    !Frucht ist bereits ein St"+Chr$(129)+"ck gefallen
    If Y%>=-71 !Y%>7  !Wenn die Frucht auf dem Bildschirm ist
      @put_back1 ! Put A%,max(0,Y%),Back$  !,dann male den Hintergrund
      'wird am beginn dess fallprozesses einmal getriggert
      'If A%>1          !Wenn die Frucht nicht am linken Rand des Bildschirms ist
        'Rc_copy Scr1%,A%-8,Y%,56,68 To Scr2%,A%-8,Y%  !R"+Chr$(129)+"berkopieren
      'Else             !ansonsten
        'Rc_copy Scr1%,A%,Y%,48,68 To Scr2%,A%,Y%      !weniger R"+Chr$(129)+"berkopieren
      'Endif
    Endif
    Repeat
	  print "inrepeat"
	  @handle_events()
      @Monster
      'Select Stick(1)       !Selection des Joy-Sticks
      'Case 8,10               !Rechts
	  If kb%(KEYRIGHT%)=1 and kb%(KEYLEFT%)=0
        Endf%=8
        Ap%=1
	  Else If kb%(KEYRIGHT%)=0 and kb%(KEYLEFT%)=1
      'Case 4,6                !Links
        Endf%=-8
        Ap%=4
	  ELSE
      'Default                 !Weder rechts noch links
        Ap%=1
        If Ri%=4
          Ap%=4
        Endif
        Endf%=0
	  ENDIF
      'Endselect
      Ends|=8                 !Y-position wird voraussichtlich um 8 erh"+Chr$(148)+"ht
      If (A% Mod 40)=0          !Wenn die Frucht sich genau "+Chr$(129)+"ber einem Stein befindet
        If Y%>7                 !Wenn die Frucht auf dem Bildschirm ist
          @Forn_abfrage
        Else                    !Wenn die Frucht nicht auf dem Bildschirm ist
          If Endf%>0              !Wenn sie nicht senkrecht f"+Chr$(132)+"llt(rechts)
            If C|(CX%-15+(A%-1)/40+2,0)>0  !Wenn unterm Anzeigebalken ein Stein ist
              Endf%=0                        !,dann f"+Chr$(132)+"llt sie senkrecht
            Endif
          Else if Endf%<0       !Wenn sie nicht senkrecht f"+Chr$(132)+"llt(links)
            If C|(CX%-15+(A%-1)/40,0)>0    !Wenn unterm Anzeigebalken ein Stein ist
              Endf%=0                        !,dann f"+Chr$(132)+"llt sie senkrecht
            Endif
          Endif
        Endif
      Endif
      A%=A%+Endf%     !"+Chr$(142)+"nderung der x-koordinate
      Y%=Y%+Ends|     !"+Chr$(142)+"nderung der y-Koordinate
      If Y%>300         !Wenn die Frucht nach unten raus gefallen ist
        Dec Lebem|(Akt&)  !Senke ihre Lebensenergie
        If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100  !Wenn sie jetzt tot ist
          @Figur_selection
        Endif
        @Wscroll      !Aufs n"+Chr$(132)+"chste Festland(Marke)setzen
      Endif
      If A%<0         !Wenn die Frucht nach links raus ist
        A%=0            !,dann ist sie am linken Rand
      Endif
      If Y%>=-71 !Y%>7         !Wenn die Frucht auf dem Bildschirm ist
	    @put_back1
        Get A%,max(0,Y%),40,64,Back$           !sichere dem Hintergrund
		Aalt%=A%
        Yalt%=Y%
        '------
        GRAPHMODE 2
        COLOR blue,yellow
        @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&))  !Put A%,Y%,S$(Ap%,Zu&+Skeletti&),4     !maskiere sie aus
	    COLOR yellow,blue
        @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&)) !Put A%,Y%,Fig$(Ap%,Zu&+Skeletti&),6   !male sie
        GRAPHMODE 1
        '---
		'----
		@show_wait
		'showpage
		'While Timer<Ts%+0.3
        'Wend
		'Ts%=Timer
		'----
        'If A%>8                               !Wenn sie nicht am linken Rand ist
          'Rc_copy Scr1%,A%-8,Y%-8,56,72 To Scr2%,A%-8,Y%-8  !R"+Chr$(129)+"berkopieren
        'Else                                  !andertnfalls
          'Rc_copy Scr1%,A%,Y%-8,48,72 To Scr2%,A%,Y%-8      !weniger r"+Chr$(129)+"berkopieren
        'Endif
        'Put A%,max(0,Y%),Back$   !male den Hintergrund !Fuehrt zu unsichtbarer figur am ende des Fallens
		'@put_back
	 ' pause 1
      Else            !Wenn die Frucht nicht auf dem Bildschirm ist
        While Y%<7      !Solange die Frucht nicht auf dem Bildschirm ist
		@handle_events()
          @Monster
@show_wait
          'Select Stick(1)  !selectiere den Joy-Stick
          'Case 8             !Rechts
		  If kb%(KEYRIGHT%)=1 and kb%(KEYLEFT%)=0 !
            Endf%=8
            Ap%=1
          'Case 4             !Links
		  ELSE If kb%(KEYRIGHT%)=0 and kb%(KEYLEFT%)=1
            Endf%=-8
            Ap%=4
		  ELSE
          'Default            !weder rechts noch links
            Ap%=1
            If Ri%=4
              Ap%=4
            Endif
            Endf%=0
          ENDIF !Endselect
          Ends|=8
          If (A% Mod 40)=0
            If Endf%>0
              If C|(CX%-15+(A%-1)/40+2,0)>0
                Endf%=0
              Endif
            Else if Endf%<0
              If C|(CX%-15+(A%-1)/40,0)>0
                Endf%=0
              Endif
            Endif
          Endif
          A%=A%+Endf%
          Y%=Y%+Ends|
          If A%<0
            A%=0
          Endif
        Wend
      Endif
	  print "more fall2"
      If A%>400  !Wenn die Frucht zu weit rechts ist, dann scrollen
        @Hinter
      Endif
      If Y%>7  !Wenn die Frucht auf dem Bildschirm ist
	  @put_back1
        Get A%,Y%,40,64,Back$  !sichere den Hintergrund
		Aalt%=A%
        Yalt%=Y%
		print "pruefediamant",CX%-15+(A%+1)/40,(Y%-15)/40+2	,C|(CX%-15+(A%+1)/40,(Y%-15)/40+2),"=24?"
        If C|(CX%-15+(A%+1)/40,(Y%-15)/40+2)=24 !Wenn unter der Frucht ein Diamant ist
          Deffill 0
          HiX%=Int((A%+1)/40)*40
          HiY%=Int((Y%-15)/40+2)*40
		  COLOR blue,yellow 
          Pbox HiX%,HiY%,HiX%+39,HiY%+39  !l"+Chr$(148)+"sche ihn
		  COLOR yellow,blue
          'Rc_copy Scr1%,HiX%,HiY%,40,40 To Scr2%,HiX%,HiY%
          C|(CX%-15+(A%+1)/40,(Y%-15)/40+2)=0
          Add Punkte%,49              !addiere zur Punktzahl 49
        Endif
        If C|(CX%-15+(A%-1)/40+1,(Y%-15)/40+2)=24 !Wenn unter der Frucht(anderes bein)ein Diamant ist
          Deffill 0
          HiX%=Int((A%-1)/40+1)*40
          HiY%=Int((Y%-15)/40+2)*40
		  COLOR blue,yellow 
          Pbox HiX%,HiY%,HiX%+39,HiY%+39  !l"+Chr$(148)+"sche ihn
		  COLOR yellow,blue
          'Rc_copy Scr1%,HiX%,HiY%,40,40 To Scr2%,HiX%,HiY%
          C|(CX%-15+(A%-1)/40+1,(Y%-15)/40+2)=0
          Add Punkte%,49              !addiere zur momentanen Punktezahl 49
        Endif
      Endif
    Until C|(CX%-15+(A%+1)/40,(Y%-15)/40+2)+C|(CX%-15+(A%-1)/40+1,(Y%-15)/40+2)>0 And ((Y%+63) Mod 40)=0
    ' Fallen ist zu ende, wenn unter der Frucht mindestens ein Stein ist
    '
    ' Ist die Frucht auf ein Pflanzen-Monster gefallen
    If C|(CX%-15+(A%+1)/40,(Y%-15)/40+2)+C|(CX%-15+(A%-1)/40+1,(Y%-15)/40+2)>250
	'	pause 2
      If C|(CX%-15+(A%+1)/40,(Y%-15)/40+2)=254
	'	pause 2
        ' die Frucht ist mit dem linken Fu"+Chr$(158)+" auf eine Pflanze getreten!
        For I%=0 To 5 !Herausfinden welche Nummer das Pflanzen-Monster hat !I%
          Exit if Abs(X%(I%)-A%)<40 And Y%(I%)=Y%+63 !Wenn der x-Abstand kleiner als 40 ist und sich Monster und Frucht auf der selben H"+Chr$(148)+"he aufhalten, dann ist es die richige Nummer!
        Next I%
	'	pause 2
        If R%(I%)=0!Wenn die Pflanze bisher immer auf und ab gegangen ist
          If Zahlm%(I%)<3 Or Zahlm%(I%)>12! wenn die Pflanze gerade im stein ist
            @put_pic(X%(I%),Y%(I%),Zerstampf$(0)) ! Put X%(I%),Y%(I%),Zerstampf$(0) !sie f"+Chr$(132)+"ngt an zerstampft zu werden!
            'Rc_copy Scr1%,X%(I&),Y%(I&),40,40 To Scr2%,X%(I&),Y%(I&)!r"+Chr$(129)+"ber kopieren
            R%(I%)=1 !die neue bewegungsart der Pflanze ist 1
            Zahlm%(I%)=-1 !Neue Bewegungsart beginnt mit der ersten Sequenz
          Endif
        Endif
      Endif
      ' Der folgende abschnitt macht das selbe, wie der vorhergegangene nur f"+Chr$(129)+"r den rechten Fu"+Chr$(158)+"
      If C|(CX%-15+(A%-1)/40+1,(Y%-15)/40+2)=254
        ' rechter FU"+Chr$(158)+"
        For I%=0 To 5 !I%
          Exit if Abs(X%(I%)-A%)<40 And Y%(I%)=Y%+63
        Next I%
        If R%(I%)=0
          If Zahlm%(I%)<3 Or Zahlm%(I%)>12
            @put_pic(X%(I%),Y%(I%),Zerstampf$(0)) ! Put X%(I%),Y%(I%),Zerstampf$(0)
            'Rc_copy Scr1%,X%(I&),Y%(I&),40,40 To Scr2%,X%(I&),Y%(I&)
            R%(I%)=1
            Zahlm%(I%)=-1
          Endif
        Endif
      Endif
    Endif
  Endif
Return
Procedure Hinter
'------------ ersatz fur bmove
  Get 40,40,600,360,Scr2t$
  Put 0,40,Scr2t$
'--------
  'Bmove Scr1%+3205,Scr1%+3200,32000-3205 !Scrollen mit M"+Chr$(129)+"ll rechts
  @put_pic(600,40,Scroll$) !Put 600,40,Scroll$                     !Rechts wei"+Chr$(158)+"en Balken putten (40*360)
  @Nach
  A%=A%-40                               !X-Koordinate der Frucht um 40 verringern
  Aalt%=Aalt%-40
  ' -----
  For I_H%=0 To 5 
    X_alt%(I_H%)=X_alt%(I_H%)-40
    'X%(I_H%)=X%(I_H%)-40
  Next I_H%
  ' ----
Return
Procedure Nach
  Add CX%,1                     !Erh"+Chr$(148)+"he anzahl der bereits gescrollten Male um 1
  print "scroll", CX%
  print C|(CX%,1),C|(CX%,2),C|(CX%,3),C|(CX%,4),C|(CX%,5),C|(CX%,6),C|(CX%,7),C|(CX%,8),C|(CX%,9) 
  For C%=1 To 9                 !9 Steine "+Chr$(129)+"bereinander
  print C|(CX%,C%)
    If C|(CX%,C%)>0             !Wenn im Feld an dieser Position etwas steht
      Select C|(CX%,C%)         !Selectiere diesen Eintrag
        '    Muster f"+Chr$(129)+"r alle Monster cases
        '    R(mons) Ist eine Monster voreable,welche meist f"+Chr$(129)+"r die Richtung genutzt wird
        '    gz(mons)Ist eine Monster voreable,welche f"+Chr$(129)+"r alles m"+Chr$(148)+"gliche verwendet wird
        '    Zahlm(monsIst eine Monster voreable,welche f"+Chr$(129)+"r alles m"+Chr$(148)+"gliche verwendet wird
        '    Monstertyp(mons)Ist die Nummer der Art des Monsters
        '    x(mons) Ist meist die x-Koordinate des Monsters
        '    y(mons) Ist mei"+Chr$(158)+"t die y-Koordinate des Monsters
        '    c|(Cx,C)=0 hiermit l"+Chr$(148)+"schen die Monster sich aus dem Feld,da sie sonst,wie ein Stein ein Hindernis w"+Chr$(132)+"hren
        '    Inc Mons& hiermit wird der (Zeiger auf n"+Chr$(132)+"chste Monster in den Feldern geschoben
        '
      Case 42                         !Schussstein
        @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))  !Male Schussstein
        R%(Mons&)=3
        X%(Mons&)=640-25
        Y%(Mons&)=C%*40+15
        Monstertyp&(Mons&)=95
        GZ%(Mons&)=1
        Zahlm%(Mons&)=0
        Inc Mons&
      Case 43                         !Schussstein
        @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))  !male schussstein
        R%(Mons&)=3
        X%(Mons&)=640+15
        Y%(Mons&)=C%*40-25
        Monstertyp&(Mons&)=95
        GZ%(Mons&)=2
        Zahlm%(Mons&)=0
        Inc Mons&
      Case 44                         !Schussstein
        @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))  !Male Schussstein
        R%(Mons&)=3
        X%(Mons&)=640+15
        Y%(Mons&)=C%*40+15
        Monstertyp&(Mons&)=95
        GZ%(Mons&)=3
        Zahlm%(Mons&)=0
        Inc Mons&
      Case 45,26,10                   !Hintergr"+Chr$(129)+"nde
        @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))  !male den Hintergrund
        C|(CX%,C%)=0                  !l"+Chr$(148)+"sch sie aus dem Feld
'      Case 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60 !1 To 60
        ' normale Steine
 '       @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))  !male den Stein
'      Case 61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90 !61 To 90
        ' hintergr"+Chr$(129)+"nde
 '       @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))
 '       C|(CX%,C%)=0
      Case 94
        ' Kreisel
        X%(Mons&)=640+10
        Y%(Mons&)=C%*40+10
        R%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=94
        Zahlm%(Mons&)=19
        GZ%(Mons&)=0
        Inc Mons&
      Case 96
        ' Masse
        X%(Mons&)=640
        Y%(Mons&)=C%*40
        GZ%(Mons&)=0
        Zahlm%(Mons&)=0
        R%(Mons&)=0
        C|(CX%,C%)=17
        Monstertyp&(Mons&)=96
        Inc Mons&
      Case 97
        ' gummi
        Zahlm%(Mons&)=-24
        X%(Mons&)=640
        Y%(Mons&)=C%*40
        R%(Mons&)=0
        GZ%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=97
        Inc Mons&
      Case 98
        ' Kr"+Chr$(148)+"te
        R%(Mons&)=2
        X%(Mons&)=640
        Y%(Mons&)=C%*40+20
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=98
        Inc Mons&
      Case 99
        ' Ball
        R%(Mons&)=3
        X%(Mons&)=640
        Y%(Mons&)=C%*40
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=99
        Inc Mons&
      Case 100
        ' schwalbe
        R%(Mons&)=1
        X%(Mons&)=640
        Y%(Mons&)=C%*40+10
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=100
        Inc Mons&
      Case 101
        ' Fisch
        X%(Mons&)=640+5
        Y%(Mons&)=C%*40
        R%(Mons&)=0
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        @put_pic(600,C%*40,B$(26)) ! Put 600,C%*40,B$(26)
        Monstertyp&(Mons&)=101
        C|(CX%,C%)=0
        Inc Mons&
      Case 102
        ' Fisch
        X%(Mons&)=640+5
        Y%(Mons&)=C%*40
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        R%(Mons&)=0
        @put_pic(600,C%*40,B$(26)) ! Put 600,C%*40,B$(26)
        Monstertyp&(Mons&)=102
        C|(CX%,C%)=0
        Inc Mons&
      Case 103
        ' qualle
        R%(Mons&)=2
        X%(Mons&)=640
        Y%(Mons&)=C%*40+24
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=103
        Inc Mons&
      Case 104
        ' wabbel
        X%(Mons&)=640
        Y%(Mons&)=C%*40+19
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=104
        R%(Mons&)=2
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        Inc Mons&
      Case 105
        ' purzel
        R%(Mons&)=3
        X%(Mons&)=640
        Y%(Mons&)=C%*40
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=105
        Inc Mons&
      Case 106
        ' auge
        R%(Mons&)=1
        X%(Mons&)=650
        Y%(Mons&)=C%*40
        GZ%(Mons&)=0
        Zahlm%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=106
        Inc Mons&
      Case 107
        ' stachel
        X%(Mons&)=620
        Y%(Mons&)=C%*40+23
        R%(Mons&)=0
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        Monstertyp&(Mons&)=107
        C|(CX%,C%)=0
        Inc Mons&
      Case 108
        ' stachel
        X%(Mons&)=640
        Y%(Mons&)=C%*40+23
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        R%(Mons&)=0
        C|(CX%,C%)=0
        Monstertyp&(Mons&)=107
        Inc Mons&
      Case 109
        ' feuer
        X%(Mons&)=624
        Y%(Mons&)=C%*40+14
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        R%(Mons&)=0
        C|(CX%,C%)=0
        Monstertyp&(Mons&)=109
        Inc Mons&
      Case 110
        ' feuer
        X%(Mons&)=644
        Y%(Mons&)=C%*40+14
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        R%(Mons&)=0
        C|(CX%,C%)=0
        Monstertyp&(Mons&)=109
        Inc Mons&
      Case 111
        ' Plattform
        R%(Mons&)=1
        GZ%(Mons&)=1
        X%(Mons&)=600
        Y%(Mons&)=C%*40
        Zahlm%(Mons&)=0
        @Dunkel_oder_hell
        Monstertyp&(Mons&)=111
        Inc Mons&
      Case 112
        ' bombe
        @put_pic(600,C%*40,B$(17)) ! Put 600,C%*40,B$(17)
        C|(CX%,C%)=17
        X%(Mons&)=655
        GZ%(Mons&)=655
        Y%(Mons&)=C%*40+24
        R%(Mons&)=Y%(Mons&)
        Monstertyp&(Mons&)=112
        Zahlm%(Mons&)=0
        Inc Mons&
      Case 113
        ' pfeil
        @put_pic(600,C%*40,B$(17)) ! Put 600,C%*40,B$(17)
        C|(CX%,C%)=17
        X%(Mons&)=640
        Y%(Mons&)=C%*40+15
        GZ%(Mons&)=0
        R%(Mons&)=0
        Monstertyp&(Mons&)=113
        Zahlm%(Mons&)=0
        Inc Mons&
      Case 114
        ' Schwalbe im Sturzflug
        X%(Mons&)=640
        Y%(Mons&)=C%*40
        @Dunkel_oder_hell
        R%(Mons&)=2
        Zahlm%(Mons&)=0
        GZ%(Mons&)=0
        Monstertyp&(Mons&)=114
        Inc Mons&
      Case 115
        ' pflanze
        X%(Mons&)=640
        Y%(Mons&)=C%*40
        R%(Mons&)=0
        Zahlm%(Mons&)=-1
        GZ%(Mons&)=0
        C|(CX%,C%)=254
        Monstertyp&(Mons&)=115
        Inc Mons&
      Case 255
	    print "stopscroll"
        @Dunkel_oder_hell
        Scrollstop&=1
        ScrollY%=C%
	  Default
	    IF C|(CX%,C%) <= 60 and C|(CX%,C%) >=1
		'@Dunkel_oder_hell ! gehort hier nicht hin
        'Scrollstop&=1 ! gehort hier nicht hin
        'ScrollY%=C% ! gehort hier nicht hin
	    '      Case 1 To 60
        ' normale Steine
          @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))  !male den Stein
		ELSE IF C|(CX%,C%) <= 90 and C|(CX%,C%) >=61
'      Case 61 To 90
        ' hintergr"+Chr$(129)+"nde
          @put_pic(600,C%*40,B$(C|(CX%,C%))) ! Put 600,C%*40,B$(C|(CX%,C%))
          C|(CX%,C%)=0
		ENDIF
      Endselect
      Mons&=(Mons& Mod 6)              ! maximal 6 Monster
    Endif
  Next C%
  print "otherscrol"
  If CX%=999                         !Wenn das Level zu ende ist
    @New_level_start
  Endif
  For I%=0 To 5                      !Subtrahiere von allen x-Koordinaten der Monster 40 I&
    Sub X%(I%),40
  Next I%
  Sub SchussX%,40                    !Subtrahiere von der x-Koordinate des Schusses 40
  @put_pic(0,0,Hil$) ! Put 0,0,Hil$                       !restaurire die Anzeigeleiste
  Hpunkte%=Punkte%+1
  Hleben|=0
  Graphmode 3
  Deffill 1,1,1
  Pbox 224,3,223+(Lebem|(Akt&)-3)*6,17 !Pbox 224,3,223+(Lebem|(Akt&)-3)*6,17  ! Balken zeigt Leben an
  Hleben|=Lebem|(Akt&)
  Bubble$=Right$("000"+Str$(Levels&),3)
  Graphmode 2
  Text 380,24,Bubble$
  Graphmode 1
  Bubble$=Right$("0000000"+Str$(Punkte%),8)
  Text 223,36,Bubble$
  Hpunkte%=Punkte%
 ' showpage !Bmove Scr1%,Scr2%,32000
  '@show_fig_wait() !@show_wait
Return
Procedure Dunkel_oder_hell
  ' Diese Procedur soll kl"+Chr$(132)+"ren ob an der Stelle, an der ein Monster aufgetaucht
  ' ist es Hell oder Dunkel ist!
  If C|(CX%+1,C%)=10       !Wenn es rechts von der zu pr"+Chr$(129)+"fenden Position dunkel ist
    @put_pic(600,C%*40,B$(10)) ! Put 600,C%*40,B$(10)    !,dann ist es auch an dieser Position dunkel
  Endif
  C|(CX%,C%)=0             !Eintrag aus dem Feld l"+Chr$(148)+"schen
Return
Procedure Level
  ' Diese Procedure soll das Level einladen
  print "level begin"
  CLEARW !Void Xbios(5,L:Scr2%,L:Scr2%,-1)
  showpage
  Hgesleben%=Gesleben% !Hgesleben&=Gesleben&                           !alte gesamtlebenzahl retten
  Gesleben%=0 !Gesleben&=0
  For I%=0 To 3 !I&
    Gesleben&%=Gesleben%+Lebem|(I%)-3 !Gesleben&=Gesleben&+Lebem|(I%)-3
  Next I%
  If Punkte%-Levelpunkte%>Maxpunkte%
    Maxpunkte%=Punkte%-Altpunkte%                      !Neue max-Punktzahl in diesem Level
    Maxpunktename$=Player$                       !Namen des Spielers mit dem Levelpunkterekord korregieren
    Hik%=1 !Hik&=1
  Endif
  Altpunkte%=Punkte%
  If Levels%>0 !% statt &
    If Hgesleben%-Gesleben%<Lebenverlust% !If Hgesleben&-Gesleben&<Lebenverlust&          !wenn der eigene lebenverlust in diesem Level geringer ist asl der levelrekord
      Lebenverlust%=Hgesleben%-Gesleben% !Lebenverlust&=Hgesleben&-Gesleben&           !neuer Rekord beim Levellebenverlust
      Add Hik%,2 !Add Hik&,2
    Endif
  Endif
  If Hik%>0 !If Hik&>0
    If Levels%>0 !If Levels&>0
      @Neuer_levelrekord
    Endif
  Endif
  @Figur_selection
  We$=""                                            !Hilfsvareable leeren
  Inc Levels%  !Inc Levels&                                       !Levelnummer erh"+Chr$(148)+"hen
  A$=Right$("000"+Str$(Levels%),3)                  !3-Stellig machen !Levels&
  If Exist("levels\level"+A$+".lev")    !Wenn vorhanden
    Open "i",#1,"levels\level"+A$+".lev"  !Datei "+Chr$(148)+"ffnen
	print "open" "i",#1,"levels\level"+A$+".lev" 
    Code%=Cvl(Input$(#1,4)) !Input$(4,#1)
    B%=Cvl(Input$(#1,4)) !Input$(4,#1)
    For I%=0 To Lof(#1)/4-3 !I&
      B%=B% Xor Cvl(Input$(#1,4)) !Input$(4,#1)
    Next I%
    Close
    If B%=Code%
      CLEARW !Void Xbios(5,L:Scr2%,L:Scr2%,-1)
      'Cls
      Open "i",#1,"levels\level"+A$+".lev"  !Datei "+Chr$(148)+"ffnen
      Void Cvl(Input$(#1,4)) !Input$(4,#1)
      Erbauer$=Input$(#1,16)
      Maxpunkte%=Cvl(Input$(#1,4))
      Maxpunktename$=Input$(#1,16)
      Lebenverlust%=Asc(Input$(#1,1))-128 %Lebenverlust&=Asc(Input$(#1,1))-128
      GPrint At(6,30);"Dieses Level ist von:" !Print At(30,6);"Dieses Level ist von:"
      GPrint At(7,32);Erbauer$
      GPrint At(9,20);"Momentaner Punkterekord in diesem Level:"
      GPrint At(10,36);Right$("0000000"+Str$(Maxpunkte%),8)
      GPrint At(11,30);"Von:";Maxpunktename$
      If Lebenverlust% >=0 !=>0  !Lebenverlust&
        GPrint At(13,9);"In diesem Level wurden bisher mindestens "+Str$(Lebenverlust&)+" Leben verloren!"
      Else
        GPrint At(13,11);"In diesem Level wurden bisher maximal "+Str$(Abs(Lebenverlust&))+" leben gewonnen!"
      Endif
	  SHOWPAGE
      We$=Input$(#1,10000)                              !level einladen !Input$(10000,#1)
      Hz&=0                                             !Hilfsvareable =0
      For I%=0 To 999 !I&
        H$=Input$(#1,1)                !l"+Chr$(132)+"nge der Extra Infios einladen (Schalter)
        Schalt$(I%)=Input$(#1,Asc(H$)*4) !Extra Infos ins Feld einladen
      Next I%
      Close                                        !Datei schlie"+Chr$(158)+"en
      LvaR%=0 !LvaR%=0                                         !Hilfsvareable =0
      For I%=0 To 999 !I&
        For W%=0 To 9 !W&
          Inc LvaR%
          C|(I%,W%)=Asc(Mid$(We$,LvaR%-1,1))               !Level ins Feld schreiben ?????????????????????????????-1??? byteswap? irgendwas falsch
		  if (Asc(Mid$(We$,LvaR%-1,1))<0)
		    print "negativesfeld",Asc(Mid$(We$,LvaR%-1,1)),I%,W%
			C|(I%,W%)=255 ! keine ahnung ob das so sein sollte
		  endif
		  'print I%,W%,Asc(Mid$(We$,LvaR%,1)) 
        Next W%
      Next I%
    Else
      Fehler$="Daten des Levels sind nicht korrekt!"
      @Fehler
    Endif
  Else                                            !Wenn das Level nicht gefunden wird
    @Ende
  Endif
  '----------
  KEYEVENT kc,ks,t$,x,y,xr,yr,k 
	  '----------
  'Repeat
  'Until Strig(1)=-1
  CLEARW !Void Xbios(5,L:Scr1%,L:Scr2%,-1)
  print "levelend"
Return
Procedure Anf_b_aufbau
  'try the colors
  COLOR blue,yellow
  ' Am Anfang eines Levels mu"+Chr$(158)+" der Bildschirm mit 16*9 Steinen gef"+Chr$(129)+"llt werden
  Graphmode 1 !'---
  Pbox 0,0,640,400 !clearw  !Cls                               !Bildschirm l"+Chr$(148)+"schen
  COLOR yellow,blue !'----
  For I%=1 To 9                      !Spalte 1 bis 9(incl.9) !I&
    Inc BY%
    For X%=0 To 15                     !Spalte 0 bis 15(incl.15) !X%
      Inc BX%
	  print X%,I%,C|(X%,I%)
      If C|(X%,I%)>0                      !Wenn im Level an dieser Stelle etwas ist
        If C|(X%,I%)>60 Or C|(X%,I%)=10 Or C|(X%,I%)=26 Or C|(X%,I%)=45 !Wenn kein Stein
          If C|(X%,I%)<91   !Wenn kein Monster
            @put_pic(X%*40,I%*40,B$(C|(X%,I%))) !Put X%*40,I%*40,B$(C|(X%,I%))               !Hinmalen und aus dem Feld l"+Chr$(148)+"schen
          Endif
          C|(X%,I%)=0
        Else                                      !Andernfals
          @put_pic(X%*40,I%*40,B$(C|(X%,I%))) !Put X%*40,I%*40,B$(C|(X%,I%))                 !Hinmalen
        Endif
      Endif
    Next X%
    BX%=0
  Next I%
  SHOWPAGE !Bmove Scr1%+3200,Scr2%+3200,28800               !Bildschirm anzeigen
  print "ende Anf_b_aufbau"
Return
Procedure Aktanzeigen
  ' Anzeigebalken neu anzeigen
  'print "Aktanzeigen"
  If Hleben|<>Lebem|(Akt&) Or Punkte%<>Hpunkte% !Wenn sich etwas in der Anzeigeleiste "+Chr$(132)+"ndern mu"+Chr$(158)+"
    @put_pic(0,0,Hil$)  !Put 0,0,Hil$           !male lehren Anzeigebalken
    Hpunkte%=Punkte%
    Hleben|=Lebem|(Akt&)
    Deffill 1,1,1
    Graphmode 3 ! ###################################
    Pbox 224,3,223+(Lebem|(Akt&)-3)*6,17 !zeigt Leben an
    Bubble$=Right$("000"+Str$(Levels&),3)
    Graphmode 2
    Text 380,24,Bubble$
    Graphmode 1
    Bubble$=Right$("0000000"+Str$(Punkte%),8)
	print "bubbletext"
    Text 223,36,Bubble$
    SHOWPAGE !Bmove Scr1%,Scr2%,3200
    If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
      Lebem|(Akt&)=3
      @Figur_selection
    Endif
  Endif
Return
Procedure Abfrage
  ' Selektierung der Bewegung der Frucht!
  HhhhBew%=HhhBew%
  HhhBew%=HhBew%
  HhBew%=HBew%
  HBew%=Bew%
  Bew%=0
  '---
  IF kb%(KEYRIGHT%)=1 and kb%(KEYLEFT%)=0 and kb%(KEYUP%)=0
    kbtick% = 8
  ELSE IF kb%(KEYLEFT%)=1 and kb%(KEYRIGHT%)=0 and kb%(KEYUP%)=0
    kbtick% =  4
  ELSE IF kb%(KEYRIGHT%)=0 and kb%(KEYLEFT%)=1 and kb%(KEYUP%)=1
    kbtick% = 1
  ELSE IF kb%(KEYRIGHT%)=1 and kb%(KEYLEFT%)=0 and kb%(KEYUP%)=1
    kbtick% =  5
  ELSE IF kb%(KEYUP%)=1 and kb%(KEYRIGHT%)=0 and kb%(KEYLEFT%)=0
    kbtick% =  9
  ELSE
    kbtick% = 0
  ENDIF
  '---
  If Y%>7
    'print "Abfrage:Y%>7-right"+kb%(KEYRIGHT%)+"-left"+kb%(KEYLEFT%)+"-up"+kb%(KEYUP%)
    Select kbtick% !Select Stick(1)
    Case 8
	 ' print "vor!"
      @Vor !Vor
      Bew%=8
      Ri%=3
    Case 4
	'  print "zur!"
      @Zur !Zur
      Bew%=4
      Ri%=4
    Case 9,1,5
	  print "vsp"
	  '---! Bew waere 0
	  If kbtick%=1
	    Bew%=4
	  Else If kbtick%=5
	    Bew%=8
	  Else If kbtick%=9
	    Bew%=10 !standsprung
	  Endif
      @Vsp      !Der Sprung !Vsp
    Default
      Bew%=10
    Endselect
  Else
    print "Abfrage:Fall"
'	pause 1
    @Fall !braucht man das hier?
  Endif
Return
Procedure Forn_abfrage_o
  ' Abfrage, ob die Frucht mit dem Kopf gegen einen Stein springt!
  If Endf%>0
    If C|(CX%-15+(A%-1)/40+2,(Y%+20)/40)+C|(CX%-15+(A%-1)/40+2,(Y%+60)/40)>0
      Endf%=0
    Endif
  Else if Endf%<0
    If C|(CX%-15+(A%-1)/40,(Y%+20)/40)+C|(CX%-15+(A%-1)/40,(Y%+60)/40)>0
      Endf%=0
    Endif
  Endif
Return
Procedure Forn_abfrage
  ' Abfrage rechts bzw links von der Frucht beim Springen/Fallen
  If Endf%>0
    If C|(CX%-15+(A%-1)/40+2,(Y%+63)/40-1)+C|(CX%-15+(A%-1)/40+2,(Y%+63)/40)>0
      Endf%=0
    Endif
  Else if Endf%<0
    If C|(CX%-15+(A%-1)/40,(Y%+63)/40-1)+C|(CX%-15+(A%-1)/40,(Y%+63)/40)>0
      Endf%=0
    Endif
  Endif
Return
Procedure Dims
  ' Alle Dimensieonierungen, die f"+Chr$(129)+"rs Spiel gebraucht wurden
  Dim Demofigur$(4) !Demofigur$(3)
  Dim Score%(100) !Score%(99)
  Dim Pname$(10) !Dim Pname$(9)
  Dim C|(1000,10) !C|(999,9)
  Dim Schalt$(1000) !Schalt$(999)
  Dim S$(6,8)                            !Masken      (Fr"+Chr$(129)+"chte (Sequenzen)) !S$(5,7)   
  Dim Fig$(6,8)                          !Put-Strings (Fr"+Chr$(129)+"chte (Sequenzen)) !Fig$(5,7) 
  Dim B$(101)                            !Put-Strings (Steine\Hintergrund) !B$(100)  
  Dim Lebem|(4)                          !Lebensenergie der Fr"+Chr$(129)+"chte 0 bis 3 !Lebem|(3)
  Dim HA%(3)                             !aufl"+Chr$(148)+"sen !HA%(2) 
  Dim HY%(3)                             !aufl"+Chr$(148)+"sen !HY%(2)  
  Dim M%(3)                              !aufl"+Chr$(148)+"sen !M%(2) 
  Dim Zeit%(3)                           !aufl"+Chr$(148)+"sen !Zeit&(2) 
  Dim Zwi%(8065)                         !Zweiter Screen !Zwi%(8064)  
  Dim Monstertyp&(6)                     !Monster Typ(sorte des Monsters) !Monstertyp&(5)  
  Dim X%(6),Y%(6)                        !Monster Koordinaten !X%(5),Y%(5)
      Dim X_alt%(6),Y_alt%(6)                        !alte Monster Koordinaten !X%(5),Y%(5)
	  Dim Backm_all$(6)                              !Monster/Plattformen Backups
  Dim R%(6)                              !Monster Richtung !R%(5) 
  Dim Ball$(4)                           !Ball     Put-Strings !Ball$(3)  
  Dim Krote$(2,2)                        !Kr"+Chr$(148)+"te    Put-Strings !Krote$(1,1)  
  Dim Krotem$(2,2)                       !Kr"+Chr$(148)+"te    Put-Back-Strings !Krotem$(1,1) 
  Dim Gummi$(4)                          !Gummi    Put-Strings !Gummi$(3)  
  Dim Masse$(4)                          !Masse    Put-Strings !Masse$(3) 
  Dim Kreisel$(4)                        !Kreisel  Put-Strings !Kreisel$(3)   
  Dim Fisch$(2,4)                        !Fisch    Put-Strings !Fisch$(1,3)
  Dim Fischm$(2)                         !Fisch    Put-Back-Strings !Fischm$(1)   
  Dim Schwalbe$(2)                       !Schwalbe Put-Strings !Schwalbe$(1)  
  Dim Schwalbem$(2)                      !Schwalbe Put-Back-Strings !Schwalbem$(1)  
  Dim Wabbel$(4)                         !Wabbel   Put-Strings !Wabbel$(3)   
  Dim Wabbelm$(4)                        !Wabbel   Put-Back-Strings !Wabbelm$(3)    
  Dim Purzel$(4)                         !Purzel   Put-Strings ! Purzel$(3)  
  Dim Purzelm$(4)                        !Purzel   Put-Back-Strings ! Purzelm$(3)  
  Dim Auge$(2,4)                         !Auge     Put-Strings !Auge$(1,3)
  Dim Augem$(4)                          !Auge     Put-Back-Strings !Augem$(3)   
  Dim Stachel$(14)                       !Stachel  Put-Strings !Stachel$(13)   
  Dim Feuer$(4)                          !Feuer    Put-Strings !Feuer$(3) 
  Dim Qualle$(5)                         !Qualle   Put-Strings !Qualle$(4)   
  Dim Quallem$(5)                        !Qualle   Put-Back-Strings !Quallem$(4)    
  Dim Pfeil$(2)                          !Pfeil    Put-Strings !Pfeil$(1) 
  Dim Pfeilm$(2)                         !Pfeil    Put-Back-Strings !Pfeilm$(1)  
  Dim Bombe$(2)                          !Bombe    Put-Strings !Bombe$(1) 
  Dim Bombem$(2)                         !Bombe    Put-Back-Strings !Bombem$(1)
  Dim Schwalbes$(2)                      !Schwalbe Sturzflug-Put-Strings !Schwalbes$(1)   
  Dim Schwalbesm$(2)                     !Schwalbe Sturzflug-Put-Back-Strings !Schwalbesm$(1)     
  Dim Zahlm%(6)                          !Hilfs-Z"+Chr$(132)+"hl-Variable f"+Chr$(129)+"r Monster !Zahlm%(5)  
  Dim GZ%(6)                             !Hilfs-Z"+Chr$(132)+"hl-Variable f"+Chr$(129)+"r Monster !GZ%(5)    
  Dim KreiselX%(20),KreiselY%(20)        !Kreibahn des Kreisels !Dim KreiselX%(19),KreiselY%(19)  !& to %
  '
  ' ==============================
  '  Put-Strings f"+Chr$(129)+"r die Pflanze:
  ' ==============================
  '
  Dim Auftauch$(14)                      !Pflanzen-Put-Strings(Auf und Ab) !Auftauch$(13)
  Dim Zerstampf$(5)                      !Pflanzen-Stein-zer-und endquetsch-Put-Strings !Zerstampf$(4)  
  Dim Wachs1$(2)                         !Pflanzen-kletter-Put-Strings(Teil 1) !Wachs1$(1)   
  Dim Wachs2$(8)                         !Pflanzen-kletter-Put-Strings(Teil 2) !Wachs2$(7) 
  Dim Bluete$(9)                         !Pflanzen-Bl"+Chr$(129)+"te-Put-Strings !Bluete$(8)
  '
  'Scr2%=Int(V:Zwi%(0)/256+1)*256         !Ablegen der Startadresse des zweiten Bildschirms in scr2%
  'Scr1%=Xbios(3)                         !Ablegen der Startadresse des normalen Bildschirms in scr1% (in diesem Moment ist xbios(2) noch gleich xbios(3)
  'Scr2%=MALLOC(32001) ! oder 28800?
  'Scr1%=MALLOC(32001) ! oder 32000?
 ' GET 0,0,640,480,Scr1%
 ' GET 0,0,640,480,Scr2%
  Hidem                                  !Maus nicht mehr anzeigen!
  Print "Ende: Dims"
Return
Procedure Werte3
  ' Hier werden wichtige Anfangswerte gesetzt!
  A%=8
  Y%=9
  CX%=15
  For I%=0 To 2 ! For-Laufvariable I&
    HA%(I%)=-49
  Next I%
  G|=19
  For I%=0 To 5
    Monstertyp&(I%)=0
  Next I%
  Print "Ende: Werte3"
Return
Procedure Werte2
  ' Hier werden wichtige Anfangswerte gesetzt!
  Skeletti&=0
  For I%=0 To 3 ! For-Laufvariable I&
    Lebem|(I%)=10
  Next I%
  Levels&=0
  Punkte%=0
  @Werte3 !Werte3
  Print "Ende: Werte2"
Return
Procedure Werte
  bitswap()=[0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff]
  bitfill()=[%00000000,%00000001,%00000011,%00000111,%00001111,%00011111,%00111111,%01111111,%11111111]
  bitfill2()=[%11111111,%11111110,%11111100,%11111000,%11110000,%11100000,%11000000,%10000000,%00000000]
  ' Hier werden wichtige Anfangswerte gesetzt!
  For I%=9 Downto 0 !I&
    Read Pname$(I%) !I&
  Next I% !I&
  ' Bewegungsschema des Kreisel-Monsters
  KreiselX%(0)=-24
  KreiselY%(0)=8
  KreiselX%(1)=-24
  KreiselY%(1)=8
  KreiselX%(2)=-16
  KreiselY%(2)=16
  KreiselX%(3)=-8
  KreiselY%(3)=24
  KreiselX%(4)=-8
  KreiselY%(4)=24
  KreiselX%(5)=8
  KreiselY%(5)=24
  KreiselX%(6)=8
  KreiselY%(6)=24
  KreiselX%(7)=16
  KreiselY%(7)=16
  KreiselX%(8)=24
  KreiselY%(8)=8
  KreiselX%(9)=24
  KreiselY%(9)=8
  KreiselX%(10)=24
  KreiselY%(10)=-8
  KreiselX%(11)=24
  KreiselY%(11)=-8
  KreiselX%(12)=16
  KreiselY%(12)=-16
  KreiselX%(13)=8
  KreiselY%(13)=-24
  KreiselX%(14)=8
  KreiselY%(14)=-24
  KreiselX%(15)=-8
  KreiselY%(15)=-24
  KreiselX%(16)=-8
  KreiselY%(16)=-24
  KreiselX%(17)=-16
  KreiselY%(17)=-16
  KreiselX%(18)=-24
  KreiselY%(18)=-8
  KreiselX%(19)=-24
  KreiselY%(19)=-8
  @Highscor_einlesen
  Print "Ende: Werte"
Return
Procedure Stones
  ' Der Spieler steht auf einem Stein!!
  ' Welcher Stein wird vom Spieler gerade betreten, was f"+Chr$(129)+"r Auswirkungen hat das?
  ' 1 verschwindeplattform, 11 (?)Leben, 17 Box, 18-20 Geld, 22 magnet,23 Schalter, 28-29,30 steiniger Stein
  ' 37 kleber, 8 plattformklkebt, 48-50 Minusgeld
  ' stehen auf -1 ???
  Deffill 0,0,0
    print hcx+(A%+1)/40,Y%/40+2
   ' GPrint At(5,1);C|(hcx+(A%+1)/40,Y%/40+2)'
	print (hcx+(A%-1)/40+1,Y%/40+2)
   ' GPrint At(11,1);C|(hcx+(A%-1)/40+1,Y%/40+2)'
  Dielf%=0
  Zahlen%=((Zahlen%+1) Mod 128)
  For I%=0 To 2 !I&
    If ((Zeit%(I%)+5) Mod 128)<Zahlen%
      Gosub Auflosen_27
    Endif
  Next I%
  Hilfe10&=0
  If Int((A%+1)/40)=Int((A%-1)/40)
    '                                       Die Figur steht auf zwei Steinen
    @2_stones
  Else
    '                                       Die Figur steht auf einem Steinen
	print "stehe auf:",C|(CX%-15+(A%-1)/40+1,Y%/40+2)
    Select C|(CX%-15+(A%-1)/40+1,Y%/40+2)
    Case 31
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @Wscroll !Wscroll
    Case 16
      Add Punkte%,749
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
    Case 11
      Inc Lebem|(Akt&)
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
    Case 1
      If ((CX%-15+(A%-1)/40+1)<>(HA%(Auflosen%))) Or ((Y%/40+2)<>HY%(Auflosen%))
        Auflosen%=Auflosen%+1
        If Auflosen%=3
          Auflosen%=0
        Endif
        Zeit%(Auflosen%)=Zahlen%
        HA%(Auflosen%)=CX%-15+(A%-1)/40+1
        HY%(Auflosen%)=Y%/40+2
		print "auflosen",Auflosen%,Zahlen%,CX%-15+(A%-1)/40+1,Y%/40+2
      Endif
    Case 2,3,4
      If Zahlen%/2=Int(Zahlen%/2)
        If A%>8
          Bewhil&=1
          @Zur
          Bewhil&=0
        Endif
      Endif
    Case 18
      Add Punkte%,10
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 19
      Add Punkte%,20
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 20
      Add Punkte%,30
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17))  !@put_pic(A%,Y%+63,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 48
      Sub Punkte%,10
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 49
      Sub Punkte%,20
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 50
      Sub Punkte%,30
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 58
      Dec Lebem|(Akt&)
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=59
      @put_pic_wh(A%,Y%+63,40,40,B$(59)) ! Put A%,Y%+63,B$(59)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
      If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
        @Figur_selection
      Endif
    Case 21
      If Y%/40>1
        If kb%(KEYDOWN%)=1 ! Stick(1)=2
          @put_back1  !Put A%,Y%,Back$
          For I%=0 To 9 !I&
            Y%=Y%-4
            Ap%=1
            If Ri%=4
              Ap%=4
            Endif
            Get A%,Y%,40,64,Back$
			Aalt%=A%
            Yalt%=Y%
			'---
			GRAPHMODE 2
            COLOR blue,yellow
            @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&)) ! Put A%,Y%,S$(Ap%,Zu&+Skeletti&),4
			COLOR yellow,blue
            @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&)) ! Put A%,Y%,Fig$(Ap%,Zu&+Skeletti&),6
            @put_pic_wh(A%,Y%+63,40,40,B$(21)) ! Put A%,Y%+63,B$(21)
			GRAPHMODE 1
			@show_wait
            '---
            'Rc_copy Scr1%,A%,Y%,40,79 To Scr2%,A%,Y%
            @put_back1  !Put A%,Y%,Back$
            @Monster
          Next I%
          C|(CX%-15+(A%-1)/40+1,Y%/40+2)=21
        Endif
      Endif
    Case 22,57
      Dielf%=1
    Case 23
      @Schalter
    Case 27
      Dec Lebem|(Akt&)
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
      If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
        @Figur_selection
      Endif
    Case 32,12
      If C|(CX%-15+(A%-1)/40+1,Y%/40+3)=0 And Int(Y%/40+3)<=9
        C|(CX%-15+(A%-1)/40+1,Y%/40+3)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)
        Pbox A%,Y%+63,A%+39,Y%+63+39
        @put_pic_wh(A%,Y%+63+40,40,40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+3))) ! Put A%,Y%+63+40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+3))
        C|(CX%-15+(A%-1)/40+1,Y%/40+2)=0
        'Rc_copy Scr1%,A%,Y%+63,40,80 To Scr2%,A%,Y%+63
      Else if Int(Y%/40+3)=10
        C|(CX%-15+(A%-1)/40+1,9)=0
        Pbox A%,Y%+63,A%+39,Y%+63+39
        'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
      Endif
    Case 34,14
      If C|(CX%-15+(A%-1)/40+1,Y%/40+3)=0 And Int(Y%/40+3)<=9
        C|(CX%-15+(A%-1)/40+1,Y%/40+3)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)
        Pbox A%,Y%+63,A%+39,Y%+63+39
        @put_pic_wh(A%,Y%+63+40,40,40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+3))) ! Put A%,Y%+63+40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+3))
        C|(CX%-15+(A%-1)/40+1,Y%/40+2)=0
        'Rc_copy Scr1%,A%,Y%+63,40,80 To Scr2%,A%,Y%+63
      Else if Int(Y%/40+3)=10
        C|(CX%-15+(A%-1)/40+1,9)=0
        COLOR blue,yellow
        Pbox A%,Y%+63,A%+39,Y%+63+39
        COLOR yellow,blue
        'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
      Endif
    Case 37,56,8
      Dielf%=7
    Case 46
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
      Get A%,Y%+63-110,39,39,Bacm$
      Put A%,Y%+63-110,Bacm$
      For Wait%=0 To 70
	  '  print "wait for me"
        Pause 0.01 !1
        @Monster
        @Tod_oder_nicht
		print "nachtododnicht"
        Hz&=((Hz&+1) Mod 8)
        Get A%,Y%+63-110,39,39,Bacm$
		'---
		GRAPHMODE 2
        COLOR blue,yellow
        @put_pic(A%,Y%+63-110,B$(55)) ! Put A%,Y%+63-110,B$(55),4
        COLOR yellow,blue
        @put_pic(A%,Y%+63-110,B$(51+(Hz&/2))) ! Put A%,Y%+63-110,B$(51+(Hz&/2)),7
        GRAPHMODE 1
		@show_wait
        '---
        'Rc_copy Scr1%,A%,Y%+63-110,40,40 To Scr2%,A%,Y%+63-110
        Put A%,Y%+63-110,Bacm$
      Next Wait%
      'Rc_copy Scr1%,A%,Y%+63-110,40,40 To Scr2%,A%,Y%+63-110
      @put_pic_wh(A%,Y%+63,40,40,B$(17)) ! Put A%,Y%+63,B$(17)
      'Rc_copy Scr1%,A%,Y%+63,40,40 To Scr2%,A%,Y%+63
    Case 9
      Skeletti&=((Skeletti&+1) Mod 2)
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
    Case 100
      If kb%(KEYDOWN%)=1 ! If Stick(1)=2
        @put_back1  !Put A%,Y%,Back$                          !Restaurire den Hintergrund
        Add Y%,8                                 !Lasse die Frucht ein St"+Chr$(129)+"ck fallen
        Get A%,Y%,40,64,Back$              !Rette den hintergrund
		Aalt%=A%
        Yalt%=Y%
		'---
		GRAPHMODE 2
        COLOR blue,yellow
        @put_pic(A%,Y%,S$(O|,Zu&+Skeletti&)) ! Put A%,Y%,S$(O|,Zu&+Skeletti&),4         !Maskiere sie aus
        COLOR yellow,blue
        @put_pic(A%,Y%,Fig$(O|,Zu&+Skeletti&)) ! Put A%,Y%,Fig$(O|,Zu&+Skeletti&),6       !male die Frucht hin
        GRAPHMODE 1
		@show_wait
        '---
        'Rc_copy Scr1%,A%,Y%-8,40,71 To Scr2%,A%,Y%-8 !kopiere die Frucht r"+Chr$(129)+"ber
        @put_back1  !Put A%,Y%,Back$                          !Restaurire den Hintergrund
      Endif
    Endselect
  Endif
Return
Procedure 2_stones
  ' Der Spieler steht auf zwei Steinen!!
  ' Welche Steine werden vom Spieler gerade betreten, was f"+Chr$(129)+"r Auswirkungen hat das?
  DummY%=0
  Deffill 0,0,0
  print CX%-15+(A%+1)/40,Y%/40+2
  print "2-stones",CX%,A%,Y%
  Select C|(CX%-15+(A%+1)/40,Y%/40+2)
  Case 9
    Skeletti&=((Skeletti&+1) Mod 2)
    C|(CX%-15+(A%+1)/40,Y%/40+2)=17
  Case 58
    Dec Lebem|(Akt&)
    C|(CX%-15+(A%+1)/40,Y%/40+2)=59
    HilA%=(A%+1)/40
    HilY%=Y%/40+2
    @put_pic_wh(HilA%*40,HilY%*40,40,40,B$(59)) ! Put HilA%*40,HilY%*40,B$(59)
    'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
    If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
      @Figur_selection
    Endif
  Case 2,3,4
    If Zahlen%/2=Int(Zahlen%/2)
      If A%>8
        Bewhil&=1
        @Zur
        Bewhil&=0
      Endif
    Endif
    Hilfe10&=1
  Case 22,57
    Dielf%=1
  Case 25,59
    @Rutsch_stein
  Case 27
    Dec Lebem|(Akt&)
    C|(CX%-15+(A%+1)/40,Y%/40+2)=17
    HilA%=(A%+1)/40
    HilY%=Y%/40+2
    @put_pic_wh(HilA%*40,HilY%*40,40,40,B$(17)) ! Put HilA%*40,HilY%*40,B$(17)
    'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
    If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
      @Figur_selection
    Endif
  Case 32,12
    If C|(CX%-15+(A%+1)/40,Y%/40+3)=0 And Int(Y%/40+3)<=9
      C|(CX%-15+(A%+1)/40,Y%/40+3)=C|(CX%-15+(A%+1)/40,Y%/40+2)
      C|(CX%-15+(A%+1)/40,Y%/40+2)=0
      HilA%=(A%+1)/40
      HilY%=Y%/40+2
      Pbox HilA%*40,HilY%*40,HilA%*40+39,HilY%*40+39
      @put_pic_wh(HilA%*40,HilY%*40+40,40,40,B$(C|(CX%-15+(A%+1)/40,Y%/40+3))) ! Put HilA%*40,HilY%*40+40,B$(C|(CX%-15+(A%+1)/40,Y%/40+3))
      'Rc_copy Scr1%,HilA%*40,HilY%*40,40,80 To Scr2%,HilA%*40,HilY%*40
    Else if Int(Y%/40+3)=10
      C|(CX%-15+(A%+1)/40,9)=0
      HilA%=(A%+1)/40
      Pbox HilA%*40,9*40,HilA%*40+39,9*40+39 !Pbox HilA%*40,9*40,HilA%*40+39,9*40+39
      'Rc_copy Scr1%,HilA%*40,9*40,40,40 To Scr2%,HilA%*40,9*40
    Endif
  Case 33,15
    If Ri%=4
      If C|(CX%-15+(A%+1)/40+1,Y%/40+2)=0
        C|(CX%-15+(A%+1)/40+1,Y%/40+2)=C|(CX%-15+(A%+1)/40,Y%/40+2)
        C|(CX%-15+(A%+1)/40,Y%/40+2)=0
        HilA%=(A%+1)/40
        HilY%=Y%/40+2
        @put_pic(HilA%*40+40,HilY%*40,B$(C|(CX%-15+(A%+1)/40+1,Y%/40+2))) ! Put HilA%*40+40,HilY%*40,B$(C|(CX%-15+(A%+1)/40+1,Y%/40+2))
        'brauchenwirdas?! Pbox HilA%*40,HilY%*40,HilA%*40+39,HilY%*40+39
        'Rc_copy Scr1%,HilA%*40,HilY%*40,80,40 To Scr2%,HilA%*40,HilY%*40
      Endif
    Endif
  Case 36,13
    If Ri%=4
      If C|(CX%-15+(A%+1)/40+1,Y%/40+3)=0 And Y%/40+3<=9
        C|(CX%-15+(A%+1)/40+1,Y%/40+3)=C|(CX%-15+(A%+1)/40,Y%/40+2)
        C|(CX%-15+(A%+1)/40,Y%/40+2)=0
        HilA%=(A%+1)/40
        HilY%=Y%/40+2
        @put_pic(HilA%*40+40,HilY%*40+40,B$(C|(CX%-15+(A%+1)/40+1,Y%/40+3))) ! Put HilA%*40+40,HilY%*40+40,B$(C|(CX%-15+(A%+1)/40+1,Y%/40+3))
        'wieoben?!Pbox HilA%*40,HilY%*40,HilA%*40+39,HilY%*40+39
        'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
        'Rc_copy Scr1%,HilA%*40+40,HilY%*40+40,40,40 To Scr2%,HilA%*40+40,HilY%*40+40
      Endif
    Endif
  Case 37,56
    Dielf%=7
  Case 8
    DummY%=1
  Endselect
  Select C|(CX%-15+(A%-1)/40+1,Y%/40+2)
  Case 9
    C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
    Skeletti&=((Skeletti&+1) Mod 2)
  Case 2,3,4
    If Hilfe10&=0
      If Zahlen%/2=Int(Zahlen%/2)
        If A%>8
          Bewhil&=1
          @Zur
          Bewhil&=0
        Endif
      Endif
    Endif
  Case 22,57
    Dielf%=1
  Case 25,59
    @Rutsch_stein
  Case 58
    Dec Lebem|(Akt&)
    C|(CX%-15+(A%-1)/40+1,Y%/40+2)=59
    HilA%=(A%-1)/40+1
    HilY%=Y%/40+2
    @put_pic_wh(HilA%*40,HilY%*40,40,40,B$(59)) ! Put HilA%*40,HilY%*40,B$(59)
    'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
    If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
      @Figur_selection
    Endif
  Case 27
    Dec Lebem|(Akt&)
    C|(CX%-15+(A%-1)/40+1,Y%/40+2)=17
    HilA%=(A%-1)/40+1
    HilY%=Y%/40+2
    @put_pic_wh(HilA%*40,HilY%*40,40,40,B$(17)) ! Put HilA%*40,HilY%*40,B$(17)
    'Rc_copy Scr1%,HilA%*40,HilY%*40,40,40 To Scr2%,HilA%*40,HilY%*40
    If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
      @Figur_selection
    Endif
  Case 32,12
    If C|(CX%-15+(A%-1)/40+1,Y%/40+3)=0 And Int(Y%/40+3)<=9
      C|(CX%-15+(A%-1)/40+1,Y%/40+3)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=0
      HilA%=(A%-1)/40+1
      HilY%=Y%/40+2
      Pbox HilA%*40,HilY%*40,HilA%*40+39,HilY%*40+39
      @put_pic_wh(HilA%*40,HilY%*40+40,40,40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+3))) ! Put HilA%*40,HilY%*40+40,B$(C|(CX%-15+(A%-1)/40+1,Y%/40+3))
      'Rc_copy Scr1%,HilA%*40,HilY%*40,40,80 To Scr2%,HilA%*40,HilY%*40
    Else if Int(Y%/40+3)=10
      C|(CX%-15+(A%-1)/40+1,Y%/40+2)=0
      HilA%=(A%-1)/40+1
      Pbox HilA%*40,9*40,HilA%*40+39,9*40+39
      'Rc_copy Scr1%,HilA%*40,9*40,40,40 To Scr2%,HilA%*40,9*40
    Endif
  Case 33,15
    If Ri%=3
      If C|(CX%-15+(A%-1)/40,Y%/40+2)=0
        C|(CX%-15+(A%-1)/40,Y%/40+2)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)
        C|(CX%-15+(A%-1)/40+1,Y%/40+2)=0
        HilA%=(A%-1)/40
        HilY%=Y%/40+2
        Pbox HilA%*40+40,HilY%*40,HilA%*40+79,HilY%*40+39
        @put_pic_wh(HilA%*40,HilY%*40,40,40,B$(C|(CX%-15+(A%-1)/40,Y%/40+2))) ! Put HilA%*40,HilY%*40,B$(C|(CX%-15+(A%-1)/40,Y%/40+2))
        'Rc_copy Scr1%,HilA%*40,HilY%*40,80,40 To Scr2%,HilA%*40,HilY%*40
      Endif
    Endif
  Case 36,13
    If Ri%=3
      If C|(CX%-15+(A%-1)/40,Y%/40+3)=0 And Y%/40+3<=9
        C|(CX%-15+(A%-1)/40,Y%/40+3)=C|(CX%-15+(A%-1)/40+1,Y%/40+2)
        C|(CX%-15+(A%-1)/40+1,Y%/40+2)=0
        HilA%=(A%-1)/40
        HilY%=Y%/40+2
        Pbox HilA%*40+40,HilY%*40,HilA%*40+79,HilY%*40+39
        @put_pic_wh(HilA%*40,HilY%*40+40,40,40,B$(C|(CX%-15+(A%-1)/40,Y%/40+3))) ! Put HilA%*40,HilY%*40+40,B$(C|(CX%-15+(A%-1)/40,Y%/40+3))
        'Rc_copy Scr1%,HilA%*40+40,HilY%*40,40,40 To Scr2%,HilA%*40+40,HilY%*40
        'Rc_copy Scr1%,HilA%*40,HilY%*40+40,40,40 To Scr2%,HilA%*40,HilY%*40+40
      Endif
    Endif
  Case 37,56
    Dielf%=7
  Case 8
    If DummY%=1
      Dielf%=7
    Endif
  Endselect
Return
Procedure Auflosen_27
  ' In dieser Procedure werden die Platformsteine aufgel"+Chr$(148)+"st!
  If HA%(I%)>-1 !I&
    Deffill 0
	@put_pic_wh((HA%(I%)+15-CX%)*40,HY%(I%)*40,40,40,Auflos$)  !@put_pic((HA%(I%)+15-CX%)*40,HY%(I%)*40,Auflos$) ! Put (HA%(I%)+15-CX%)*40,HY%(I%)*40,Auflos$
    C|(HA%(I%),HY%(I%))=0
    Add Punkte%,2
    'Rc_copy Scr1%,(HA%(I&)+15-CX%)*40,HY%(I&)*40,40,40 To Scr2%,(HA%(I&)+15-CX%)*40,HY%(I&)*40
    HA%(I%)=-49
  Endif
Return
Procedure Monster
  ' In dieser Procedure wird entschieden welche monster sich in diesem Durchlauf
  ' bewegen(immer maximal 3 von maximal 6 Monstern(aus geschwindigkeitsgr"+Chr$(129)+"nden!))!
 ' print "Monster"
  @Aktanzeigen
  @Abfrage_2
  @Tod_oder_nicht
'  print "tod?"
 ' pause 0.3
'@put_BackMPlatt
'@put_BackMall
@put_BackMPlanz
@put_BackMPSchwalb
  Add Monshil%,1  ! % statt &
  If Monshil%=2
    Monshil%=0
  Endif
  If Monshil%=1
@put_backM1
    For P%=0 To 2 !P%
      @Monster_select
BachmA$(P%)=Bachm$
Bachm$=""
    Next P%
  Else
@put_backM2
    For P%=3 To 5
      @Monster_select	  		  
 BachmA$(P%)=Bachm$
Bachm$=""
    Next P%
  Endif
'  print "vor timer"
 ' While Timer<Ts%+0.3  !8
 ' Wend
 ' Ts%=Timer
Return
Procedure Monster_select
  ' In dieser Procedure werden den Nummern der momentan aktiven Monster
  ' Ihre Steuerungs-Proceduren zugeteilt!
  'print "monster",Monstertyp&(P%)
  Select Monstertyp&(P%)
  Case 115
    @Pflanze
  Case 114
    @Schwalbe_mit_sturzflug
  Case 113
    @Pfeil
  Case 112
    @Bombe
  Case 111
    @Platform
  Case 109
    @Feuer
  Case 107
    @Stacheln
  Case 106
    @Auge
  Case 105
    @Purzel
  Case 104
    @Wabbel
  Case 103
    @Qualle
  Case 102
    Hohesprung&=6
    @Fisch
  Case 101
    Hohesprung&=4
    @Fisch
  Case 100
    @Schwalbe
  Case 99
    @Main_ball
  Case 98
    @Main_krote
  Case 97
    @Gummi
  Case 96
    @Masse
  Case 95
    @Schussstein
  Case 94
    @Kreisel
  Endselect
Return
Procedure Pflanze
  print "pflanze"
  ' Steuerung dieses Monsters!
  If X%(P%)>0
    Select R%(P%)
    Case 0
      ' AUF UND AB
      Zahlm%(P%)=((Zahlm%(P%)+1) Mod 14)
      If Zahlm%(P%)>3 And Zahlm%(P%)<12
        If Zahlm%(P%)<8
          Add GZ%(P%),8
        Else if Zahlm%(P%)>7
          Sub GZ%(P%),8
        Endif
      Else
        GZ%(P%)=0
      Endif
	  	  'merke koordinaten von BackmPF
	  XPz_alt%= X%(P%)
	  YPz_alt% = Y%(P%)-GZ%(P%)-8
      Get X%(P%),Y%(P%)-GZ%(P%)-8,39+1,Y%(P%)-(Y%(P%)-GZ%(P%)-8)+1,BackmPz$ !Get X%(P%),Y%(P%)-GZ%(P%)-8,39,Y%(P%)-(Y%(P%)-GZ%(P%)-8),Backm$
      @put_pic(X%(P%),Y%(P%)-GZ%(P%),Auftauch$(Zahlm%(P%))) ! Put X%(P&),Y%(P&)-GZ%(P&),Auftauch$(Zahlm%(P&))
      'Rc_copy Scr1%,X%(P&),Y%(P&)-GZ%(P&)-8,40,48 To Scr2%,X%(P&),Y%(P&)-GZ%(P&)-8
    '  Put X%(P%),Y%(P%)-GZ%(P%)-8,Backm$
    Case 1
      ' Ein- und ENTFALTEN
      Zahlm%(P%)=((Zahlm%(P%)+1) Mod 11)
      If Zahlm%(P%)=10
        @put_pic(X%(P%),Y%(P%),B$(17)) ! Put X%(P&),Y%(P&),B$(17)
        'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
        R%(P%)=2
        Zahlm%(P%)=-1
      Else
        @put_pic(X%(P%),Y%(P%),Zerstampf$(Zahlm%(P%)/2)) ! Put X%(P&),Y%(P&),Zerstampf$(Zahlm%(P&)/2)
        'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
      Endif
    Case 2
      ' KLETTERPFLANZE  TEIL 1
      Zahlm%(P%)=Zahlm%(P%)+1
      If Zahlm%(P%)>3
        If Zahlm%(P%)<8
          Add GZ%(P%),8
        Else if Zahlm%(P%)<10
          C|(CX%-15+(X%(P%)-1)/40+1,(Y%(P%)-GZ%(P%))/40)=100
          Add GZ%(P%),7
        Endif
      Endif
      If Y%>0
        @put_back1  !Put A%,Y%,Back$
      Endif
      If Zahlm%(P%)<8
        @put_pic(X%(P%),Y%(P%)-GZ%(P%),Auftauch$(Zahlm%(P%))) ! Put X%(P&),Y%(P&)-GZ%(P&),Auftauch$(Zahlm%(P&))
        'Rc_copy Scr1%,X%(P&),Y%(P&)-GZ%(P&),40,40 To Scr2%,X%(P&),Y%(P&)-GZ%(P&)
      Else if Zahlm%(P%)<10
        @put_pic(X%(P%),Y%(P%)-GZ%(P%),Wachs1$(Zahlm%(P%)-8)) ! Put X%(P&),Y%(P&)-GZ%(P&),Wachs1$(Zahlm%(P&)-8)
        'Rc_copy Scr1%,X%(P&),Y%(P&)-GZ%(P&),40,40 To Scr2%,X%(P&),Y%(P&)-GZ%(P&)
      Endif
      If Y%>0
        Get A%,Y%,40,64,Back$
		Aalt%=A%
        Yalt%=Y%
      Endif
      If Zahlm%(P%)=10
        C|(CX%-15+(X%(P%)-1)/40+1,(Y%(P%)-GZ%(P%))/40)=100
        Add GZ%(P%),8
        R%(P%)=3
        Zahlm%(P%)=0
      Endif
    Case 3
      Add GZ%(P%),10
      If Y%>0
        @put_back1  !Put A%,Y%,Back$
      Endif
      @put_pic(X%(P%),Y%(P%)-GZ%(P%),Wachs2$(Zahlm%(P%))) ! Put X%(P&),Y%(P&)-GZ%(P&),Wachs2$(Zahlm%(P&))
      If Y%>0
        Get A%,Y%,40,64,Back$
		Aalt%=A%
        Yalt%=Y%
      Endif
      'Rc_copy Scr1%,X%(P&),Y%(P&)-GZ%(P&),40,80 To Scr2%,X%(P&),Y%(P&)-GZ%(P&)
      Zahlm%(P%)=((Zahlm%(P%)+1) Mod 8)
      C|(CX%-15+(X%(P%)-1)/40+1,(Y%(P%)-GZ%(P%))/40)=100
      If Y%(P%)-GZ%(P%)<=52
        Add GZ%(P%),3
        R%(P%)=4
        Zahlm%(P%)=0
      Endif
    Case 4
      ' Erscheinen der Bl"+Chr$(129)+"te
      If Y%>0
        @put_back1  !Put A%,Y%,Back$
      Endif
      @put_pic(X%(P%),Y%(P%)-GZ%(P%),Bluete$(Zahlm%(P%)/2)) ! Put X%(P&),Y%(P&)-GZ%(P&),Bluete$(Zahlm%(P&)/2)
      If Y%>0
        Get A%,Y%,40,64,Back$
		Aalt%=A%
        Yalt%=Y%
      Endif
      'Rc_copy Scr1%,X%(P&),Y%(P&)-GZ%(P&),40,20 To Scr2%,X%(P&),Y%(P&)-GZ%(P&)
      Inc Zahlm%(P%)
      If Zahlm%(P%)=17
        Monstertyp&(P%)=0
      Endif
    Endselect
  Else
    Monstertyp&(P%)=0
  Endif
Return
Procedure Main_ball
  print "mainball"
  ' Steuerung dieses Monsters!
  If X%(P%)<9
    Monstertyp&(P%)=0
    'If X%(P&)>-1 And Y%<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
    'Endif
    Goto Weiter1
  Endif
  Select R%(P%)
    '                3 * 1
    '                  2
  Case 1
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
        R%(P%)=2
        Goto Weiter3
      Endif
      If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>0
        R%(P%)=3
        Goto Weiter3
      Endif
    Else if X%(P%)=592
      R%(P%)=3
      Goto Weiter3
    Endif
    X%(P%)=X%(P%)+8
    Weiter3:
    GZ%(P%)=((GZ%(P%)+3) Mod 4)
    Get X%(P%),Y%(P%),40,40,Bachm$ !Get X%(P%),Y%(P%),39,39,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Ballm$) ! Put X%(P&),Y%(P&),Ballm$,4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Ball$(GZ%(P%))) ! Put X%(P&),Y%(P&),Ball$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&)-8,Y%(P&),48,40 To Scr2%,X%(P&)-8,Y%(P&)
  Case 2
    Y%(P%)=Y%(P%)+8
    If Y%(P%)=360
      Monstertyp&(P%)=0
      'Rc_copy Scr1%,X%(P&),Y%(P&)-8,40,40 To Scr2%,X%(P&),Y%(P&)-8
      Goto Weiter1
    Endif
    If (Y%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)>0
        R%(P%)=3
      Endif
    Endif
    GZ%(P%)=((GZ%(P%)+3) Mod 4)
    Get X%(P%),Y%(P%),40,40,Bachm$ !Get X%(P%),Y%(P%),39,39,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Ballm$) ! Put X%(P&),Y%(P&),Ballm$,4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Ball$(GZ%(P%))) ! Put X%(P&),Y%(P&),Ball$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&)-8,40,48 To Scr2%,X%(P&),Y%(P&)-8
  Case 3
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
        R%(P%)=2
        Goto Weiter2
      Endif
      If C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>0
        R%(P%)=1
        Goto Weiter2
      Endif
    Endif
    X%(P%)=X%(P%)-8
    Weiter2:
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Get X%(P%),Y%(P%),40,40,Bachm$ !Get X%(P%),Y%(P%),39,39,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Ballm$) ! Put X%(P&),Y%(P&),Ballm$,4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Ball$(GZ%(P%))) ! Put X%(P&),Y%(P&),Ball$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&),48,40 To Scr2%,X%(P&),Y%(P&)
  Default
    Goto Weiter1
  Endselect
  'Put X%(P%),Y%(P%),Bachm$
  Weiter1:
Return
Procedure Main_krote
print "mainkroete"
  ' Steuerung dieses Monsters!
  If X%(P%)<5
    Monstertyp&(P%)=0
    'If X%(P%)>-1
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,20 To Scr2%,X%(P&),Y%(P&)
    'Endif
    Goto Weiterk1
  Endif
  Select R%(P%)
  Case 1
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40+1)=0 Or C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>7
        R%(P%)=2
        Goto Weiterk3
      Endif
    Else if X%(P%)=596
      R%(P%)=2
      Goto Weiterk3
    Endif
    X%(P%)=X%(P%)+4
    Weiterk3:
    GZ%(P%)=((GZ%(P%)+1) Mod 16)
    Get X%(P%),Y%(P%),40,20,Bachm$  ! Get X%(P%),Y%(P%),39,19,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Krotem$(1,GZ%(P%)/8)) ! Put  X%(P&),Y%(P&),Krotem$(1,GZ%(P&)/8),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Krote$(1,GZ%(P%)/8)) ! Put  X%(P&),Y%(P&),Krote$(1,GZ%(P&)/8),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&)-4,Y%(P&),44,20 To Scr2%,X%(P&)-4,Y%(P&)
  Case 2
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40+1)=0 Or C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>7
        R%(P%)=1
        Goto Weiterk2
      Endif
    Endif
    X%(P%)=X%(P%)-4
    Weiterk2:
    GZ%(P%)=((GZ%(P%)+1) Mod 16)
    Get X%(P%),Y%(P%),40,20,Bachm$  !Get X%(P%),Y%(P%),39,19,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Krotem$(0,GZ%(P%)/8)) ! Put  X%(P&),Y%(P&),Krotem$(0,GZ%(P&)/8),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Krote$(0,GZ%(P%)/8)) ! Put  X%(P&),Y%(P&),Krote$(0,GZ%(P&)/8),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&),44,20 To Scr2%,X%(P&),Y%(P&)
  Default
    Goto Weiterk1
  Endselect
  'Put X%(P%),Y%(P%),Bachm$
  Weiterk1:
Return
Procedure Wabbel
print "wabbel"
  ' Steuerung dieses Monsters!
  If X%(P%)<6
    Monstertyp&(P%)=0
    'If X%(P%)>-1
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,25 To Scr2%,X%(P&),Y%(P&)
    'Endif
    Goto Weiterka1
  Endif
  Select R%(P%)
  Case 1
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40+1)=0 Or C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>7
        R%(P%)=2
        Goto Weiterka3
      Endif
    Else if X%(P%)=595
      R%(P%)=2
      Goto Weiterka3
    Endif
    X%(P%)=X%(P%)+5
    Weiterka3:
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Get X%(P%),Y%(P%),40,21,Bachm$ !anderen buffer Bachm statt Bacm !Get X%(P%),Y%(P%),39,20,Bacm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Wabbelm$(GZ%(P%))) ! Put X%(P&),Y%(P&),Wabbelm$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Wabbel$(GZ%(P%))) ! Put X%(P&),Y%(P&),Wabbel$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&)-5,Y%(P&),45,21 To Scr2%,X%(P&)-5,Y%(P&)
  Case 2
    If X%(P%) Mod (40)=0
      If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40+1)=0 Or C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>7
        R%(P%)=1
        Goto Weiterka2
      Endif
    Endif
    X%(P%)=X%(P%)-5
    Weiterka2:
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Get X%(P%),Y%(P%),40,21,Bachm$ !anderen buffer Bachm statt Bacm  !Get X%(P%),Y%(P%),39,20,Bacm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Wabbelm$(GZ%(P%))) ! Put X%(P&),Y%(P&),Wabbelm$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Wabbel$(GZ%(P%))) ! Put X%(P&),Y%(P&),Wabbel$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&),45,21 To Scr2%,X%(P&),Y%(P&)
  Default
    Goto Weiterka1
  Endselect
 ' Put X%(P%),Y%(P%),Bacm$
  Weiterka1:
Return
Procedure Masse
print "masse"
  ' Steuerung dieses Monsters!
  '                                1  2  3
  '                                4  *  5
  '                                6  7  8
  GZ%(P%)=((GZ%(P%)+1) Mod 36)
  If GZ%(P%)=0
    R%(P%)=Random(8)+1
    For Imasse&=0 To 6
      Select R%(P%)
      Case 1
        If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40-1)>0
          R%(P%)=2
        Else
          Exit if 0=0
        Endif
      Case 2
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40-1)>0
          R%(P%)=3
        Else
          Exit if 0=0
        Endif
      Case 3
        If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40-1)>0 Or X%(P%)=600
          R%(P%)=4
        Else
          Exit if 0=0
        Endif
      Case 4
        If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40)>0
          R%(P%)=5
        Else
          Exit if 0=0
        Endif
      Case 5
        If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>0 Or X%(P%)=600
          R%(P%)=6
        Else
          Exit if 0=0
        Endif
      Case 6
        If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40+1)>0
          R%(P%)=7
        Else
          Exit if 0=0
        Endif
      Case 7
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)>0
          R%(P%)=8
        Else
          Exit if 0=0
        Endif
      Case 8
        If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40+1)>0 Or X%(P%)=600
          R%(P%)=1
        Else
          Exit if 0=0
        Endif
      Endselect
    Next Imasse&
    Select R%(P%)
    Case 1
      Sub X%(P%),40
      Sub Y%(P%),40
    Case 2
      Sub Y%(P%),40
    Case 3
      Add X%(P%),40
      Sub Y%(P%),40
    Case 4
      Sub X%(P%),40
    Case 5
      Add X%(P%),40
    Case 6
      Sub X%(P%),40
      Add Y%(P%),40
    Case 7
      Add Y%(P%),40
    Case 8
      Add X%(P%),40
      Add Y%(P%),40
    Endselect
  Endif
  If X%(P%)>=0 And X%(P%)<=600 And Y%(P%)>=40 And Y%(P%)<=360
    @put_pic(Put X%(P%),Y%(P%),Masse$(GZ%(P%) Mod 4)) ! Put X%(P%),Y%(P%),Masse$(GZ%(P%) Mod 4)
    C|(CX%-15+X%(P%)/40,Y%(P%)/40)=17
    'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
  Else
    Monstertyp&(P%)=0
  Endif
Return
Procedure Auge
print "auge"
  ' Steuerung dieses Monsters!
  '         1   2
  '           *
  '         3 5 4
  GZ%(P%)=((GZ%(P%)+1) Mod 4)
  If GZ%=0
    If X%(P%)=610
      Select R%(P%)
      Case 2
        R%(P%)=1
      Case 4
        R%(P%)=3
      Endselect
    Endif
  Endif
  If X%(P%)>=20 And Y%(P%)<360
    Select R%(P%)
    Case 5
      Add Y%(P%),10
      Get X%(P%),Y%(P%),20,40,Bachm$
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Augem$(0)) ! Put X%(P&),Y%(P&),Augem$(0),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Auge$(0,GZ%(P%))) ! Put X%(P&),Y%(P&),Auge$(0,GZ%(P&)),7
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,X%(P&),Y%(P&)-10,20,50 To Scr2%,X%(P&),Y%(P&)-10
      'Put X%(P%),Y%(P%),Bachm$
      If (Y%(P%) Mod 40)=0 And Y%(P%)<360
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)>0
          R%(P%)=2
        Endif
      Endif
    Case 4
      Add Y%(P%),10
      Add X%(P%),10
      Get X%(P%),Y%(P%),20,40,Bachm$
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Augem$(GZ%(P%))) ! Put X%(P&),Y%(P&),Augem$(GZ%(P&)),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Auge$(1,GZ%(P%))) ! Put X%(P&),Y%(P&),Auge$(1,GZ%(P&)),7
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,X%(P&)-10,Y%(P&)-10,30,50 To Scr2%,X%(P&)-10,Y%(P&)-10
    '  Put X%(P%),Y%(P%),Bachm$
      If (Y%(P%) Mod 40)=0 And Y%(P%)<360
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
          R%(P%)=5
        Else if C|(CX%-15+X%(P%)/40+1,Y%(P%)/40-1)>0
          R%(P%)=1
        Else
          R%(P%)=2
        Endif
      Endif
    Case 3
      Add Y%(P%),10
      Sub X%(P%),10
      Get X%(P%),Y%(P%),20,40,Bachm$
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Augem$(GZ%(P%))) ! Put X%(P&),Y%(P&),Augem$(GZ%(P&)),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Auge$(1,GZ%(P%))) ! Put X%(P&),Y%(P&),Auge$(1,GZ%(P&)),7
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,X%(P&),Y%(P&)-10,30,50 To Scr2%,X%(P&),Y%(P&)-10
     ' Put X%(P%),Y%(P%),Bachm$
      If (Y%(P%) Mod 40)=0 And Y%(P%)<360
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
          R%(P%)=5
        Else if C|(CX%-15+X%(P%)/40-1,Y%(P%)/40-1)>0
          R%(P%)=2
        Else
          R%(P%)=1
        Endif
      Endif
    Case 2
      Sub Y%(P%),10
      Add X%(P%),10
      Get X%(P%),Y%(P%),20,40,Bachm$
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Augem$(GZ%(P%))) ! Put X%(P&),Y%(P&),Augem$(GZ%(P&)),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Auge$(1,GZ%(P%))) ! Put X%(P&),Y%(P&),Auge$(1,GZ%(P&)),7
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,X%(P&)-10,Y%(P&),30,50 To Scr2%,X%(P&)-10,Y%(P&)
      'Put X%(P%),Y%(P%),Bachm$
      If (Y%(P%) Mod 40)=0 And Y%(P%)<360
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
          R%(P%)=4
          If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>0
            R%(P%)=3
          Endif
        Else if C|(CX%-15+X%(P%)/40+1,Y%(P%)/40-1)>0
          R%(P%)=1
        Endif
      Endif
    Case 1
      Sub Y%(P%),10
      Sub X%(P%),10
      Get X%(P%),Y%(P%),20,40,Bachm$
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Augem$(GZ%(P%))) ! Put X%(P&),Y%(P&),Augem$(GZ%(P&)),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Auge$(1,GZ%(P%))) ! Put X%(P&),Y%(P&),Auge$(1,GZ%(P&)),7
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,X%(P&),Y%(P&),30,50 To Scr2%,X%(P&),Y%(P&)
     ' Put X%(P%),Y%(P%),Bachm$
      If (Y%(P%) Mod 40)=0 And Y%(P%)<360
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
          R%(P%)=3
          If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40)>0
            R%(P%)=4
          Endif
        Else if C|(CX%-15+X%(P%)/40-1,Y%(P%)/40-1)>0
          R%(P%)=2
        Endif
      Endif
    Endselect
  Else
    Monstertyp&(P%)=0
    'If X%(P%)>0 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),20,40 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Endif
Return
Procedure Purzel
print "purzel" !purzelnder wurm
  ' Steuerung dieses Monsters!
  If X%(P%)<9 Or Y%(P%)>351
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
    'Endif
    Goto Weiter1
  Endif
  Select R%(P%)
    '                3 * 1
    '                  2
  Case 1
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
        R%(P%)=2
        Goto Weit3
      Endif
      If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>0
        R%(P%)=3
        Goto Weit3
      Endif
    Else if X%(P%)=592
      R%(P%)=3
      Goto Weit3
    Endif
    X%(P%)=X%(P%)+8
    Weit3:
    GZ%(P%)=((GZ%(P%)+3) Mod 4)
    Get X%(P%),Y%(P%),40,40,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Purzelm$(GZ%(P%))) ! Put X%(P&),Y%(P&),Purzelm$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Purzel$(GZ%(P%))) ! Put X%(P&),Y%(P&),Purzel$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&)-8,Y%(P&),48,40 To Scr2%,X%(P&)-8,Y%(P&)
  Case 2
    Y%(P%)=Y%(P%)+8
    If (Y%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)>0
        R%(P%)=3
      Endif
    Endif
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Get X%(P%),Y%(P%),40,40,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Purzelm$(GZ%(P%))) ! Put X%(P&),Y%(P&),Purzelm$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Purzel$(GZ%(P%))) ! Put X%(P&),Y%(P&),Purzel$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&)-8,40,48 To Scr2%,X%(P&),Y%(P&)-8
  Case 3
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40+1)=0
        R%(P%)=2
        Goto Weit2
      Endif
      If C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>0
        R%(P%)=1
        Goto Weit2
      Endif
    Endif
    X%(P%)=X%(P%)-8
    Weit2:
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Get X%(P%),Y%(P%),40,40,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Purzelm$(GZ%(P%))) ! Put X%(P&),Y%(P&),Purzelm$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Purzel$(GZ%(P%))) ! Put X%(P&),Y%(P&),Purzel$(GZ%(P&)),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&),48,40 To Scr2%,X%(P&),Y%(P&)
  Default
    Goto Weit1
  Endselect
  'Put X%(P%),Y%(P%),Bachm$
  Weit1:
Return
Procedure Kreisel   !& to %
print "kreisel"
  ' Steuerung dieses Monsters!
  If X%(P%)<1
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),20,20 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else
    GZ%(P%)=((GZ%(P%)+1) Mod 32)
    Zahlm%(P%)=((Zahlm%(P%)+1) Mod 20)
    X%(P%)=X%(P%)+KreiselX%(Zahlm%(P%))  !& to %
    Y%(P%)=Y%(P%)+KreiselY%(Zahlm%(P%))
    If X%(P%)<1
      Monstertyp&(P%)=0
      'If X%(P%)>-1 And Y%(P%)<361
        'Rc_copy Scr1%,X%(P&),Y%(P&),20,20 To Scr2%,X%(P&),Y%(P&)
      'Endif
    Else if X%(P%)<621
      Get X%(P%),Y%(P%),19,19,Bachm$
	  '---
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Kreiselm$) ! Put X%(P%),Y%(P%),Kreiselm$,4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Kreisel$(GZ%(P%) Mod 4)) ! Put X%(P%),Y%(P%),Kreisel$(GZ%(P%) Mod 4),7
	  GRAPHMODE 1
	  '---
      'Rc_copy Scr1%,X%(P&)-KreiselX%(Zahlm%(P&)),Y%(P&)-KreiselY%(Zahlm%(P&)),20,20 To Scr2%,X%(P&)-KreiselX%(Zahlm%(P&)),Y%(P&)-KreiselY%(Zahlm%(P&))
      'Rc_copy Scr1%,X%(P&),Y%(P&),20,20 To Scr2%,X%(P&),Y%(P&)
     ' Put X%(P%),Y%(P%),Bachm$
    Endif
  Endif
Return
Procedure Schussstein  !auch hier &to %
  ' Steuerung dieses Monsters!
  '                              2
  '                            1 * 4
  '                              3
  Zahlm%(P%)=((Zahlm%(P%)+1) Mod 2)
  Select GZ%(P%)
  Case 1
    Sub X%(P%),20
  Case 2
    Sub Y%(P%),20
  Case 3
    Add Y%(P%),20
  Case 4
    Add X%(P%),20
  Endselect
  If X%(P%)<20 Or Y%(P%)<20 Or Y%(P%)>389
    Monstertyp&(P%)=0
    'If X%(P&)>5 And Y%(P&)<381 And Y%(P&)>0
      'Rc_copy Scr1%,X%(P&),Y%(P&),10,10 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else if X%(P%)<630
    R%(P%)=GZ%(P%)
    Select R%(P%)
    Case 1
      'Rc_copy Scr1%,X%(P&)+20,Y%(P&),10,10 To Scr2%,X%(P&)+20,Y%(P&)
    Case 2
      'Rc_copy Scr1%,X%(P&),Y%(P&)+20,10,10 To Scr2%,X%(P&),Y%(P&)+20
    Case 3
      'Rc_copy Scr1%,X%(P&),Y%(P&)-20,10,10 To Scr2%,X%(P&),Y%(P&)-20
    Case 4
      'Rc_copy Scr1%,X%(P&)-20,Y%(P&),10,10 To Scr2%,X%(P&)-20,Y%(P&)
    Endselect
    Get X%(P%),Y%(P%),9,9,Bacm$	
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Schuss2m$) ! Put X%(P%),Y%(P%),Schuss2m$,4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Schuss2$) ! Put X%(P%),Y%(P%),Schuss2$,7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&),10,10 To Scr2%,X%(P&),Y%(P&)
   ' Put X%(P%),Y%(P%),Bacm$
  Endif
  If Zahlm%(P%)=0
    Select GZ%(P%) !muss leerzeichen vor ! sein?!  Reflex?
    Case 1
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40)>0
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40)=39
          GZ%(P%)=3
        Else if C|(CX%-15+X%(P%)/40,Y%(P%)/40)=40
          GZ%(P%)=2
        Else
          GZ%(P%)=4
        Endif
      Endif
    Case 2
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40)>0
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40)=38
          GZ%(P%)=1
        Else if C|(CX%-15+X%(P%)/40,Y%(P%)/40)=39
          GZ%(P%)=4
        Else
          GZ%(P%)=3
        Endif
      Endif
    Case 3
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40)>0
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40)=40
          GZ%(P%)=4
        Else if C|(CX%-15+X%(P%)/40,Y%(P%)/40)=41
          GZ%(P%)=1
        Else
          GZ%(P%)=2
        Endif
      Endif
    Case 4
      If C|(CX%-15+X%(P%)/40,Y%(P%)/40)>0
        If C|(CX%-15+X%(P%)/40,Y%(P%)/40)=38
          GZ%(P%)=3
        Else if C|(CX%-15+X%(P%)/40,Y%(P%)/40)=41
          GZ%(P%)=2
        Else
          GZ%(P%)=1
        Endif
      Endif
    Endselect
  Endif
Return
Procedure Gummi ! & to %
print "gummi"
  ' Steuerung dieses Monsters!
  If X%(P%)<0
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else
    Zahlm%(P%)=Zahlm%(P%)+2
    If Zahlm%(P%)=24
      Zahlm%(P%)=-22
    Endif
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Y%(P%)=Y%(P%)+Zahlm%(P%)
    If Y%(P%)>21
      Get X%(P%),Y%(P%),40,40,Bachm$	
	'---
	GRAPHMODE 2
	COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Ballm$) ! Put X%(P%),Y%(P%),Ballm$,4
	COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Gummi$(GZ%(P%))) ! Put X%(P%),Y%(P%),Gummi$(GZ%(P%)),7
	GRAPHMODE 1
	'---
      'Rc_copy Scr1%,X%(P&),Y%(P&)-22,40,84 To Scr2%,X%(P&),Y%(P&)-22
    '  Put X%(P%),Y%(P%),Bachm$
    Endif
  Endif
Return
Procedure Schwalbe  !&to%
print "schwalbe"
  ' Steuerung dieses Monsters!
  If X%(P%)<20
    Monstertyp&(P%)=0
    'If X%(P&)>-1 And Y%(P&)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,20 To Scr2%,X%(P&),Y%(P&)
    'Endif
    Goto Schwalbeend
  Endif
  Select R%(P%)
  Case 0
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>0 Or X%(P%)=600
        R%(P%)=1
      Else
        X%(P%)=X%(P%)+20
      Endif
    Else
      X%(P%)=X%(P%)+20
    Endif
    Get X%(P%),Y%(P%),40,20,Bachm$
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Schwalbem$(1)) ! Put X%(P%),Y%(P%),Schwalbem$(1),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Schwalbe$(1)) ! Put X%(P%),Y%(P%),Schwalbe$(1),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&)-20,Y%(P&),60,20 To Scr2%,X%(P&)-20,Y%(P&)
  Case 1
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>0
        R%(P%)=0
      Else
        X%(P%)=X%(P%)-20
      Endif
    Else
      X%(P%)=X%(P%)-20
    Endif
    Get X%(P%),Y%(P%),40,20,Bachm$	
	'---
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Schwalbem$(0)) ! Put X%(P%),Y%(P%),Schwalbem$(0),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Schwalbe$(0)) ! Put X%(P%),Y%(P%),Schwalbe$(0),7
	GRAPHMODE 1
	'---
    'Rc_copy Scr1%,X%(P&),Y%(P&),60,20 To Scr2%,X%(P&),Y%(P&)
  Default
    Goto Schwalbeend
  Endselect
'  Put X%(P%),Y%(P%),Bachm$
  Schwalbeend:
Return
Procedure Fisch !&to%
print "fisch"
  ' Steuerung dieses Monsters!
  If X%(P&)<0
    Monstertyp&(P%)=0
    'If X%(P&)>-1 And Y%(P&)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),30,40 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else
    Zahlm%(P%)=Zahlm%(P%)+1
    If Zahlm%(P%)>Hohesprung&*2
      Zahlm%(P%)=-Hohesprung&*2+1
    Endif
    If Zahlm%(P%)>0
      Sub Y%(P%),16
      Frh%=0
    Else
      Add Y%(P%),16
      Frh%=1
    Endif
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    Get X%(P%),Y%(P%),30,40,Bachm$ !Get X%(P%),Y%(P%),29,39,Bachm$
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Fischm$(Frh%))  ! Put X%(P%),Y%(P%),Fischm$(Frh%),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Fisch$(Frh%,GZ%(P%)))  ! Put X%(P%),Y%(P%),Fisch$(Frh%,GZ%(P%)),7
	GRAPHMODE 1
    'If Zahlm%(P&)>0
      'Rc_copy Scr1%,X%(P&),Y%(P&),30,56 To Scr2%,X%(P&),Y%(P&)
    'Else
      'Rc_copy Scr1%,X%(P&),Y%(P&)-16,30,56 To Scr2%,X%(P&),Y%(P&)-16
    'Endif
   ' Put X%(P%),Y%(P%),Bachm$
  Endif
Return
Procedure Stacheln  !&to%
print "stacheln"
  ' Steuerung dieses Monsters!
  If X%(P%)<0
    Monstertyp&(P%)=0
  Else
    GZ%(P%)=((GZ%(P%)+1) Mod 14)
    @put_pic(X%(P%),Y%(P%),Stachel$(GZ%(P%)))  ! Put X%(P%),Y%(P%),Stachel$(GZ%(P%))
    'Rc_copy Scr1%,X%(P&),Y%(P&),40,17 To Scr2%,X%(P&),Y%(P&)
  Endif
Return
Procedure Feuer !&to%
print "feuer"
  ' Steuerung dieses Monsters!
  If X%(P%)<0
    Monstertyp&(P%)=0
  Else
    GZ%(P%)=((GZ%(P%)+1) Mod 4)
    @put_pic(X%(P%),Y%(P%),Feuer$(GZ%(P%)))  ! Put X%(P%),Y%(P%),Feuer$(GZ%(P%))
    'Rc_copy Scr1%,X%(P&),Y%(P&),32,26 To Scr2%,X%(P&),Y%(P&)
  Endif
Return
Procedure Pfeil !&to%
print "pfeil"
  ' Steuerung dieses Monsters!
  If X%(P%)+GZ%(P%)<10
    R%(P%)=0
  Endif
  If X%(P%)<10
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),20,5 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else
    Select R%(P%)
    Case 0
      ' warteposituion
      If Y%+63>Y%(P%) And Y%<Y%(P%)+8
        If A%<X%(P%)
          R%(P%)=1
        Endif
      Endif
    Case 1
      ' Fliegt
      If C|(CX%-15+(X%(P%)+GZ%(P%))/40-1,Y%(P%)/40)=0
        Sub GZ%(P%),10
        Get X%(P%)+GZ%(P%),Y%(P%),15,8,Bachm$
		GRAPHMODE 2
		COLOR blue,yellow
        @put_pic(X%(P%)+GZ%(P%),Y%(P%),Pfeilm$((X%(P%)+GZ%(P%)/40) Mod 2))  ! Put X%(P%)+GZ%(P%),Y%(P%),Pfeilm$((X%(P%)+GZ%(P%)/40) Mod 2),4
		COLOR yellow,blue
        @put_pic(X%(P%)+GZ%(P%),Y%(P%),Pfeil$((X%(P%)+GZ%(P%)/40) Mod 2))  ! Put X%(P%)+GZ%(P%),Y%(P%),Pfeil$((X%(P%)+GZ%(P%)/40) Mod 2),7
		GRAPHMODE 1
        'Rc_copy Scr1%,X%(P&)+GZ%(P&),Y%(P&),26,9 To Scr2%,X%(P&)+GZ%(P&),Y%(P&)
        'Put X%(P%)+GZ%(P%),Y%(P%),Bachm$
      Else
        R%(P%)=0
        'Rc_copy Scr1%,X%(P&)+GZ%(P&),Y%(P&),16,9 To Scr2%,X%(P&)+GZ%(P&),Y%(P&)
        GZ%(P%)=0
      Endif
    Endselect
  Endif
Return
Procedure Bombe
print "bombe"
  ' Steuerung dieses Monsters!
  If GZ%>X%(P%)
    Sub GZ%(P%),40
  Endif
  If X%(P%)<0
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),5,20 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else
    Select Zahlm%(P%)
    Case 0
      ' warteposituion
      If A%+60>X%(P%)
        If A%<X%(P%)+28
          Zahlm%(P%)=1
        Endif
      Endif
    Case 1
      ' f"+Chr$(132)+"llt
      If C|(CX%-15+(X%(P%)+1)/40,Y%(P%)/40+1)=0
        Add Y%(P%),10
        Get X%(P%),Y%(P%),8,15,Bachm$
		GRAPHMODE 2
		COLOR blue,yellow
        @put_pic(X%(P%),Y%(P%),Bombem$((Y%(P%)/40) Mod 2))  ! Put X%(P&),Y%(P&),Bombem$((Y%(P&)/40) Mod 2),4
		COLOR yellow,blue
        @put_pic(X%(P%),Y%(P%),Bombe$((Y%(P%)/40) Mod 2))  ! Put X%(P&),Y%(P&),Bombe$((Y%(P&)/40) Mod 2),7
		GRAPHMODE 1
        'Rc_copy Scr1%,X%(P&),Y%(P&)-10,9,26 To Scr2%,X%(P&),Y%(P&)-10
        'Put X%(P%),Y%(P%),Bachm$
      Else
        Zahlm%(P%)=0
        'Rc_copy Scr1%,X%(P&),Y%(P&),9,16 To Scr2%,X%(P&),Y%(P&)
        Y%(P%)=R%(P%)
      Endif
    Endselect
  Endif
Return
Procedure Qualle
print "qualle"
  ' Steuerung dieses Monsters!
  If X%(P%)<8
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,20 To Scr2%,X%(P&),Y%(P&)
    'Endif
    Goto Weiterq1
  Endif
  Select R%(P%)
  Case 1
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40+1,Y%(P%)/40+1)=0 Or C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)>7
        R%(P%)=2
        Goto Weiterq3
      Endif
    Else if X%(P%)>591
      R%(P%)=2
      Goto Weiterq3
    Endif
    X%(P%)=X%(P%)+8
    Weiterq3:
    GZ%(P%)=((GZ%(P%)+1) Mod 5)
    Get X%(P%),Y%(P%),39,15,Bachm$
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Quallem$(GZ%(P%)))  ! Put X%(P&),Y%(P&),Quallem$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Qualle$(GZ%(P%)))  ! Put X%(P&),Y%(P&),Qualle$(GZ%(P&)),7
	GRAPHMODE 1
    'Rc_copy Scr1%,X%(P&)-8,Y%(P&),48,16 To Scr2%,X%(P&)-8,Y%(P&)
  Case 2
    If (X%(P%) Mod (40))=0
      If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40+1)=0 Or C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>7
        R%(P%)=1
        Goto Weiterq2
      Endif
    Endif
    X%(P%)=X%(P%)-8
    Weiterq2:
    GZ%(P%)=((GZ%(P%)+1) Mod 5)
    Get X%(P%),Y%(P%),39,15,Bachm$
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(X%(P%),Y%(P%),Quallem$(GZ%(P%)))  ! Put X%(P&),Y%(P&),Quallem$(GZ%(P&)),4
	COLOR yellow,blue
    @put_pic(X%(P%),Y%(P%),Qualle$(GZ%(P%)))  ! Put X%(P&),Y%(P&),Qualle$(GZ%(P&)),7
	GRAPHMODE 1
    'Rc_copy Scr1%,X%(P&),Y%(P&),48,16 To Scr2%,X%(P&),Y%(P&)
  Default
    Goto Weiterq1
  Endselect
 ' Put X%(P%),Y%(P%),Bachm$
  Weiterq1:
Return
Procedure Schwalbe_mit_sturzflug
print "sturzschwalbe"
  ' Steuerung dieses Monsters!
  '                    1 * 4
  '                    2   3
  If X%(P%)<20
    Monstertyp&(P%)=0
    'If X%(P%)>-1 And Y%(P%)<361
      'Rc_copy Scr1%,X%(P&),Y%(P&),40,40 To Scr2%,X%(P&),Y%(P&)
    'Endif
  Else
    Select R%(P%)
    Case 1
      If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40)>0
        R%(P%)=4
      Else
        Sub X%(P%),15
      Endif
      If Y%(P%)<Y%
        If X%(P%)<A%
          R%(P%)=3
        Else if X%(P%)>A%
          R%(P%)=2
        Endif
      Endif
	  'merke koordinaten von BackmPF
	  XSw_alt%= X%(P%)
	  YSw_alt% = Y%(P%)
      Get X%(P%),Y%(P%),39+1,19+1,BackmSw$ !Get X%(P%),Y%(P%),39,19,Backm$
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Schwalbem$(0))  ! Put X%(P&),Y%(P&),Schwalbem$(0),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Schwalbe$(0))  ! Put X%(P&),Y%(P&),Schwalbe$(0),7
	  GRAPHMODE 1
      'Rc_copy Scr1%,X%(P&),Y%(P&),55,40 To Scr2%,X%(P&),Y%(P&)
    '  Put X%(P%),Y%(P%),Backm$
    Case 2
      If C|(CX%-15+(X%(P%))/40-1,Y%(P%)/40)>0
        R%(P%)=4
      Else
        Add Y%(P%),15
        Sub X%(P%),15
      Endif
      If Y%(P%)<Y%
        If X%(P%)<A%
          R%(P%)=3
        Else if X%(P%)>A%
          R%(P%)=2
        Endif
      Else
        R%(P%)=1
      Endif
      Get X%(P%),Y%(P%),39,39,BackmSw$ !Get X%(P%),Y%(P%),39,39,Backm$
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Schwalbesm$(0))  ! Put X%(P&),Y%(P&),Schwalbesm$(0),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Schwalbes$(0))  ! Put X%(P&),Y%(P&),Schwalbes$(0),7
	  GRAPHMODE 1
      'Rc_copy Scr1%,X%(P&),Y%(P&)-15,55,55 To Scr2%,X%(P&),Y%(P&)-15
    '  Put X%(P%),Y%(P%),Backm$
    Case 3
      If C|(CX%-15+(X%(P%))/40+1,Y%(P%)/40)>0
        R%(P%)=1
      Else
        Add Y%(P%),15
        Add X%(P%),15
      Endif
      If Y%(P%)<Y%
        If X%(P%)<A%
          R%(P%)=3
        Else if X%(P%)>A%
          R%(P%)=2
        Endif
      Else
        R%(P%)=4
      Endif
      Get X%(P%),Y%(P%),39,39,BackmSw$ !Get X%(P%),Y%(P%),39,39,Backm$
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Schwalbesm$(1))  ! Put X%(P&),Y%(P&),Schwalbesm$(1),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Schwalbes$(1))  ! Put X%(P&),Y%(P&),Schwalbes$(1),7
	  GRAPHMODE 1
      'Rc_copy Scr1%,X%(P&),Y%(P&),55,55 To Scr2%,X%(P&),Y%(P&)
      'Put X%(P%),Y%(P%),Backm$
    Case 4
      If C|(CX%-15+(X%(P%))/40+1,Y%(P%)/40)>0
        R%(P%)=1
      Else if X%(P%)>560
        R%(P%)=1
      Else
        Add X%(P%),15
      Endif
      If Y%(P%)<Y%
        If X%(P%)<A%
          R%(P%)=3
        Else if X%(P%)>A%
          R%(P%)=2
        Endif
      Endif
      Get X%(P%),Y%(P%),39,19,BackmSw$ !Get X%(P%),Y%(P%),39,19,Backm$
	  GRAPHMODE 2
	  COLOR blue,yellow
      @put_pic(X%(P%),Y%(P%),Schwalbem$(1))  ! Put X%(P&),Y%(P&),Schwalbem$(1),4
	  COLOR yellow,blue
      @put_pic(X%(P%),Y%(P%),Schwalbe$(1))  ! Put X%(P&),Y%(P&),Schwalbe$(1),7
	  GRAPHMODE 1
      'Rc_copy Scr1%,X%(P&)-15,Y%(P&),55,40 To Scr2%,X%(P&)-15,Y%(P&)
    '  Put X%(P%),Y%(P%),Backm$
    Endselect
  Endif
Return
Procedure Platform

'@put_BackMPlatt
@put_BackM_P(P%)
'merke koordinaten von BackmPF 
	'  XPF_alt%= X%(P%)
	'  YPF_alt% = Y%(P%)
	  X_alt%(P%)= X%(P%)
	  Y_alt%(P%) = Y%(P%)
      Get X%(P%),Y%(P%),80,20,Backm_all$(P%)  !BackmPF$
  ' Steuerung dieses Monsters!
  Zahlm%(P%)=((Zahlm%(P%)+1) Mod 7)
  C|(CX%-15+X%(P%)/40,Y%(P%)/40)=8          !Vorderer Teil begehbar machen
  C|(CX%-15+X%(P%)/40+1,Y%(P%)/40)=8        !Hinterer Teil begehbar machen
  Select R%(P%)
  Case 1                                  !Die Plattform bewegt sich nach lings!
    '
    If X%(P%)>-1 And X%(P%)<561           !Ist die Plattform im Sichtbereich?
      '                                   !Wenn Ja
	  'merke koordinaten von BackmPF
	'  XPF_alt%= X%(P%)
	'  YPF_alt% = Y%(P%)
    '  Get X%(P%),Y%(P%),80,20,BackmPF$ !Get X%(P%),Y%(P%),79,19,Backm$  !Dann Hintergrund retten
      @put_pic(X%(P%),Y%(P%),Blatform$ )  ! Put X%(P&),Y%(P&),Blatform$                   !Dann Plattform zeichnen
      'Rc_copy Scr1%,X%(P&),Y%(P&),120,20 To Scr2%,X%(P&),Y%(P&)
     ' Put X%(P%),Y%(P%),Backm$                      !Dann Hintergrund Zeichnen
    Endif                                   !**********************************
    If Zahlm%(P%)=0
      If GZ%(P%)=0                          !Hat die Plattform gerade gewendet?
        C|(CX%-15+X%(P%)/40+2,Y%(P%)/40)=0  !Wenn Nein,dann rechts weg
      Else
        C|(CX%-15+X%(P%)/40-1,Y%(P%)/40)=0  !Wenn Ja,dann lings weg
        GZ%(P%)=0                           !Es wird gerade nicht gewendet!
      Endif                                 !**********************************
      If C|(CX%-15+X%(P%)/40-1,Y%(P%)/40)>0 !St"+Chr$(148)+""+Chr$(158)+"t sie gegen etwas?
        GZ%(P%)=1                           !Es wird gewendet werden
        R%(P%)=2                            !Wenn Ja,dann wenden
      Else
        Sub X%(P%),40                       !Wenn Nein,Dann weiter nach lings
      Endif                                 !**********************************
    Endif
  Case 2                                  !Die Platform bewegt sich nach rechts!
    '
    If X%(P%)>39 And X%(P%)<600             !Ist die Platform im Sichtbereich?
      '                                     !Wenn Ja
	  'merke koordinaten von BackmPF
	 ' XPF_alt%= X%(P%)
	 ' YPF_alt% = Y%(P%)
     ' Get X%(P%),Y%(P%),80,20,BackmPF$   !Get X%(P%),Y%(P%),79,19,Backm$  !Dann Hintergrund retten
      @put_pic(X%(P%),Y%(P%),Blatform$)  ! Put X%(P&),Y%(P&),Blatform$                   !Dann Platform zeichnen
      'Rc_copy Scr1%,X%(P&)-40,Y%(P&),120,20 To Scr2%,X%(P&)-40,Y%(P&)
      'Put X%(P%),Y%(P%),Backm$                      !Dann Hintergrund Zeichnen
    Endif                                   !**********************************
    If Zahlm%(P%)=0
      If GZ%(P%)=0                          !Hat die Platform gerade gewendet?
        C|(CX%-15+X%(P%)/40-1,Y%(P%)/40)=0  !Wenn Nein,dann lings weg
      Else
        C|(CX%-15+X%(P%)/40+2,Y%(P%)/40)=0  !Wenn Ja,dann rechts weg
        GZ%(P%)=0                           !Es wird gerade nicht gewendet!
      Endif                                 !**********************************
      If C|(CX%-15+X%(P%)/40+2,Y%(P%)/40)>0 Or X%(P%)>540!St"+Chr$(148)+""+Chr$(158)+"t sie gegen etwas?
        GZ%(P%)=2                           !Es wird gewendet werden
        R%(P%)=1                            !Wenn Ja,dann wenden
      Else
        Add X%(P%),40                       !Wenn Nein,dann weiter nach rechts
      Endif                                 !**********************************
    Endif
  Endselect
Return
Procedure Tod_oder_nicht
  ' In dieser Procedure wird gepr"+Chr$(129)+"ft, ob ein Monster dich ber"+Chr$(129)+"hrt und damit t"+Chr$(148)+"tet
  For Tod%=0 To 5  ! % statt &
    If Monstertyp&(Tod%)>0 ! % statt &
      Select Monstertyp&(Tod%)  ! % statt &
      Case 111,96
        Mb&=0  ! % statt &
      Case 112
        Mb&=15 ! % statt &
        Mh&=8 ! % statt &
      Case 113
        Mb&=0 ! % statt &....
        If Y%+63>Y%(Tod%)
          If Y%<Y%(Tod%)+Mh&
            If A%>=X%(Tod%)+GZ%(Tod%) And A%<X%(Tod%)+GZ%(Tod%)+Mb& Or A%<=X%(Tod%)+GZ%(Tod%)+Mb& And A%+40>X%(Tod%)+GZ%(Tod%) !=> =<
              @Monsterauflosen
              Monstertyp&(Tod%)=0
              Dec Lebem|(Akt&)
              If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
                @Figur_selection
              Endif
            Endif
          Endif
        Endif
      Case 94
        Mb&=19 ! % statt &..
        Mh&=19
      Case 95
        Mb&=9
        Mh&=9
      Case 100,104,98
        Mb&=39
        Mh&=19
      Case 96,97,98,99,105 !Case 96 To 99,105
        Mb&=39
        Mh&=39
      Case 101,102
        Mb&=29
        Mh&=39
      Case 103
        Mb&=39
        Mh&=15
      Case 106
        Mb&=19
        Mh&=39
      Case 107
        Mb&=39
        Mh&=17
      Case 109
        Mb&=31
        Mh&=25
      Case 114
        Mb&=30
        Mh&=20
      Case 115
        Mb&=0
        If R%(Tod%)=0
          If GZ%(Tod%)>0
            If Y%+63>Y%(Tod%)-GZ%(Tod%)
              If Y%<Y%(Tod%)
                If A%>=X%(Tod%)+8 And A%<X%(Tod%)+32 Or A%<=X%(Tod%)+32 And A%+40>X%(Tod%)+8 !=> =<
                  Monstertyp&(Tod%)=0
                  Dec Lebem|(Akt&)
                  If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
                    @Figur_selection
                  Endif
                Endif
              Endif
            Endif
          Endif
        Endif
      Endselect
      If Mb&>0
        If Y%+63>Y%(Tod%)
          If Y%<Y%(Tod%)+Mh&
            If A%>=X%(Tod%) And A%<X%(Tod%)+Mb& Or A%<=X%(Tod%)+Mb& And A%+40>X%(Tod%) !=> =<
              @Monsterauflosen
              Monstertyp&(Tod%)=0
              Dec Lebem|(Akt&)
              If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
                @Figur_selection
              Endif
            Endif
          Endif
        Endif
      Endif
    Endif
  Next Tod%
Return
Procedure Abfrage_2
'  print "Abfrage_2"
  ' In dieser Procedure wird gepr"+Chr$(129)+"ft, ob ein Monster erschossen wurde!
  If kb%(KEYSPACE%)=1 And Schussr%=0 And Y%>7  !If Strig(1)=-1 And Schussr%=0 And Y%>7
    SchussX%=Int(A%/8)*8+40 !SchussX%=Int(A%/8)*8+40
    If Ri%=4 !Ri%=4
      SchussX%=Int(A%/8)*8-8 !SchussX%=Int(A%/8)*8-8
    Endif
    Schussh%=1 !Schussh%=1
    SchussY%=Int(Y%/8)*8+40 !SchussY%=Int(Y%/8)*8+40
    Schussr%=Ri% !Schussr%=Ri%
  Endif
  If SchussX%<2 !If SchussX%<2
    'print "Schuss_weg"
    @Schuss_weg !Schuss_weg
  Endif
  If Schussr%>0 !If Schussr%>0
    For Tod%=0 To 5 !For Tod&=0 To 5
      Select Monstertyp&(Tod%) !Select Monstertyp&(Tod&)
      Case 98
        Mb&=40  ! & -> %% in folgenden Zeilen
        Mh&=40
        Mp&=49
      Case 99
        Mb&=40
        Mh&=40
        Mp&=98
      Case 94
        Mb&=20
        Mh&=20
        Mp&=49*7
      Case 100
        Mb&=40
        Mh&=20
        Mp&=28
      Default
        Mh&=0
      Endselect
      If Mh&>0
        If SchussY%+1>Y%(Tod%) And SchussY%+1<Y%(Tod%)+Mh&
          If SchussX%+1>X%(Tod%) And SchussX%+1<X%(Tod%)+Mb&
            @Monsterauflosen
            Monstertyp&(Tod%)=0
            @Schuss_weg !Schuss_weg
            Add Punkte%,Mp&
            @Aktanzeigen !Aktanzeigen
          Endif
        Endif
      Endif
    Next Tod%
  Endif
  @Schussreflect
  'print "end:Abfrage_2"
Return
Procedure Schussreflect
	@put_back_Schuss()
  ' In dieser Procedure werden die Reflektionen des Schusses an den Steinen
  ' gesteuert
  If Schussr%>0  ! % statt &
    If SchussY%>=384 Or SchussX%>=624 Or SchussX%<=8 Or SchussY%<=8
      @Schuss_weg
    Endif
  Endif
  'print "schussr",Schussr%
  Select Schussr%
    '  1   2
    '    z
    '  4   3
  Case 1
    If C|(CX%-15+(SchussX%)/40,SchussY%/40-0.2)>0
      Schussr%=4
      If C|(CX%-15+(SchussX%)/40,SchussY%/40-0.2)=35
        @Schuss_weg
      Endif
    Else if C|(CX%-15+(SchussX%)/40-0.2,SchussY%/40)>0
      Schussr%=2
      If C|(CX%-15+(SchussX%)/40-0.2,SchussY%/40)=35
        @Schuss_weg
      Endif
    Else
      Sub SchussX%,8
      Sub SchussY%,8
      'Get SchussX%,SchussY%,7,7,Schussb$
    Endif
	Get SchussX%,SchussY%,8,8,Schussb$ ! wenn nur in ELSE gespeichert wird, bleibt schuss an reflexionspunkten sichtbar
    @put_pic(SchussX%,SchussY%,Schuss$)  ! Put SchussX%,SchussY%,Schuss$
    'Rc_copy Scr1%,SchussX%,SchussY%,16,16 To Scr2%,SchussX%,SchussY%
    '@put_back_Schuss()  ! Put SchussX%,SchussY%,Schussb$
  Case 2
    If C|(CX%-15+SchussX%/40,SchussY%/40-0.2)>0
      Schussr%=3
      If C|(CX%-15+SchussX%/40,SchussY%/40-0.2)=35
        @Schuss_weg
      Endif
    Else if C|(CX%-15+SchussX%/40+0.3,SchussY%/40-0.2)>0
      Schussr%=1
      If C|(CX%-15+SchussX%/40+0.3,SchussY%/40-0.2)=35
        @Schuss_weg !Schuss_weg
      Endif
    Else
      Add SchussX%,8
      Sub SchussY%,8
      'Get SchussX%,SchussY%,8,8,Schussb$ !Get SchussX%,SchussY%,7,7,Schussb$
    Endif
	Get SchussX%,SchussY%,8,8,Schussb$ ! wenn nur in ELSE gespeichert wird, bleibt schuss an reflexionspunkten sichtbar
    @put_pic(SchussX%,SchussY%,Schuss$)  ! Put SchussX%,SchussY%,Schuss$
    'Rc_copy Scr1%,SchussX%-8,SchussY%,16,16 To Scr2%,SchussX%-8,SchussY%
    '@put_back_Schuss()  ! Put SchussX%,SchussY%,Schussb$
  Case 3
    If C|(CX%-15+SchussX%/40,SchussY%/40+0.3)>0
      Schussr%=2
      If C|(CX%-15+SchussX%/40,SchussY%/40+0.3)=35
        @Schuss_weg
      Endif
    Else if C|(CX%-15+SchussX%/40+0.3,SchussY%/40)>0
      Schussr%=4
      If C|(CX%-15+SchussX%/40+0.3,SchussY%/40)=35
        @Schuss_weg
      Endif
    Else
      Add SchussX%,8
      Add SchussY%,8
      'Get SchussX%,SchussY%,8,8,Schussb$ !Get SchussX%,SchussY%,7,7,Schussb$
    Endif
	Get SchussX%,SchussY%,8,8,Schussb$ ! wenn nur in ELSE gespeichert wird, bleibt schuss an reflexionspunkten sichtbar
    @put_pic(SchussX%,SchussY%,Schuss$)  ! Put SchussX%,SchussY%,Schuss$
    'Rc_copy Scr1%,SchussX%-8,SchussY%-8,16,16 To Scr2%,SchussX%-8,SchussY%-8
    '@put_back_Schuss()  ! Put SchussX%,SchussY%,Schussb$
  Case 4
    If C|(CX%-15+SchussX%/40,SchussY%/40+0.3)>0
      Schussr%=1
      If C|(CX%-15+SchussX%/40,SchussY%/40+0.3)=35
        @Schuss_weg
      Endif
    Else if C|(CX%-15+SchussX%/40-0.2,SchussY%/40)>0
      Schussr%=3
      If C|(CX%-15+SchussX%/40-0.2,SchussY%/40)=35
        @Schuss_weg
      Endif
    Else
      Sub SchussX%,8
      Add SchussY%,8
      'Get SchussX%,SchussY%,8,8,Schussb$  !Get SchussX%,SchussY%,7,7,Schussb$
    Endif
	Get SchussX%,SchussY%,8,8,Schussb$ ! wenn nur in ELSE gespeichert wird, bleibt schuss an reflexionspunkten sichtbar
    @put_pic(SchussX%,SchussY%,Schuss$)  ! Put SchussX%,SchussY%,Schuss$
    'Rc_copy Scr1%,SchussX%,SchussY%-8,16,16 To Scr2%,SchussX%,SchussY%-8
    '@put_back_Schuss()  ! Put SchussX%,SchussY%,Schussb$
  Endselect
Return
Procedure Rutsch_stein
  ' hier werden die Daten f"+Chr$(129)+"r das Rutschen bearbeitet!
  If HBew%=4
    @Rutsch_zur
  Else if HBew%=8
    @Rutsch_vor
  Else if HBew%=10
    If HhBew%=4
      @Rutsch_zur
    Else if HhBew%=8
      @Rutsch_vor
    Else if HhBew%=10
      If HhhBew%=4
        @Rutsch_zur
      Else if HhhBew%=8
        @Rutsch_vor
      Else if HhhBew%=10
        If HhhhBew%=4
          @Rutsch_zur
        Else if HhhhBew%=8
          @Rutsch_vor
        Endif
      Endif
    Endif
  Endif
Return
Procedure Rutsch_vor
  ' Diese Procedure l"+Chr$(132)+""+Chr$(158)+"t dich nach rechts schliddern (Eis)
  @put_back1  !Put A%,Y%,Back$
  If (A% Mod 40)=0
    If C|(CX%-15+(A%-1)/40+2,Y%/40+1)+C|(CX%-15+(A%-1)/40+2,Y%/40)=0 Or C|(CX%-15+(A%-1)/40+2,Y%/40)=85
      A%=A%+8
    Endif
  Else
    A%=A%+8
  Endif
  Get A%,Y%,40,64,Back$
  Aalt%=A%
  Yalt%=Y%
	GRAPHMODE 2
	COLOR blue,yellow
  @put_pic(A%,Y%,S$(1,Zu&+Skeletti&))  ! Put A%,Y%,S$(1,Zu&+Skeletti&),4
	COLOR yellow,blue
  @put_pic(A%,Y%,Fig$(1,Zu&+Skeletti&))  ! Put A%,Y%,Fig$(1,Zu&+Skeletti&),7
	GRAPHMODE 1
  'Rc_copy Scr1%,A%-8,Y%,48,63 To Scr2%,A%-8,Y%
  'Put A%,Y%,Back$
Return
Procedure Rutsch_zur
  ' Diese Procedure l"+Chr$(132)+""+Chr$(158)+"t dich nach links schliddern (Eis)
  @put_back1 !Put A%,Y%,Back$
  If (A% Mod 40)=0
    If C|(CX%-15+(A%-1)/40,Y%/40+1)+C|(CX%-15+(A%-1)/40,Y%/40)=0
      A%=A%-8
    Endif
  Else
    A%=A%-8
  Endif
  If A%<0
    A%=0
  Endif
  Get A%,Y%,40,64,Back$
  Aalt%=A%
  Yalt%=Y%
	GRAPHMODE 2
	COLOR blue,yellow
  @put_pic(A%,Y%,S$(3,Zu&+Skeletti&))  ! Put A%,Y%,S$(3,Zu&+Skeletti&),4
	COLOR yellow,blue
  @put_pic(A%,Y%,Fig$(3,Zu&+Skeletti&))  ! Put A%,Y%,Fig$(3,Zu&+Skeletti&),7
	GRAPHMODE 1
  'Rc_copy Scr1%,A%,Y%,48,63 To Scr2%,A%,Y%
  'Put A%,Y%,Back$
Return
Procedure Schalter
  ' Der Schalterstein hat auswirkungen, wenn dieser benutzt wird. Diese werden Hier
  ' ausgewertet.
  ' Die Informationen dazu kommen aus einem Feld Schalter$() dem die
  ' x-Koordinate/40 "+Chr$(129)+"bergeben wird.
  ' Die "+Chr$(142)+"nderung von einem Stein ben"+Chr$(148)+"tigt 4Bytes
  ' 2Bytes f"+Chr$(129)+"r die X-Koordinate im Feld
  ' 1Byte  f"+Chr$(129)+"r die Y-Koordinate im Feld
  ' 1Byte  f"+Chr$(129)+"r die Nummer des neuen Steins
  For I%=0 To Len(Schalt$(CX%-14+A%/40-1))/4-1 !I& ! Len(Schalt$(CX%-14+A%/40))/4
    H$=Mid$(Schalt$(CX%-14+A%/40-1),I%*4+1,4) ! H$=Mid$(Schalt$(CX%-14+A%/40),I%*4+1,4)
    Xschalt%=Cvi(Mid$(H$,2)+Mid$(H$,1)) !Cvi(H$)
    Yschalt%=Asc(Mid$(H$,3))
    Steinart%=Asc(Mid$(H$,4))	
	print "Xschalt",Xschalt%,"Yschalt",Yschalt%,"stein",Steinart%
    C|(Xschalt%,Yschalt%)=Steinart%
    If Xschalt%<CX%+1 And Xschalt%>CX%-16
      @put_pic_wh((Xschalt%-CX%+15)*40,Yschalt%*40,40,40,B$(Steinart%))  !@put_pic((Xschalt%-CX%+15)*40,Yschalt%*40,B$(Steinart%))  ! Put (Xschalt%-CX%+15)*40,Yschalt%*40,B$(Steinart%)
      'Rc_copy Scr1%,(Xschalt%-CX%+15)*40,Yschalt%*40,40,40 To Scr2%,(Xschalt%-CX%+15)*40,Yschalt%*40
    Endif
  Next I%
Return
Procedure New_level_start
  ' Wenn ein weiteres Level gespielt werden soll, werden von hier die n"+Chr$(148)+"tigen
  ' Vorbereitungen erledigt!
  @Werte3
  @Level
  @Anf_b_aufbau
  Get A%,Y%,40,64,Back$
  Aalt%=A%
  Yalt%=Y%
  @Main
Return
Procedure New_start
  ' wenn Sie sich f"+Chr$(129)+"r ein weiteres Spiel entschieden haben sollten, dann kommt
  ' diese Procedure zum Einsatz!
  @Werte2
  clearw !Void Xbios(5,L:Scr1%,L:Scr2%,-1)
  Deffill 1,1,1
  Pbox 0,0,639,399
  @put_pic(244,152,Inp$)  ! Put 244,152,Inp$
  @put_pic(Put 230,220,Ianthr$)  ! Put 230,220,Ianthr$
  @put_pic(Put 154,39,Brisk$)  ! Put 154,39,Brisk$
  @Name_input
  @Level
  @Anf_b_aufbau
  @Main
Return
Procedure Wscroll
print "wscroll"
  ' In dieser Procedure wird tzusammen mit der Procedure Hinter der Hintergrund
  ' um 40 Pixel(5 Bytes) nach links geschoben!
 ' Repeat
 ' Until Inkey$=""
  kb%(KEYUP%)=0
  kb%(KEYDOWN%)=0
  kb%(KEYLEFT%)=0
  kb%(KEYRIGHT%)=0
  kb%(KEYSPACE%)=0
  Scrollstop&=0
  Repeat
    @Hinter
	@show_fig_wait() !@show_wait	
    Y%=ScrollY%*40-63
    A%=400
  Until Scrollstop&=1
  Get A%,Y%,40,64,Back$
  Aalt%=A%
  Yalt%=Y%
Return
'Procedure Keyselect
  ' In dieser Procedure wird ein eventueller Tasdtendruck w"+Chr$(132)+"hrend des Siels
  ' selektiert!
'  Select Inp(2)
'  Case 293 !226 !HELP
'    @Hilfe
'  Case 291 !196 !F 10 : SELBSTMORD
'    Dec Lebem|(Akt&)
'    @Wscroll
'    If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
'      @Figur_selection
'    Endif
'  Case 292 !27
'    For I%=0 To 3 !I&
'      Lebem|(I%)=3
'    Next I%
'    @Ende
'    End
'  Endselect
'Return
PROCEDURE Prufen
  ' In dieser Procedure werden die  zum Programm geh"+Chr$(148)+"renden Dateien auf Fehler
  ' untersucht!
  If Exist("brisk.dat")
    Open "i",#1,"brisk.dat"
	Print "brisk.dat ge"+Chr$(148)+"ffnet"
	ll = LOF(#1)
	print ll
    If Lof(#1)=107046
      print "inif"
	  B%=Cvl(Input$(#1,4)) !B%=Cvl(Input$(4,#1))
      For I=0 To 26759                    !Geheim:      (107046/4)-2=26759  !I&
        B%=Xor(B%,Cvl(Input$(#1,4))) !B%=Xor(B%,Cvl(Input$(4,#1)))
      Next I !I&
	  Print "Schleifenende"
	  Print I
	  Print B%
      If B%=B% !-490501012
        PR%=1
      Else
        Fehler$="Daten in Brisk.dat sind nicht korrekt!"
        @Fehler
      Endif
    Else
      Fehler$="Brisk.dat hat die faltsche L"+Chr$(132)+"nge!"
      @Fehler
    Endif
    Close
  Else
    Fehler$="Brisk.dat ist nicht auf der Diskette!"
    @Fehler
  Endif
  If Exist("B__DRUCK.PRG")
    Open "i",#1,"B__DRUCK.PRG"
    If Lof(#1)<>15935
      Fehler$="B__Druck.prg hat die faltsche l"+Chr$(132)+"nge!"
      @Fehler
    Endif
    Close
  Else
    Fehler$="B__Druck.prg ist nicht auf dieser Diskette!"
    @Fehler
  Endif
  If Exist("Liesmich.prg")
    Open "i",#1,"liesmich.prg"
    If Lof(#1)<>13223
      Fehler$="LiesMich.prg hat die faltsche l"+Chr$(132)+"nge!"
      @Fehler
    Endif
    Close
  Else
    Fehler$="LiesMich.prg ist nicht auf dieser Diskette!"
    @Fehler
  Endif
  If Exist("b_Dekomp.prg")
    Open "i",#1,"b_Dekomp.prg"
    If Lof(#1)<>11110
      Fehler$="B_Dekomp.prg hat die faltsche l"+Chr$(132)+"nge!"
      @Fehler
    Endif
    Close
  Else
    Fehler$="B_Dekomp.prg ist nicht auf dieser Diskette!"
    @Fehler
  Endif
  For I=1 To 4 !I&
    If Exist("levels\level00"+Str$(I)+".lev") !I&
    Else
      Fehler$="Level00"+Str$(I)+".lev ist nicht auf dieser Diskette!" !I&
      @Fehler
    Endif
  Next I !I&
  For I=1 To 38 !I&
  print I
    Void$="b___info\info__"+Right$("0"+Str$(I),2)+".pic" !I&
	print Void$
    If Exist(Void$)
	print "exists"
      Read Infolang%  !Read Infolang&
      Open "i",#1,Void$
      If 1=2  !Lof(#1)<>cvi(Infolang$) !Infolang&
        Fehler$=Right$(Void$,12)+" hat die faltsche L"+Chr$(132)+"ange!"
		print Fehler$
		print Lof(#1)
		print Infolang&
        @Fehler
      Endif
      Close
    Else
      Fehler$=Right$(Void$,12)+" ist nicht auf der Diskette!"
	  print Fehler$
      @Fehler
    Endif
  Next I !I&
	print "2445"
  If Exist("brisk1_1.prg")
    Open "i",#1,"brisk1_1.prg"
    If Lof(#1)<>129067
      Fehler$="Brisk1_1.prg hat die faltsche L"+Chr$(132)+"nge!"
      @Fehler
    Endif
    Close
  Endif
  Print "Ende: Prufen"
Return
Procedure Anfangs
  print "Anfangs"
  ' In dieser Procedure werden alle Graphicelemente(Bilder) eingeladen!
  Open "i",#1,"brisk.dat"
  FA%=0 !FA%=0 !unnnoetig das zu aendern???????????! doch nach neu kompilierter Version
  F%=0 !F&=0
  For I3%=0 To 7 ! For-Laufvariable I3&
    FA%=0
    For I4%=0 To 5 ! For-Laufvariable I4&
      Fig$(FA%,F%)=@loadpic$(384) !Input$(384,#1)
      S$(FA%,F%)=@loadpic$(384) !Input$(384,#1)
      Inc FA%
    Next I4%
    Inc F%
  Next I3%
  Scroll$=@loadpic$(2310) !Input$(2310,#1)
  Auflos$=@loadpic$(132) !Input$(132,#1)
  Hil$=@loadpic$(3206) !Input$(3206,#1)
  Schuss$=@loadpic$(22) !Input$(22,#1)
  D%=3 !D&=3
  F%=1 !F&=1
  For I%=0 To 59 ! For-Laufvariable I&
    B$(F%)=@loadpic$(246) !Input$(246,#1)
    Inc F%
  Next I%
  For I%=0 To 14
    B$(90-I%)=@loadpic$(486) !Input$(486,#1)
  Next I%
  For I%=0 To 14
    B$(75-I%)=@loadpic$(486) !Input$(486,#1)
  Next I%
  F%=0
  For I%=0 To 3
    Ball$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  Ballm$=@loadpic$(246) !Input$(246,#1)
  For I%=0 To 3
    Gummi$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  For I%=0 To 3
    Kreisel$(I%)=@loadpic$(86) !Input$(86,#1)
  Next I%
  Kreiselm$=@loadpic$(86) !Input$(86,#1)
  For I%=0 To 3
    Fisch$(0,I%)=@loadpic$(166) !Input$(166,#1)
  Next I%
  For I%=0 To 3
    Fisch$(1,I%)=@loadpic$(166) !Input$(166,#1)
  Next I%
  Print "Mitte: Anfangs"
  Fischm$(0)=@loadpic$(166) !Input$(166,#1)
  Fischm$(1)=@loadpic$(166) !Input$(166,#1)
  Schwalbe$(0)=@loadpic$(126) !Input$(126,#1)
  Schwalbe$(1)=@loadpic$(126) !Input$(126,#1)
  Schwalbem$(0)=@loadpic$(126) !Input$(126,#1)
  Schwalbem$(1)=@loadpic$(126) !Input$(126,#1)
  Schuss2$=@loadpic$(26) !Input$(26,#1)
  Schuss2m$=@loadpic$(26) !Input$(26,#1)
  For I%=0 To 3
    Feuer$(I%)=@loadpic$(110) !Input$(110,#1)
  Next I%
  For I%=0 To 13
    Stachel$(I%)=@loadpic$(108) !Input$(108,#1)
  Next I%
  For I%=0 To 3
    Auge$(0,I%)=@loadpic$(166) !Input$(166,#1)
    Auge$(1,I%)=@loadpic$(166) !Input$(166,#1)
    Augem$(I%)=@loadpic$(166) !Input$(166,#1)
  Next I%
  For I%=0 To 3
    Masse$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  For I%=0 To 1
    Krote$(0,I%)=@loadpic$(126) !Input$(126,#1)
  Next I%
  For I%=2 To 3
    Krote$(1,I%-2)=@loadpic$(126) !Input$(126,#1)
  Next I%
  For I%=0 To 3
    Wabbel$(I%)=@loadpic$(132) !Input$(132,#1)
    Wabbelm$(I%)=@loadpic$(132) !Input$(132,#1)
  Next I%
  For I%=0 To 3
    Purzel$(I%)=@loadpic$(246) !Input$(246,#1)
    Purzelm$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  For I%=0 To 1
    Krotem$(0,I%)=@loadpic$(126) !Input$(126,#1)
  Next I%
  For I%=2 To 3
    Krotem$(1,I%-2)=@loadpic$(126) !Input$(126,#1)
  Next I%
  For I%=0 To 4
    Qualle$(I%)=@loadpic$(102) !Input$(102,#1)
    Quallem$(I%)=@loadpic$(102) !Input$(102,#1)
  Next I%
  For I%=0 To 1
    Bombe$(I%)=@loadpic$(38) !Input$(38,#1)
    Bombem$(I%)=@loadpic$(38) !Input$(38,#1)
  Next I%
  For I%=0 To 1
    Pfeil$(I%)=@loadpic$(24) !Input$(24,#1)
    Pfeilm$(I%)=@loadpic$(24) !Input$(24,#1)
  Next I%
  For I%=0 To 1
    Schwalbes$(I%)=@loadpic$(246) !Input$(246,#1)
    Schwalbesm$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  Brisk$=@loadpic$(2646) !Input$(2646,#1)
  Briskb$=@loadpic$(2646) !Input$(2646,#1)
  Inp$=@loadpic$(798) !Input$(798,#1)
  Ianthr$=@loadpic$(732) !Input$(732,#1)
  Blatform$=@loadpic$(206) !Input$(206,#1)
  For I%=0 To 3
    Demofigur$(I%)=@loadpic$(396) !Input$(396,#1)
  Next I%
  Auswahlpfeil$=@loadpic$(74) !Input$(74,#1)
  Ende$=@loadpic$(510) !Input$(510,#1)
  For I%=0 To 13
    Auftauch$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  For I%=0 To 4
    Zerstampf$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  For I%=O& To 1
    Wachs1$(I%)=@loadpic$(246) !Input$(246,#1)
  Next I%
  Wachs2$(0)=@loadpic$(246) !Input$(246,#1)
  Wachs2$(1)=@loadpic$(306) !Input$(306,#1)
  Wachs2$(2)=@loadpic$(366) !Input$(366,#1)
  Wachs2$(3)=@loadpic$(426) !Input$(426,#1)
  Wachs2$(4)=@loadpic$(246) !Input$(246,#1)
  Wachs2$(5)=@loadpic$(306) !Input$(306,#1)
  Wachs2$(6)=@loadpic$(366) !Input$(366,#1)
  Wachs2$(7)=@loadpic$(426) !Input$(426,#1)
  For I%=0 To 8
    Bluete$(I%)=@loadpic$(144) !Input$(144,#1)
  Next I%
  Titel$=@loadpic$(678) !Input$(678,#1)
  Pfeilr$=@loadpic$(38) !Input$(38,#1)
  Pfeill$=@loadpic$(38) !Input$(38,#1)
  Close
  Print "Ende: Anfangs"
  'Pause 1
Return
PROCEDURE Figur_selection
 GET 0,0,640,400,Scr2$
  ' In dieser Procedure k"+Chr$(148)+"nnen Sie zwischen den verschiedenen Fr"+Chr$(129)+"chten w"+Chr$(132)+"hlen!
  CLEARW !Void Xbios(5,L:Scr2%,L:Scr2%,-1)
  print "Figur_selection"
  'Deffill 1,1,1
  'Pbox 0,0,639,399
  '---
  GRAPHMODE 2
   COLOR  blue,yellow
     CLEARW
	Pbox 154,39,154+315,39+64  
	Pbox 244,152,379,195
	Pbox 230,220,392,252
	Pbox 203,265,420,282
'---
	COLOR  yellow,blue
  @put_pic(244,152,Inp$)  ! @putpic(Inp$,244,152)  !Put 244,152,Inp$
  @put_pic(230,220,Ianthr$)  ! @putpic(Ianthr$,230,220)  !Put 230,220,Ianthr$
  @put_pic(203,265,Ende$)  ! @putpic(Ende$,203,265)  !Put 203,265,Ende$
  @put_pic(154,39,Brisk$)  ! @putpic(Brisk$,154,39)  !Put 154,39,Brisk$
'COLOR yellow,blue		
	  Pbox (0+31)*8,11*16,(15+32)*8-1,12*16-1
  '-- wrong color, therefore:
  GPRINT COLOR(34,43) !; '1,39
  GPrint At(12,32);Player$ !GPrint At(32,12);Player$
  COLOR yellow,blue
  '-- now color is back
  FignA%=0
  Figsez&=0
  For I%=3 To 0 Step -1 !I%
    '--
	GRAPHMODE 2
	COLOR  blue,yellow
	Pbox 30,I%*13*8,30+41,I%*13*8+64
	COLOR  yellow,blue
	'--
    @put_pic(30,I%*13*8,Demofigur$(I%))  !Put 30,I&*13*8,Demofigur$(I&)
    Deffill 0,0,0
	COLOR  blue,yellow
    Pbox 80,I%*104+63,90,I%*104+63-(Lebem|(I%)-3)*5
	COLOR  yellow,blue
    If Lebem|(I%)>3
      FignA%=Fign&
'	  print "Figna",FignA%,"Fign",Fign&
      Fign&=I%
	  GRAPHMODE 1
	COLOR  yellow,blue
	Pbox 113,FignA%*8*13+20,113+18,FignA%*8*13+20+16   !Put 113,FignA%*8*13+20,Auswahlpfeil$,15 !!15
    '--
	GRAPHMODE 2
	COLOR  blue,yellow
	Pbox 113,Fign&*8*13+20,113+18,Fign&*8*13+20+16
	COLOR  yellow,blue
	'--
      @put_pic(113,Fign&*8*13+20,Auswahlpfeil$)  !Put 113,Fign&*8*13+20,Auswahlpfeil$
	  COLOR yellow,blue
    Endif
  Next I%
	SHOWPAGE
GRAPHMODE 1
  print "figsel later"
'  pause 0.1 !pause 3
  If Lebem|(0)<4 And Lebem|(1)<4 And Lebem|(2)<4 And Lebem|(3)<4 Or Lebem|(0)>100 Or Lebem|(1)>100 Or Lebem|(2)>100 Or Lebem|(3)>100
    print "Ende"
    @Ende
    End
  Endif
  print "figsel later2"
  If Figsez&<3
    Repeat
      If Levels&=0
        A$=Inkey$
        If Val(A$)>0
          Levels&=Val(A$)-1
          Kein_highscore&=1
        Endif
      Endif
	  '-----------keyevent
      print "wait for key"
	  keytrig%=0
	  keytick%=0
	  KEYEVENT kc,ks,t$,x,y,xr,yr,k
	  Taste% = ks
      Select Taste%
        Case 13
          keytrig%=-1
		  Ret&=1
        Case 273
          keytick%=1
        Case 274
          keytick%=2
        Default
	      print "default"
		  print Taste%
      Endselect
	  '----------
      Select keytick%    !Select Stick(1)
      Case 1
        Figsez&=0
        Repeat
          FignA%=Fign&
          Fign&=((Fign&+3) Mod 4)
		  GRAPHMODE 1
	COLOR  yellow,blue
	Pbox 113,FignA%*8*13+20,113+18,FignA%*8*13+20+16   !Put 113,FignA%*8*13+20,Auswahlpfeil$,15  !???????????????????????
		  GRAPHMODE 2
	'--
	COLOR  blue,yellow
	Pbox 113,Fign&*8*13+20,113+18,Fign&*8*13+20+16
	COLOR  yellow,blue
	'--
          @put_pic(113,Fign&*8*13+20,Auswahlpfeil$)  ! @putpic(Auswahlpfeil$,2113,Fign&*8*13+20) !Put 113,Fign&*8*13+20,Auswahlpfeil$
		  'SHOWPAGE
          Inc Figsez&
        Until Lebem|(Fign&)>3 Or Figsez&=4
        'why!Pause 1.5 'Pause 15
      Case 2
        Figsez&=0
        Repeat
          FignA%=Fign&
          Fign&=((Fign&+1) Mod 4)
		  GRAPHMODE 1
	COLOR  yellow,blue
	Pbox 113,FignA%*8*13+20,113+18,FignA%*8*13+20+16   !Put 113,FignA%*8*13+20,Auswahlpfeil$,15	
		  GRAPHMODE 2
	'--
	COLOR  blue,yellow
	Pbox 113,Fign&*8*13+20,113+18,Fign&*8*13+20+16
	COLOR  yellow,blue
	'--
          @put_pic(113,Fign&*8*13+20,Auswahlpfeil$)  ! @putpic(Auswahlpfeil$,113,Fign&*8*13+20) !Put 113,Fign&*8*13+20,Auswahlpfeil$
          Inc Figsez&
        Until Lebem|(Fign&)>3 Or Figsez&=4
        'whyy!Pause 1.5 'Pause 15
      Endselect
	  SHOWPAGE
      If keytrig=-1  !Strig(1)=True
        Ret&=1
      Endif
    Until Ret&=1 Or Figsez&=4
  Endif
  Ret&=0
  SHOWPAGE
  'Bmove Scr1%,Scr2%,32000
  'Void Xbios(5,L:Scr1%,L:Scr2%,-1)
  Akt&=Fign&
  Zu&=Akt&*2
  print "ende figur selektion"
  PUT 0,0,Scr2$ ! bildschirm wiederherstellen
Return
Procedure Name_input
  ' in dieser Procedure geben Sie ihren Namen ein!
  'Repeat
  'Until Inkey$=""
  Graphmode 1 !Graphmode 3
  Deffill 1,1
  Player$=String$(16,"_")
  COLOR yellow,blue
  'GPRINT CHR$(27);"[2J";  !fill with bgcolor
  GPRINT COLOR(34,43) ;
  Gprint at(12,32);Player$ !Gprint at(32,12);Player$
  'Xposition% = 0 ! Xposition& was not initialized
  'print "xposition",Xposition%
  GPRINT COLOR(43,34) ;
  Pbox (Xposition%+31)*8,11*16,(Xposition%+32)*8-1,12*16-1
  showpage !Bmove Scr1%,Scr2%,32000
  breakit%=0
  Do
    print "Name_input: wait for key"
	KEYEVENT kc,ks,t$,x,y,xr,yr,k  ! da INP nur im Terminal funktioniert
	print "key",kc,ks,t$,x,y,xr,yr,k
    'If Inp(-2)
	Taste% = ks
	  'Taste&=Inp(2)
      Select Taste% !Taste&
      Case 293 !316  !226
	    print "226"
        @Hilfe_name_input
      Case 282,283,284,285,286,287,288,289,290,291 !282 To 291 not supported? !212 To 221
	    print "pname:"+Pname$(0)+"-"+Pname$(1)+"-"+Pname$(2)+"-"+Pname$(3)+"-"+Pname$(4)+"-"+Pname$(5)+"-"+Pname$(6)+"-"+Pname$(7)+"-"+Pname$(8)+"-"
		IF x=1
        Pname$(291-Taste%)=Player$ !Pname$(221-Taste&)=Player$
      'Case 187 To 196
	    ELSE
	    print "187-196"
        Player$=Pname$(291-Taste%) !Player$=Pname$(196-Taste&)
		ENDIF
      Case 8 !8 !BACKSPACE
	    print "8"
        If Xposition%>0
          Player$=Left$(Player$,Xposition%-1)+Right$(Player$,16-Xposition%)+"_"
          Dec Xposition%
        Endif
      Case 127 !127 !DEL
	    print "127"
        If Xposition%<17
          Player$=Left$(Player$,Xposition%)+Right$(Player$,15-Xposition%)+"_"
        Endif
      Case 278 !199 !POS1
	    print "199"
        Player$=String$(16,"_")
        Xposition%=0
      Case 276 !203 !LINKS
	    print "203"
        If Xposition%>0
          Dec Xposition%
        Endif
      Case 275 !205 !RECHTS
	    print "205"
        If Xposition%<15
          Inc Xposition%
        Endif
      Case 277 !210 !EINFUEG
	    print "210"
        Player$=Left$(Player$,Xposition%)+"_"+Mid$(Player$,Xposition%+1,16-Xposition%+1)
        Player$=Left$(Player$,16)
      Case 303 ! SHIFT
	    print "grosser Buchstabe?"
      Case 13 ! ENTER
	    print "13"
		breakit%=1
        BREAK !Exit if True
      Default
	    print "default"
		print Chr$(Taste%)
        Player$=Left$(Player$,Xposition%)+t$+Right$(Player$,LEN(Player$)-Xposition%-1)     ! Player$=Left$(Player$,Xposition&)+Chr$(Taste%)+Right$(Player$,LEN(Player$)-Xposition&-1)                 !Mid$(Player$,Xposition&+1,1)=Chr$(Taste%)
        If Xposition%<15
          Inc Xposition%
        Endif
      Endselect
 ' GPRINT COLOR(43,35) ;
 ' Gprint at(22,12);"Player:";Player$
	  '      COLOR blue,yellow
			COLOR yellow,blue		
	  Pbox (0+31)*8,11*16,(15+32)*8-1,12*16-1  !Pbox (0+31)*8,11*16,(Xposition%-1+32)*8-1,12*16-1 !vorher statt danach	
	  GPRINT COLOR(34,43) ;
      Gprint at(12,32);Player$ !Gprint at(32,12);Player$
	  GPRINT COLOR(43,34) ;
	  Graphmode 3
      Pbox (Xposition%+31)*8,11*16,(Xposition%+32)*8-1,12*16-1
	  Graphmode 1
	  SHOWPAGE
	  IF breakit%=1
	    BREAK
	  ENDIF
    'Endif
    'Bmove Scr1%,Scr2%,32000
	'cls
    print "loop"
  Loop
  'cls
  While Instr(Player$,"_")>0
    Player$=REPLACE$(Player$,"_"," ")     !Mid$(Player$,Instr(Player$,"_"))=" "
  Wend
  If Player$="                "
    Player$="Mister X"
  Endif
  Player$=Trim$(Player$)
  Player$=Left$(Space$((16-Len(Player$))/2)+Player$+"         ",16)
  W%=112  !W&=112
  'COLOR yellow,blue
  '@put_pic(203,265,Ende$) !Put 203,265,Ende$
  'showpage
  'Pbox 202+W%,264,202+107+W%,265+18
'---
COLOR blue,yellow
@put_pic(203,265,Ende$)
GET 202+1,264+1,107-1,18,EndeLInv$
GET 202+W%+1,264+1,107-1,18,EndeRInv$
COLOR yellow,blue
@put_pic(203,265,Ende$)
GET 202+1,264+1,107-1,18,EndeL$
GET 202+W%+1,264+1,107-1,18,EndeR$
COLOR yellow,blue
Pbox 202,264,202+107+W%+10,265+18
PUT 202,264,EndeL$
PUT 202+W%,264,EndeRInv$
  showpage !  Bmove Scr1%,Scr2%,32000
  Hilfsel%=1  !Hilfsel&=1
  DO
  'Repeat
'  COLOR COLOR_RGB(0,1,0),COLOR_RGB(0,0,0)
'Pbox 1,1,600,400
    KEYEVENT kc,ks,t$,x,y,xr,yr,k    !Select Stick(1)
	Taste% = ks
	breakit%=0
    Select Taste%
    Case 276  !4 !links
      If Hilfsel%=1
        Hilfsel%=0
        'Pbox 202+W%,264,202+W%+107,265+18
        'Pbox 202,264,202+107,265+18
COLOR yellow,blue
PUT 202,264,EndeLInv$
PUT 202+W%,264,EndeR$
      Endif
    Case 275  !8 !rechts
      If Hilfsel%=0
        Hilfsel%=1
        'Pbox 202+W%,264,202+W%+107,265+18
        'Pbox 202,264,202+107,265+18
COLOR yellow,blue
PUT 202,264,EndeL$
PUT 202+W%,264,EndeRInv$
      Endif
	Default
	  breakit%=1
    Endselect
'COLOR COLOR_RGB(0,1,0),COLOR_RGB(0,0,0)
'Pbox 202+1,264+1,202+107-1,265+18-1
'COLOR COLOR_RGB(1,0,0),COLOR_RGB(0,0,0)
'Pbox 202+W%,264,202+107+W%,265+18
    SHOWPAGE !Bmove Scr1%+264*80,Scr2%+264*80,1600
	  IF breakit%=1
	    BREAK
	  ENDIF
  LOOP
  print "endloop"
  'Until Strig(1)<>0
  'Repeat
  'Until Strig(1)=0
  'Pause 10
  If Hilfsel%=0
    @Highscor_schreiben
    Showm
    'Stick(0) !Stick 0
    clearw
	closew !Void Xbios(5,L:Scr1%,L:Scr1%,-1)
	showpage
    End
  Endif
  Graphmode 1
Return
Procedure Hilfe_name_input
  ' Diese Schrift k"+Chr$(148)+"nnen Sie bewundern, fals Sie w"+Chr$(132)+"hrend der Eingabe Ihres
  ' Namens Help dr"+Chr$(129)+"cken!
  GET 0,0,600,400,Scr2$
  'clearw ! Void Xbios(5,L:Scr2%,L:Scr2%,-1)
COLOR yellow,blue
  GPRINT COLOR(34,43) ; 
  GPRINT CHR$(27);"[2J";  !Cls
GPRINT COLOR(43,34) ; 
  ' GPRINT COLOR(43,35) ;
  GPRINT AT(1,1);" " !  Print !Print
  GPrint "   Hilfe zur Tastenbelegung :"
  GPrint
  GPrint " - Insert  :  Durch den Druck dieser Taste wird an der Position des Kursors"
  GPrint "              ein Leerzeichen (_) einger"+Chr$(129)+"ckt !"
  GPrint
  GPrint " - Clr Home:  Durch den Druck dieser Taste wird der momentane Name gel"+Chr$(148)+"scht !"
  GPrint
  GPrint " - Pfeile  :  (rechts\links)Durch diese beiden Tasten kann auf die Position "
  GPrint "              des Kursors einflu"+Chr$(158)+" genommen werden !"
  GPrint
  GPrint " - Delete  :  Diese Taste bewirkt , da"+Chr$(158)+" das Zeichen , welches sich unter dem"
  GPrint "              Kursor befindet gel"+Chr$(148)+"scht und der Rest des Namens aufger"+Chr$(129)+"ckt"
  GPrint "              wird !"
  GPrint	
  GPrint " - Backspace: Diese Taste erm"+Chr$(148)+"glicht es dem User das Zeichen links vom Kursor"
  GPrint "              zu l"+Chr$(148)+"schen und gleichzeitig den Rest der Zeichenkette aufr"+Chr$(129)+"cken"
  GPrint "              zu lassen !"
  GPrint
  GPrint " - F1 - F10:  Mit diesen Tasten kann man einen gespeicherten Namen aufrufen !"
  GPrint
  GPrint " - Schift und F1 - F10 : Diese Tastenkombination speichert den momentanen "
  GPrint "        Namen auf der entsprechenden F-Taste !(Geeignet bei nehreren Spielern)"
  GPrint "        (Am anfang befinden sich "+Chr$(129)+"brigens auch schon Namen im Speicher!)"
  showpage
  KEYEVENT kc,ks ! Void Inp(2)
  GPRINT CHR$(27);"[2J";
PUT 0,0,Scr2$ ! bildschirm wiederherstellen
  showpage !Bmove Scr1%,Scr2%,32000
  'Void Xbios(5,L:Scr1%,L:Scr2%,-1)
Return
Procedure Hilfe
  ' Diese Schrift k"+Chr$(148)+"nnen Sie bewundern, fals Sie w"+Chr$(132)+"hrend des Spiels Help dr"+Chr$(129)+"cken!
  GET 0,0,600,400,Scr2$ ! !!
  COLOR yellow,blue ! !!
  'Void Xbios(5,L:Scr2%,L:Scr2%,-1)
  GPRINT CHR$(27);"[2J";  !Cls
  GPRINT AT(1,1);" " !Print
  GPrint "   Hilfe:"
  GPrint
  GPrint " - Die Funktionsweisen der Steine zu erkl"+Chr$(132)+"ren w"+Chr$(132)+"re zu komplex.Deshalb m"+Chr$(129)+"ssen"
  GPrint "   Sie sich selber durchprobieren.(Oder in die Anleitung gucken!)"
  GPrint
  GPrint " - Wenn sie nicht in der Lage sind das momentane Hindernis zu "+Chr$(129)+"berwinden,"
  GPrint "   dann k"+Chr$(148)+"nnen sie sich durch den Druck auf die F-10 Taste weiter scrollen"
  GPrint "   lassen.Diese L"+Chr$(148)+"sung kostet sie allerdings einen Lebenspunkt."
  GPrint
  GPrint " - Ist nach ihrer Meinung ein Fehler aufgetaucht,dann schreiben sie mir bitte."
  GPrint "   Beschreiben sie,welche beweglichen Dinge auf dem Spielfeld sind oder es"
  GPrint "   geradeeben noch waren."
  GPrint
  GPrint " - Auch f"+Chr$(129)+"r Vorschl"+Chr$(132)+"ge zur Erweiterung/Verbesserung habe ich immer ein offenes"
  GPrint "   Ohr."
  GPrint
  GPrint "   Schreiben sie an:"
  GPrint "                          Folke Rinneberg"
  GPrint "                          Uhlandstra"+Chr$(158)+"e 78"
  GPrint "                          2105 Seevetal 1"
  GPrint
  GPrint "                    Dieses Programm ist Public Domain(Frei weiterkopierbar)"
  showpage
  KEYEVENT kc,ks ! Void Inp(2)
  GPRINT CHR$(27);"[2J"; ! !!
  PUT 0,0,Scr2$ ! bildschirm wiederherstellen
  showpage !Bmove Scr1%,Scr2%,32000
  'Void Xbios(5,L:Scr1%,L:Scr2%,-1)
Return
Procedure Ende
  ' Wenn das Spiel zu ende ist(entweder Sie haben alle Level geschaft oder
  ' Sie haben keine Leben mehr)bekommen Sie f"+Chr$(129)+"r jedes Verblibene Leben 350
  ' Punkte.
  For I%=0 To 3          ! 1 Figuren 0 bis 3 durchlaufen lassen !I&
    While Lebem|(I%)>3   ! 2 Solange die momentane Figur noch Leben besitzt
      Add Punkte%,350   !   Restleben werden zu Punkten(1Leben=350 Punkte)
      Dec Lebem|(I%)     !   Leben um 1 ernidrigen
    Wend                ! 2 Ende
  Next I%                ! 1 Ende
  @Besten_liste
  Levels&=0
  clearw  !Void Xbios(5,L:Scr1%,L:Scr2%,-1)
  @New_start
Return
Procedure Vorspann
  ' Diese Procedure steuert die bescheidene Demo, welche Sie am Anfang
  ' bewundern d"+Chr$(129)+"rfen
  COLOR  yellow,blue
  'DEFFILL COLOR_RGB(0,0,1),0,1
  GRAPHMODE 2 ! GRAPHMODE 3
  CLEARW
  COLOR  blue,yellow
  @put_pic(244,152,Inp$) !Put 244,152,Inp$
  @put_pic(230,220,Ianthr$) !Put 230,220,Ianthr$
  @put_pic(203,265,Ende$) !Put 203,265,Ende$
  showpage
  print "vorspann schleife 1"
  For I%=1 To 200  Step 2
    COLOR  blue,yellow
    CLEARW
	Pbox I%,39,I%+315,39+64
	Pbox 244,152,379,195
	Pbox 230,220,392,252
	Pbox 203,265,420,282
	COLOR  yellow,blue
    @put_pic(244,152,Inp$) !Put 244,152,Inp$
    @put_pic(230,220,Ianthr$) !Put 230,220,Ianthr$
    @put_pic(203,265,Ende$) !Put 203,265,Ende$
  
    @put_pic(154,39,Briskb$) !Put 154,39,Briskb$
    @put_pic(I%,39,Brisk$) !Put I%,39,Brisk$,7
	showpage
	pause 0.02
    'Vsync
    'Bmove Scr1%,Scr2%,8800
  Next I%	
  print "vorspann schleife 2"
  For I%=200 To 154 Step -2
    COLOR  blue,yellow
     CLEARW
	Pbox I%,39,I%+315,39+64  
	Pbox 244,152,379,195
	Pbox 230,220,392,252
	Pbox 203,265,420,282
	'Pbox 0,0,639,399
	COLOR  yellow,blue
    @put_pic(244,152,Inp$) !Put 244,152,Inp$
    @put_pic(230,220,Ianthr$) !Put 230,220,Ianthr$
    @put_pic(203,265,Ende$) !Put 203,265,Ende$
	
    @put_pic(154,39,Briskb$) !Put 154,39,Briskb$
    @put_pic(I%,39,Brisk$) !Put I%,39,Brisk$,7
	showpage
	pause 0.02
    'Vsync
    'Bmove Scr1%,Scr2%,8800
  Next I%
  COLOR  yellow,blue
  'Pause 3
  @Name_input
  Print "Ende: vorspann"
Return
Procedure Besten_liste
  ' In diese Procedure wird dein Name in die Bestenliste einsortiert und
  ' die Bestenliste angezeigt!
  '---
  GET 0,0,600,400,Scr2$
  '----
  clearw !Void Xbios(5,L:Scr2%,L:Scr2%,-1)
  Deffill 1,1,1
  Wplatz&=0
  Pbox 0,0,639,399
  @put_pic(174,30,Titel$) !  Put 174,30,Titel$
	'---
	'LPOKE XBIOS(14,1)+6,0 ! --> Sets the head and tail pointers to the keyboard buffer to the buffer start, effectively erasing the buffer.
    ' or alternately:
    'REPEAT
    'UNTIL INKEY$="" ! --> Deletes the keyboard buffer, character by character.
' --------------
'  Lpoke Xbios(14,1)+6,0
  Platz&=100
  If Kein_highscore&=0
    For J%=99 Downto 0
      If Punkte%>Score%(J%)
        Platz&=J%
      Endif
    Next J%
    If Platz&<100
      Anz&=0
      For I%=0 To 99 !I&
        If Mid$(Score$,I%*16+1,16)=Player$
          Inc Anz&
          Void2&=I%
        Endif
      Next I%
      If Anz&=3 And Platz&<=Void2&  ! =<
        Score$=Left$(Score$,Void2&*16)+Mid$(Score$,Void2&*16+17)
        'Delete Score%(Void2&)
        'Insert Score%(Platz&)=Punkte%
        Score$=Left$(Score$,Platz&*16)+Player$+Mid$(Score$,Platz&*16+1,(99-Platz&)*16)
        Wplatz&=Platz&
      Else
        If Anz&<3
          'Insert Score%(Platz&)=Punkte%
          Score$=Left$(Score$,Platz&*16)+Player$+Mid$(Score$,Platz&*16+1,(99-Platz&)*16)
          Wplatz&=Platz&
        Endif
      Endif
    Endif
  Endif
  Kein_highscore&=0
  Print ""+Chr$(27)+"p";
  Repeat
    If Platz&>6 And Platz&<93
      J2%=Platz&-6
    Else if Platz&>92
      J2%=87
    Else
      J2%=0
      Platz&=6
    Endif
    For J%=J2% To J2%+12
      Inc Hi&
      H2$=Mid$(Score$,J%*16+1,16)
      Gprint at(20,Hi&+5);Using "###",J%+1
      Gprint at(24,Hi&+5);H2$
      Gprint at(41,Hi&+5);Using "##########",Score%(J%)
      If Wplatz&>0
        Void&=Wplatz&-J2%
        Deffill 1,1,1
        If Void&<13 And Void&>-1
          Pbox 120,80,160,288
          Pbox 402,80,442,288
          @put_pic(128,80+Void&*16,Pfeill$) !  Put 128,80+Void&*16,Pfeill$
          @put_pic(402,80+Void&*16,Pfeilr$) !  Put 402,80+Void&*16,Pfeilr$
        Else if Void&<14 And Void&>-2
          Pbox 120,80,160,288
          Pbox 402,80,442,288
        Endif
      Endif
    Next J%
    Hi&=0
	'---
	'LPOKE XBIOS(14,1)+6,0 ! --> Sets the head and tail pointers to the keyboard buffer to the buffer start, effectively erasing the buffer.
    ' or alternately:
    'REPEAT
    'UNTIL INKEY$="" ! --> Deletes the keyboard buffer, character by character.
' --------------
    'Lpoke Xbios(14,1)+6,0
	'keyevent
	KEYEVENT kc,ks,t$,x,y,xr,yr,k 
	Taste% = ks
    Select Taste% 
    Case 273 !UP
	  print "up"
      Platz&=(Platz&+1)
      If Platz&>93
        Platz&=93
      Endif
    Case 274 !DOWN
	  print "down"
	  Dec Platz&
    Endselect
   ' A%=Inp(2)
    'If A%=200
    '  Platz&=(Platz&+1)
    '  If Platz&>93
    '    Platz&=93
    '  Endif
    'Else if A%=208
      Dec Platz&
    'Endif
  Until Taste%=13 ! A%=13
  Print ""+Chr$(27)+"q";
  '---
  PUT 0,0,Scr2$ ! bildschirm wiederherstellen
  showpage !Bmove Scr1%,Scr2%,32000
  '---
  'Bmove Scr1%,Scr2%,32000
  'Void Xbios(5,L:Scr1%,L:Scr2%,-1)
Return
Procedure Score_bak
  ' Wenn die Datei B__SCORE.DAT nicht in ordnung ist und man sich daf"+Chr$(129)+"r entschieden
  ' hat das Backuk einzuladen, dann kommt man in diese Procedure, welche
  ' B_SCORE.BAK einlie"+Chr$(158)+"t!
  Close
  If Exist("run_jump\b__score.bak")
    Open "i",#1,"run_jump\b__score.bak"
    If Lof(#1)=2004
      Scorec%=Cvl(Input$(4,#1))
      Score$=Input$(1600,#1)
      B%=Cvl(Mid$(Score$,0,4))
      For I%=0 To 398 !I&
        B%=B% Xor Cvl(Mid$(Score$,4+I%*4,4))
      Next I%
      For I%=0 To 99
        Score%(I%)=Cvl(Input$(4,#1))
        B%=B% Xor Score%(I%)
      Next I%
      If B%<>Scorec%
        Fehler$="Die Daten in B__Score.bak sind nicht korrekt!"
        @Fehler
      Endif
    Else
      Fehler$="B__Score.bak hat die faltsche L"+Chr$(132)+"nge!"
      @Fehler
    Endif
    Close
  Else
    Fehler$="B__Score.bak ist nicht auf dieser Diskette!"
    @Fehler
  Endif
Return
Procedure Highscor_einlesen
  ' Hier wird der Highscore am Anfang des Sieles eingeladen!
  If Exist("run_jump\b__score.dat")
    Open "i",#1,"run_jump\b__score.dat"
	Print "b__score.dat ge"+Chr$(148)+"ffnet"
	ll = Lof(#1)
	print ll
    If Lof(#1)=2004
      print "inif"
      Scorec%=Cvl(Input$(#1,4)) !Input$(4,#1)
      Score$=Input$(#1,1600) !Input$(1600,#1)
      B%=Cvl(Mid$(Score$,0,4))
      For I%=0 To 398 !I&
        B%=B% Xor Cvl(Mid$(Score$,4+I%*4,4)) !I&
      Next I% !I&
      For I%=0 To 99 !I&
        Score%(I%)=Cvl(Input$(#1,4)) !Cvl(Input$(4,#1)) !I&
        B%=B% Xor Score%(I%) !I&
      Next I% !I&
      If B%<>Scorec%
        Fehler$="Die Daten in B__Score.dat sind nicht korrekt!"
        @Fehler
        @Score_bak !Score_bak
      Endif
    Else
      Fehler$="B__Score.dat hat die faltsche L"+Chr$(132)+"nge!"
      @Fehler
      @Score_bak !Score_bak
    Endif
    Close
  Else
    Fehler$="B__Score.dat ist nicht auf dieser Diskette!"
    @Fehler
    @Score_bak !Score_bak
  Endif
Return
Procedure Highscor_schreiben
  ' in dieser Procedure wird der momentan auf der Diskette existierende Highscore
  ' mit der Extension ".BAK" vesehen und der neue mit der Extention ".DAT"
  ' gespeichert!
  B%=Cvl(Left$(Score$,4))
  For I%=0 To 398 !I&
    B%=Xor(B%,Cvl(Mid$(Score$,I%*4+4,4)))
  Next I%
  For I%=0 To 99
    B%=B% Xor Score%(I%)
  Next I%
  If Exist("run_jump\b__score.dat")
    Open "i",#1,"run_jump\b__score.dat"
    I%=Lof(#1)
    Close
    If I%=2004
      If Exist("run_jump\b__score.bak")
        Kill "run_jump\b__score.bak"
      Endif
      Rename "run_jump\b__score.dat","run_jump\b__score.bak" !Rename "run_jump\b__score.dat" As "run_jump\b__score.bak"
    Endif
  Endif
  Open "o",#1,"run_jump\b__score.dat"
  Print #1,Mkl$(B%);
  Print #1,Score$;
  For I%=0 To 99 !I&
    Print #1,Mkl$(Score%(I%));
  Next I%
  Close
Return
Procedure Neuer_levelrekord
  ' wenn deine Punkte in dem momentanen Level h"+Chr$(148)+"her waren, als der Levelrekord,
  ' dann speichert diese Procedure den neuen Levelrekord!
  Hik&=0
  ' ersten 41 Bytes aktualisieren (auch xor-Code neu bestimmen)
  A$=Right$("000"+Str$(Levels&),3)                  !3-Stellig machen
  print "try to open levels\level"+A$+".lev"
  Open "i",#1,"levels\level"+A$+".lev"  !
  Void Cvl(Input$(4,#1))
  For I%=0 To 9 !I&
    Code%=Code% Xor Cvl(Input$(4,#1))
  Next I%
  Close
  Open "u",#1,"levels\level"+A$+".lev"  !Datei "+Chr$(148)+"ffnen
  Print #1,Mkl$(0);
  Print #1,Erbauer$;
  Print #1,Mkl$(Maxpunkte%);
  Print #1,Maxpunktename$;
  Print #1,Chr$(Lebenverlust&+128);
  Close
  Open "i",#1,"levels\level"+A$+".lev"  !Datei "+Chr$(148)+"ffnen
  Void Cvl(Input$(4,#1))
  For I%=0 To 9 !I&
    Code%=Code% Xor Cvl(Input$(4,#1))
  Next I%
  Close
  Open "u",#1,"levels\level"+A$+".lev"  !Datei "+Chr$(148)+"ffnen
  Print #1,Mkl$(Code%);
  Close
Return
Procedure Fehler
  ' wenn ein Fehler in einer der Dateien dieses Programms entdeckt wird,
  ' dann wird in dieser Procedure eine Ausgabe auf dem Bildschirm gemacht!
  'Void Xbios(5,L:Scr2%,L:Scr2%,-1)
  ''''''Cls ' CLS
  Gprint at(1+(80-Len(Fehler$))/2,5);Fehler$ ! Ausgabe von fehler$ auf dem Bildschirm
  GPrint Space$((78-Len(Fehler$))/2)+String$(Len(Fehler$)+2,"*")
  GPrint Space$((76-Len(Fehler$))/2)+String$(Len(Fehler$)+6,"*")
  GPrint
  GPrint
  GPrint
  GPrint "        Wenn Sie nicht verstehen,wie dieser Fehler auftauchen konnte"
  GPrint "        und/oder sie ihn nicht beseitigen k"+Chr$(148)+"nnen,dann schicken Sie"
  GPrint "        mir ihre Diskette mit adressierten und frankiertem R"+Chr$(129)+"ckumschlag."
  GPrint "        Ich werde dann die defekte Datei durch die Orginaldatei ersetzen!"
  GPrint
  GPrint "                                Folke Rinneberg"
  GPrint "                                Uhlandstra"+Chr$(158)+"e 78"
  GPrint "                                2105 Seevetal 1"
  GPrint "                                Geb.am29.6.1973"
  GPrint
  GPrint
  GPrint "        Sie haben doch nicht etwa versucht die Datei zu ver"+Chr$(132)+"ndern?"
  GPrint
  GPrint "                               ( Taste dr"+Chr$(129)+"cken! )"
  KEYEVENT kc,ks ! Void Inp(2)
  If Instr(Fehler$,"B__Score.dat",1)>0
    Cls
    ' Stick(0) !Stick 0
    'Lpoke Xbios(14,1)+6,0
    Alert 0,"Soll das Backub|eingeladen werden?  ",1,"  Ja  | Nein ",Alert&
    KEYEVENT kc,ks,t$,x,y,xr,yr,k ! Stick(1) !Stick 1
    If Alert&=2
      End
    Else
      clearw ! Bmove Scr1%,Scr2%,32000
      'Void Xbios(5,L:Scr1%,L:Scr2%,-1)
    Endif
  Else
    End
  Endif
Return
Procedure Monsterauflosen
  ' Wenn ein Monter dich ber"+Chr$(129)+"hrt oder du ein Monster abschie"+Chr$(158)+"t, dann mu"+Chr$(158)+" es
  ' vom Bildschirm gel"+Chr$(148)+"scht werden (Hintergrund restaurieren)
  ' mb :Die Breite des Monsters (wenn mb=0 wird der Hintergrund nicht restauriert)
  ' mh :Die H"+Chr$(148)+"he des Monsters
  Select Monstertyp&(Tod%)
  Case 111,96
    Mb&=0
  Case 112
    Mb&=15
    Mh&=8
  Case 94
    Mb&=19
    Mh&=19
  Case 95
    Mb&=9
    Mh&=9
  Case 100,98
    Mb&=39
    Mh&=19
  Case 104
    Mb&=39
    Mh&=20
  Case 96,97,98,99,105,114  ! Case 96 To 99,105,114
    Mb&=39
    Mh&=39
  Case 101,102
    Mb&=29
    Mh&=39
  Case 103
    Mb&=39
    Mh&=15
  Case 106
    Mb&=19
    Mh&=39
  Case 107
    Mb&=39
    Mh&=17
  Case 109
    Mb&=31
    Mh&=25
  Case 115
    Mb&=0
  Endselect
  If X%(Tod%)>=0
    If X%(Tod%)+Mb&+1<=640
      If Y%(Tod%)>=0
        If Y%(Tod%)+Mh&+1<=400
          ' Monster befindet sich vollst"+Chr$(132)+"ndig auf dem Bildschirm
          'Rc_copy Scr1%,X%(Tod&),Y%(Tod&),Mb&+1,Mh&+1 To Scr2%,X%(Tod&),Y%(Tod&)!Leeren Hintergrund r"+Chr$(129)+"ber kopieren
        Endif
      Endif
    Endif
  Endif
Return
Procedure Schuss_weg
  ' Wenn dein Schuss den Sichtbereich verl"+Chr$(132)+""+Chr$(158)+"t ist er nicht mehr aktiv (Es kann wieder geschossen werden!)
  If Schussr%>0
    If SchussX%>-1
      If SchussX%<640
        If SchussY%>-1
          If SchussY%<400
            'Rc_copy Scr1%,SchussX%,SchussY%,8,8 To Scr2%,SchussX%,SchussY%
          Endif
        Endif
      Endif
    Endif
    Schussr%=0
  Endif
Return
FUNCTION loadpic2$(n%)
	LOCAL a$, b$, t%
	a$=Input$(#1,n%) 
	b$=LEFT$(a$,6)
	FOR t%= 7 TO n%
      b$ = b$ + LEFT$(MKI$(bitswap(CVI(mid$(a$,t%)))))
    NEXT t%
	RETURN b$
ENDFUNC
FUNCTION loadpic$(n%)
	LOCAL a$, b$, t%, wd%, wdX%, ht%, frows%, arest%, thisbytepxls%
	
	' Höhe und Breite ermitteln
	a$=Input$(#1,n%) 
	wd%=cvi(mid$(a$,2)+mid$(a$,1))+1
    wdX% = wd%
    IF mod(wd%,16)>0 
	  wdX%=wdX%+16-mod(wd%,16) !gerade anzahl von bytes?
	ENDIF
    ht%=cvi(mid$(a$,4)+mid$(a$,3))+1
	
	' Bilddaten speichern
	b$=LEFT$(a$,6)
	
	FOR t%= 7 TO n%
	  'frows% = t%*8 div wdX%
	  arest% = (((t%-6)*8) mod wdX%)
	  IF arest%<1
		If (wdX%-wd%>=8) !IF ((wdX%-wd%) mod 8=0) AND (wdX%>wd%) !mod needs parentheses
		  thisbytepxls% = bitfill2(8)
		ELSE
	      thisbytepxls% = bitfill2((wdX%-wd%) mod 8)
		ENDIF
	  ENDIF
	  IF arest% > wd%
	    If wd%>arest%
		  thisbytepxls% = bitfill2(8-8)
		else
	      thisbytepxls% = bitfill2(8-(arest%-wd%))
		ENDIF
	  ENDIF
	  'IF ((t%-6)*8) mod wdX% > wd% OR ((t%-6)*8) mod wdX% == wd%
      IF arest% > wd% OR arest%<1 korrekt
	    b$ = b$ + LEFT$(MKI$(bitswap((CVI(mid$(a$,t%))) AND thisbytepxls%)))       !LEFT$(MKI$(bitswap(0)))
		'b$ = b$ + LEFT$(MKI$(bitfill(8))) 
      ELSE
        b$ = b$ + LEFT$(MKI$(bitswap(CVI(mid$(a$,t%)))))
      ENDIF
    NEXT t%
	RETURN b$
ENDFUNC
PROCEDURE put_pic(X%, Y%, pic$)
'print "will put"
	LOCAL wd%, wdX%, ht%, bt%
	wd%=cvi(mid$(pic$,2)+mid$(pic$,1))+1
	wdX% = wd%
    IF mod(wd%,16)>0 
	  wdX%=wdX%+16-mod(wd%,16) !gerade anzahl von bytes?
	ENDIF
    ht%=cvi(mid$(pic$,4)+mid$(pic$,3))+1
    bt%=cvi(mid$(pic$,6)+mid$(pic$,5))
	'print str$(wd%)+"("+str$(wdX%)+")x"+str$(ht%)+"x"+str$(bt%)+"@"+str$(X%)+"x"+str$(Y%)
    'Put_Bitmap RIGHT$(pic$,LEN(pic$)-6),X%,Y%,wdX%,ht%
	Put_Bitmap RIGHT$(pic$,LEN(pic$)-6),X%,Y%,wdX%,ht%
RETURN
PROCEDURE put_pic_wh(X%, Y%, put_W%, put_H%, pic$)
    GRAPHMODE 2
    COLOR blue,yellow
    ' CLEARW
	Pbox X%,Y%,X%+put_W%-1,Y%+put_H%-1
	COLOR yellow,blue
    @put_pic(X%,Y%,pic$)
	GRAPHMODE 1
RETURN
' wie oben, andere reihenfolge der args
'PROCEDURE putpic(pic$, X%, Y%)
'	LOCAL wd%, wdX%, ht%, bt%
'	wd%=cvi(mid$(pic$,2)+mid$(pic$,1))+1
'	wdX% = wd%
 '   IF mod(wd%,16)>0 
'	  wdX%=wdX%+16-mod(wd%,16) !gerade anzahl von bytes?
'	ENDIF
'    ht%=cvi(mid$(pic$,4)+mid$(pic$,3))+1
 '   bt%=cvi(mid$(pic$,6)+mid$(pic$,5))
'	'print str$(wd%)+"("+str$(wdX%)+")x"+str$(ht%)+"x"+str$(bt%)+"@"+str$(X%)+"x"+str$(Y%)
 '   'Put_Bitmap RIGHT$(pic$,LEN(pic$)-6),X%,Y%,wdX%,ht%
'	Put_Bitmap RIGHT$(pic$,LEN(pic$)-6),X%,Y%,wdX%,ht%
'RETURN
PROCEDURE handle_events()
  WHILE event?(-1)<0
    'pause 0.1
    EVENT t,x,y,xroot,yroot,s,k,ks,t$,tim
	If t=2
	  kb%(k)=1
	  Select k
      Case 293 !226 !HELP
        @Hilfe
      Case 291 !196 !F 10 : SELBSTMORD
        'Dec Lebem|(Akt&)  ! infinite cheating...
        @Wscroll
        If Lebem|(Akt&)<4 Or Lebem|(Akt&)>100
          @Figur_selection
        Endif
      Case 292 !27
        For Iin%=0 To 60 !I&
			For Iiin%=0 To 15 !I&
			  '@Wscroll 
			  @Hinter
			  @Monster
			  showpage
			  SAVEWINDOW "MAP_LEV1_"+Right$("0"+Str$(Iin%),2)+".BMP"
	   ' Y%=ScrollY%*40-63
	   ' A%=400
			Next Iiin%
        Next Iin%
        'For I%=0 To 3 !I& ! I schon anderswo benutzt und funzt nicht?
        '  Lebem|(I%)=3
        'Next I%
        '@Ende
        '	End
      Endselect
	ELSE if t=3
	  kb%(k)=0
	ELSE IF t=4
	  mb$(s)="1"
    ELSE if t=5
	   mb$(s)="0"
    ENDIF
  WEND !ELSE
RETURN
PROCEDURE show_wait()
	showpage
	While Timer<Ts+0.1
    Wend
	Ts=Timer
RETURN
PROCEDURE put_back()
	For PA%=0 To 5  		  
	  IF BachmA$(PA%)<>""
        Put X%(PA%),Y%(PA%),BachmA$(PA%)
      ENDIF
      BachmA$(PA%)=""
    Next PA%
	IF Back$<>""
	  Put A%,Y%,Back$                         !Hintergrund der Frucht putten
	  Back$=""
	ENDIF
	IF Bacm$<>""
	  Put A%,Y%+63-110,Bacm$
	  Bacm$=""
	ENDIF
RETURN
PROCEDURE put_back1()
	IF Back$<>""
	  Put Aalt%,max(0,Yalt%),Back$                         !Hintergrund der Frucht putten
	  Back$=""
	ENDIF
RETURN
PROCEDURE put_back2()
	For PA%=0 To 5  		  
	  IF BachmA$(PA%)<>""
        Put X%(PA%),Y%(PA%),BachmA$(PA%)
      ENDIF
      BachmA$(PA%)=""
    Next PA%
RETURN
PROCEDURE put_backM1()
	For PA%=0 To 2 		  
	  IF BachmA$(PA%)<>""
        Put X%(PA%),Y%(PA%),BachmA$(PA%)
      ENDIF
      BachmA$(PA%)=""
    Next PA%
RETURN
PROCEDURE put_backM2()
	For PA%=3 To 5  		  
	  IF BachmA$(PA%)<>""
        Put X%(PA%),Y%(PA%),BachmA$(PA%)
      ENDIF
      BachmA$(PA%)=""
    Next PA%
RETURN
PROCEDURE put_back_Schuss()
	IF Schussb$<>""
	  Put SchussX%,SchussY%,Schussb$                         !Hintergrund vom Schuss putten
	  Schussb$=""
	ENDIF
RETURN
'PROCEDURE put_BackMPlatt()
'	IF BackmPF$<>""
'	  Put XPF_alt%,YPF_alt%,BackmPF$                         !Hintergrund vom Schuss putten
'	  BackmPF$=""
'	ENDIF
'RETURN
PROCEDURE put_BackMall()
    For I_Ma%=0 To 5 
	  IF Backm_all$(I_Ma%)<>""
	    Put X_alt%(I_Ma%),Y_alt%(I_Ma%),Backm_all$(I_Ma%)                        !Hintergrund vom Schuss putten
	    Backm_all$(I_Ma%)=""
	  ENDIF
    Next I_Ma%
RETURN
PROCEDURE put_BackM_P(P%)
	  IF Backm_all$(P%)<>""
	    Put X_alt%(P%),Y_alt%(P%),Backm_all$(P%)                        !Hintergrund vom Schuss putten
	    Backm_all$(P%)=""
	  ENDIF
RETURN
PROCEDURE put_BackMPlanz()
	IF BackmPz$<>""
	  Put XPl_alt%,YPl_alt%,BackmPz$                         !Hintergrund vom Schuss putten
	  BackmPz$=""
	ENDIF
RETURN
PROCEDURE put_BackMPSchwalb()
	IF BackmSw$<>""
	  Put XSw_alt%,YSw_alt%,BackmSw$                         !Hintergrund vom Schuss putten
	  BackmSw$=""
	ENDIF
RETURN
PROCEDURE show_fig_wait()
	Get A%,max(Y%,0),39,64,Back$  !Get A%,max(Y%,0),39,64,tBack$
	Aalt%=A%
	Yalt%=max(Y%,0)
	GRAPHMODE 2
	COLOR blue,yellow
    @put_pic(A%,Y%,S$(Ap%,Zu&+Skeletti&))  !Frucht ausmaskieren
	COLOR yellow,blue
    @put_pic(A%,Y%,Fig$(Ap%,Zu&+Skeletti&))  !Frucht putten
	GRAPHMODE 1
	@show_wait
	@put_back1  !Put A%,max(Y%,0),tBack$
RETURN
Data 11073,14730,11980,12414,12172,7257,7572,5127,5732,5810,5902,6204,4007,6608
Data 5202,7387,8530,5095,5045,4539,4155,4372,4999,6623,5023,7209,8016,5661,5968
Data 3994,3171,2858,10772,10164,8124,7421,8177,8759
Data "   Der Looser   "," Jemand anderes "," Wer bin ich ?? "
Data "Ich bleib Anonym"," Namen sind egal","  Uninteressant "
Data "     Niemand    ","     Nobody     "," Gunnar Zarncke "
Data " * Thin Rinni * "