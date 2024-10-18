--Mano Machine--


Library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity Mano_Machine is
   Port(
         St      :  in      std_logic                      ;
         clk     :  in      std_logic                      ;
         Inuser  :  in      std_logic_vector( 7 downto 0 ) ;
         Output  :  out     Std_logic_vector( 7 downto 0 ) 
        );
End Entity;
Architecture Mano_Machine_Behave of Mano_Machine is

------------ Components -------------

Component Memory_4096 is
   port(
         inpm    : in   std_logic_vector(15 downto 0);
         outpm   : out  std_logic_vector(15 downto 0);
         AR      : in   std_logic_vector(11 downto 0);
         w       : in   std_logic;
         clk     : in   std_logic;
         r       : in   std_logic
   );
End Component;
Component AR16 is
port (
      inar : in    std_logic_vector(11  downto 0);
      outar: out   std_logic_vector(11  downto 0);
      clk  : in    std_logic                    ;
      load : in    std_logic                    ;
      incr : in    std_logic                    ;
      clr  : in    std_logic                    
      );
End Component;
Component  PC_16 is 
port( 
   inpc  : in   std_logic_vector(11 downto 0)  ;
	  outpc : out  std_logic_vector(11  downto 0) ;
	  clk   : in   std_logic                      ;
	  load  : in   std_logic                      ;
	  clr   : in   std_logic                      ;
	  incr  : in   std_logic 
	  );
End Component;
Component DR_16 is 
port (
      indr : in    std_logic_vector(15  downto 0);
      outdr: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
      DR0  : out   std_logic                     ;
      clr  : in    std_logic                    
      );
END Component;
Component AC_16 is 
port (
      inac : in    std_logic_vector(15  downto 0);
      outac: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
	    	AC15 : out   std_logic                     ;
		    AC0  : out   std_logic                     ;
      clr  : in    std_logic                    
      );
END Component;
Component IR_16 is
port(
     inir  : in   std_logic_vector(15 downto 0);
	  outir : out  std_logic_vector(15 downto 0);
	  clk   : in   std_logic                    ;
	  load  : in   std_logic                     
	  );
END Component;
Component TR_16 is 
port (
      intr : in    std_logic_vector(15  downto 0);
      outtr: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
      clr  : in    std_logic                    
      );
END Component;
Component  INPR is
  port(
       inin    : in  std_logic_vector(7 downto 0 );
       outin   : out std_logic_vector(7 downto 0 );
       FGI     : in  std_logic                    ;
       clk     : in  std_logic
       );
END Component;
Component  OUTR16 is
port(
     inoutr   : in   std_logic_vector(7 downto 0) ;
     outoutr  : out  std_logic_vector(7 downto 0) ;
     FGO      : in   std_logic                    ;
     clk      : in   std_logic                      
     );
END Component;
Component SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     En    : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
END Component;
Component  MiniALU is
 port (
        Sel     :  in  std_logic_vector(2  downto 0);
        DRin    :  in  std_logic_vector(15 downto 0);
        Acin    :  in  std_logic_vector(15 downto 0);
        ALUout  :  out std_logic_vector(15 downto 0);
        inpr    :  in  std_logic_vector(7 downto 0 );
        Cin     :  in  std_logic                    ;
        Cout    :  out std_logic                   
       );
END Component;
Component E is
port(
     inE    : in   std_logic  ;
	  loadE  : in   std_logic  ;
	  clearE : in   std_logic  ;
	  NOTE   : in   std_logic  ; 
     clk    : in   std_logic  ;
     oute   : out  std_logic  
     );
END Component;
Component FGI is
port(
     FGI_in  : in   std_logic     ;
     FGI_out : out  std_logic     ;
     clk     : in   std_logic
     );
END Component;
Component FGO is
port(
     FGO_in  : in   std_logic     ;
     FGO_out : out  std_logic     ;
     clk     : in   std_logic
     );
END Component;
Component IEN is
port(
     IENin  :  in   std_logic  ;
     IENout :  out  std_logic  ;
     clk    :  in   std_logic  
     );
End Component;
Component  S is
port(
     inuser  :  in  std_logic  ;
     inCU    :  in  std_logic  ;
     outs    :  out std_logic  ;
     clk     :  in  std_logic 
     );
