Library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity Mano_Machine_F is
   Port(
         St       :  in     std_logic                      ;
         clk      :  in     std_logic                      ;
         Inuser   :  in     std_logic_vector( 7 downto 0 ) ;
	      dig1     : out     std_logic_vector(6 downto 0)   ;
         dig2     : out     std_logic_vector(6 downto 0)   ;
    	   dig3     : out     std_logic_vector(6 downto 0)   ;
         Output   : out     Std_logic_vector(7 downto 0 ) 
        );
End Entity;


Architecture Mano_Machine_F_Behave Of Mano_Machine_F  is
Component  Mano_Machine is
   Port(
         St      :  in      std_logic                      ;
         clk     :  in      std_logic                      ;
         Inuser  :  in      std_logic_vector( 7 downto 0 ) ;
         Output  :  out     Std_logic_vector( 7 downto 0 ) 
        );
End Component;
Component Clock_controll_50MHZ_T_50HZ is 
  port(
        clkin   : in  std_logic     ;
        EN      : in  std_logic     ;
        reset   : in  std_logic     ;
        clkout  : out std_logic     
       );
End Component;
Component  CONVERTER is
port(
     INS      : in  std_logic_vector(15 downto 0)  ;
	  datadig1 : out integer  range 0 to 9          ;
	  datadig2 : out integer  range 0 to 9          ;
	  datadig3 : out integer  range 0 to 9          ;
	  datadig4 : out integer  range 0 to 9          ;
	  datadig5 : out integer  range 0 to 9          
	  );
End Component;
Component  Disp_CA is
  Port(
       datadig1 : in  integer  range 0 to 9          ;
       datadig2 : in  integer  range 0 to 9          ;
    	 datadig3 : in  integer  range 0 to 9          ;
    	 datadig4 : in  integer  range 0 to 9          ;
       datadig5 : in  integer  range 0 to 9          ;
       Clk      : in  std_logic                      ;
       dig1     : out std_logic_vector(6 downto 0)   ;
       dig2     : out std_logic_vector(6 downto 0)   ;
    	 dig3     : out std_logic_vector(6 downto 0)   ;
       dig4     : out std_logic_vector(6 downto 0)   ;
       dig5     : out std_logic_vector(6 downto 0)   
       );  
End Component;
Signal Clk0     : Std_logic                       ;--Controlled CLK
Signal OM_D     : Std_logic_vector(7  downto 0)   ;--Out data 8  bit
Signal OC_D     : Std_logic_vector(15 downto 0)   ;--Out data 16 bit
Signal datadig1 :  integer  range 0 to 9          ;--Converted Dig1
Signal datadig2 :  integer  range 0 to 9          ;--Converted Dig2
Signal datadig3 :  integer  range 0 to 9          ;--Converted Dig3
Signal datadig4 :  integer  range 0 to 9          ;--Converted Dig4
Signal datadig5 :  integer  range 0 to 9          ;--Converted Dig5
Begin
CC1 : Clock_controll_50MHZ_T_50HZ Port Map (Clk,st,'0',Clk0);
CC2 : CONVERTER Port Map (OC_D,Datadig1,datadig2,datadig3,datadig4,datadig5);
CCD : Disp_CA   Port Map (Datadig1,datadig2,datadig3,datadig4,datadig5,Clk0,Dig1,Dig2,Dig3,open,open);
MM1 : Mano_Machine Port Map (St,CLk0,Inuser,OM_D);
OC_D <= "00000000" & OM_D ;
Output <= OM_D ;
End Architecture;