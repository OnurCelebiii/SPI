----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2022 11:19:10
-- Design Name: 
-- Module Name: SPI_Top_Module - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPI_Top_Module is
    Port (i_data                    :           in std_logic_vector(7 downto 0)     ;
          i_sck                     :           in std_logic                        ;
          i_ss                      :           in std_logic                        ;
          i_rst                     :           in std_logic)                       ;
end SPI_Top_Module;

architecture Behavioral of SPI_Top_Module is

signal miso     :       std_logic;
signal mosi     :       std_logic;

component SPI_Master is

    Port (
    i_data                       :                  in std_logic_vector (7 downto 0)    ;
    i_sck                        :                  in std_logic                        ;
    i_miso                       :                  in std_logic                        ;
    i_ss                         :                  in std_logic                        ;
    i_rst                        :                  in std_logic                        ;
    o_mosi                       :                  out std_logic)                      ;

end component;

component SPI_Slave is

    Port (i_sck                 :                   in std_logic                        ;                                  
          i_mosi                :                   in std_logic                        ;                                  
          i_ss                  :                   in std_logic                        ;                                  
          i_rst                 :                   in std_logic                        ;       -- asyncron rst            
          o_miso                :                   out std_logic)                      ;                                  
                                                                                                                           
end component;

begin

spi_mast : SPI_Master port map(

i_data          =>          i_data        ,
i_sck           =>          i_sck         ,
i_miso          =>          miso          ,
i_ss            =>          i_ss          ,
i_rst           =>          i_rst         ,
o_mosi          =>          mosi)         ;


spii_slave : SPI_Slave port map(
i_sck          =>           i_sck         ,
i_mosi         =>           mosi          ,
i_ss           =>           i_ss          ,
i_rst          =>           i_rst         ,
o_miso         =>           miso)         ;

end Behavioral;