END Component;
Component  R_D is
port(
     inr  : in  std_logic   ;
     outr : out std_logic   ;
     clk  : in  std_logic   
     );
END Component;
Component  Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
END Component;
Component  CU_16 is
 port(
      inir     : in    std_logic_vector(15 downto 0) ;
      DR0      : in    std_logic                     ;
      AC15     : in    std_logic                     ;
      T0,T1    : in    std_logic                     ;
      T2,T3    : in    std_logic                     ; 
      T4,T5,T6 : in    std_logic                     ;
      FGIin    : in    std_logic                     ;
      FGOin    : in    std_logic                     ;
      FGIout   : out   std_logic                     ;
      FGOout   : out   std_logic                     ;
      ALUsel   : out   std_logic_vector(2 downto 0)  ;
      laodar   : out   std_logic                     ;
      loadpc   : out   std_logic                     ;
      laoddr   : out   std_logic                     ;
      loadac   : out   std_logic                     ;
      laodir   : out   std_logic                     ;
      loadtr   : out   std_logic                     ;
      loadoutr : out   std_logic                     ;
      w        : out   std_logic                     ;
      r        : out   std_logic                     ;
      clearar  : out   std_logic                     ;
      clearpc  : out   std_logic                     ;
      clearac  : out   std_logic                     ;
      incrar   : out   std_logic                     ;
      incrpc   : out   std_logic                     ;
      incrdr   : out   std_logic                     ;
      incrac   : out   std_logic                     ;
      clearsc  : out   std_logic                     ;
      selb     : out   std_logic_vector(2 downto 0)  ;
      Rin      : in    std_logic                     ;
      IENin    : in    std_logic                     ;
      Rout     : out   std_logic                     ;
      Ein      : in    std_logic                     ;
      loadE    : out   std_logic                     ;
      NotE     : out   std_logic                     ;
      clearE   : out   std_logic                     ;
      AC0      : in    std_logic                     ;
      IENo,So  : out   std_logic                    
      );
END Component;
Component BUS16 is
port(
     inb1  :  in  std_logic_vector(11 downto 0);
	  inb2  :  in  std_logic_vector(11 downto 0);
	  inb3  :  in  std_logic_vector(15 downto 0);
	  inb4  :  in  std_logic_vector(15 downto 0);
	  inb5  :  in  std_logic_vector(15 downto 0);
	  inb6  :  in  std_logic_vector(15 downto 0);
	  inb7  :  in  std_logic_vector(15 downto 0);
	  outb  :  out std_logic_vector(15 downto 0);
	  selm  :  in  std_logic_vector(2  downto 0)
	  );
END Component;
signal      DR0      :    std_logic                     ;-- if DR=0
signal      AC15     :    std_logic                     ;--AC High Bit
--Time Pulse
signal      T0,T1    :    std_logic                     ;
signal      T2,T3    :    std_logic                     ; 
signal      T4,T5,T6 :    std_logic                     ;
--
signal      FGIin    :    std_logic                     ;--Flag Cuurent Value
signal      FGOin    :    std_logic                     ;--Flag Cuurent Value
signal      FGIout   :    std_logic                     ;--To flag
signal      FGOout   :    std_logic                     ;--To flag
signal      ALUsel   :    std_logic_vector(2 downto 0)  ;--Alu select
-- Load clear incr w r
signal      laodar   :    std_logic                     ;
signal      loadpc   :    std_logic                     ;
signal      laoddr   :    std_logic                     ;
signal      loadac   :    std_logic                     ;
signal      laodir   :    std_logic                     ;
signal      loadtr   :    std_logic                     ;
signal      loadoutr :    std_logic                     ;
signal      w        :    std_logic                     ;
signal      r        :    std_logic                     ;
signal      clearar  :    std_logic                     ;
signal      clearpc  :    std_logic                     ;
signal      clearac  :    std_logic                     ;
signal      incrar   :    std_logic                     ;
signal      incrpc   :    std_logic                     ;
signal      incrdr   :    std_logic                     ;
signal      incrac   :    std_logic                     ;
signal      clearsc  :    std_logic                     ;
--
signal      selb     :    std_logic_vector(2 downto 0)  ;--Bus Select
signal      Rin      :    std_logic                     ;-- R Current Value
signal      IENin    :    std_logic                     ;--IEN Current Value
signal      Rout     :    std_logic                     ;--To R
signal      Ein      :    std_logic                     ;--E Current Value
signal      loadE    :    std_logic                     ;--Load E
signal      NotE     :    std_logic                     ;--Not E
signal      clearE   :    std_logic                     ;--Clear E
signal      AC0      :    std_logic                     ;--If AC=0
signal      IENo,So  :    std_logic                     ;--To IEN,S
signal      DECODER  :    std_logic_vector(15 downto 0) ;--Decoder4*16 Output
signal      S_time   :    std_logic_vector(3  downto 0) ;--SC Output
Signal      AR_DATA  :    std_logic_vector(11 downto 0) ;--AR out
Signal      PC_DATA  :    std_logic_vector(11 downto 0) ;--PC out
Signal      DR_DATA  :    std_logic_vector(15 downto 0) ;--DR out
Signal      AC_DATA  :    std_logic_vector(15 downto 0) ;--AC out
Signal      IR_DATA  :    std_logic_vector(15 downto 0) ;--IR out
Signal      TR_DATA  :    std_logic_vector(15 downto 0) ;--TR out
Signal      MM_DATA  :    std_logic_vector(15 downto 0) ;--Memory out
Signal      ALU_DATA :    std_logic_vector(15 downto 0) ;--Alu out
signal      E_SSS    :    std_logic                     ;--E in - out from ALU
signal      S_DATA   :    std_logic_vector(15 downto 0) ;--Bus Out
Signal      SS_DATA  :    std_logic_vector(11 downto 0) ;--Bus out for 12bit
Signal      In_Data  :    std_logic_vector(7 downto  0) ;--INPR Out
Signal      STA_ST   :    Std_logic                     ;--S Current Value -SC Enable     
Begin
QQ1 : Decoder4   port map (S_time,DECODER);
T0 <= DECODER(0);
T1 <= DECODER(1);
T2 <= DECODER(2);
T3 <= DECODER(3);
T4 <= DECODER(4);
T5 <= DECODER(5);
T6 <= DECODER(6);
BB1 : BUS16       port map(AR_DATA,PC_DATA,DR_DATA,AC_DATA,IR_DATA,TR_DATA,MM_DATA,S_DATA,selb);
CC1 : CU_16       port map(IR_DATA,DR0,AC15,T0,T1,T2,T3,T4,T5,T6,FGIin,FGOin,FGIout,FGOout
                          ,ALUsel,laodar,loadpc,laoddr,loadac,laodir,loadtr,loadoutr,w,r,
                          clearar,clearpc,clearac,incrar,incrpc,incrdr,incrac,clearsc,selb
                          ,Rin,IENin,Rout,Ein,loadE,NotE,clearE,AC0,IENo,So);
MA1 : MiniALU     port map(ALUsel,DR_DATA,AC_DATA,ALU_DATA,In_Data,Ein,E_SSS) ;
SS_DATA <= S_DATA(11 downto 0 );
R1  : Memory_4096 port map(S_DATA,MM_DATA,AR_DATA,w,clk,r);
R2  : AR16        port map(SS_DATA,AR_DATA,clk,laodar,incrAR,clearAR);
R3  : PC_16       port map(SS_DATA,PC_DATA,clk,loadpc,clearpc,incrpc);
R4  : DR_16       port map(S_DATA,DR_DATA,clk,laoddr,incrDR,DR0,'0');
R5  : AC_16       port map(ALU_DATA,AC_DATA,clk,loadac,incrac,AC15,AC0,clearac);
R6  : IR_16       port map(S_DATA,IR_DATA,clk,laodir);
R7  : TR_16       port map(S_DATA,TR_DATA,clk,LoadTR,'0','0');
R8  : INPR        port map(inuser,In_Data,FGIin,clk);
R9  : OUTR16      port map(AC_DATA(7 downto 0),Output,FGOin,clk);
R10 : SC          port map(clk,clearsc,STA_ST,S_time);
DF1 : E           port map(E_SSS,loadE,clearE,NotE,clk,Ein);
DF2 : R_D         port map(Rout,Rin,clk);
DF3 : FGI         port map(FGIOut,FGIin,clk);
DF4 : FGO         port map(FGOout,FGOin,clk);
DF5 : IEN         port map(IENo,IENin,clk);
DF6 : S           port map(st,So,STA_ST,clk);
End Architecture;